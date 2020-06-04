/* Copyright Airship and Contributors */

#import "TiAirshipEventEmitter.h"
#import "TiProxy.h"
#import "TiAirshipEvent.h"
#import "TiApp.h"

@interface TiAirshipEventListeners : NSObject
@property (nonatomic, weak) TiProxy *proxy;
@property (nonatomic, strong) NSMutableDictionary *listeners;

- (void)addListenersrForEvent:(NSString *)event
                        count:(NSUInteger)count;

- (void)removeListenersrForEvent:(NSString *)event
                           count:(NSUInteger)count;

- (BOOL)fireEvent:(id<TiAirshipEvent>)event;

@end


@implementation TiAirshipEventListeners

- (instancetype)init {
    self = [super init];
    if (self) {
        self.listeners = [NSMutableDictionary dictionary];
    }
    return self;
}
- (void)addListenersForEvent:(NSString *)event
                       count:(NSUInteger)count {
    NSUInteger current = [self.listeners[event] unsignedIntegerValue];
    current += count;
    self.listeners[event] = @(current);
}

- (void)removeListenersForEvent:(NSString *)event
                          count:(NSUInteger)count {
    NSUInteger current = [self.listeners[event] unsignedIntegerValue];
    current -= count;
    self.listeners[event] = @(current);
}

- (BOOL)fireEvent:(id<TiAirshipEvent>)event {
    if (![self.listeners[event.eventName] unsignedIntegerValue] || !self.proxy) {
        return false;
    }

    [self.proxy fireEvent:event.eventName withObject:event.eventData];
    return true;
}

@end

@interface TiAirshipEventEmitter()
@property (nonatomic, strong) NSMapTable *listenerMap;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *pendingEvents;
@end

@implementation TiAirshipEventEmitter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.listenerMap = [NSMapTable weakToStrongObjectsMapTable];
        self.pendingEvents = [NSMutableDictionary dictionary];
    }

    return self;
}

-(void)addListenerForEvent:(NSString *)event
                     count:(NSUInteger)count
                     proxy:(TiProxy *)proxy {
    @synchronized (self) {
        TiAirshipEventListeners *listeners  = [self.listenerMap objectForKey:proxy];
        if (!listeners) {
            listeners = [[TiAirshipEventListeners alloc] init];
            listeners.proxy = proxy;
            [self.listenerMap setObject:listeners forKey:proxy];
        }

        [listeners addListenersForEvent:event count:count];

        id pendingEvents = self.pendingEvents[event];
        [self.pendingEvents removeObjectForKey:event];

        for (id pendingEvent in pendingEvents) {
            [self fireEvent:pendingEvent];
        }
    }
}

-(void)removeListenerForEvent:(NSString *)event
                        count:(NSUInteger)count
                        proxy:(TiProxy *)proxy {
    @synchronized (self) {
        TiAirshipEventListeners *listeners  = [self.listenerMap objectForKey:proxy];
        [listeners removeListenersForEvent:event count:count];
    }
}

-(void)fireEvent:(id<TiAirshipEvent>)event {
    @synchronized (self) {
        BOOL success = NO;
        for (id key in self.listenerMap) {
            TiAirshipEventListeners *listeners  = [self.listenerMap objectForKey:key];
            if ([listeners fireEvent:event]) {
                success = YES;
            }
        }

        if (!success) {
            if (!self.pendingEvents[event.eventName]) {
                self.pendingEvents[event.eventName] = [NSMutableArray array];
            }
            [self.pendingEvents[event.eventName] addObject:event];
        }
    }
}

@end


