/* Copyright Airship and Contributors */

#import "TiAirshipPushReceivedEvent.h"

NSString *const TiAirshipPushReceivedEventName = @"EVENT_PUSH_RECEIVED";

@interface TiAirshipPushReceivedEvent()
@property (nonatomic, copy) NSDictionary *data;
@end

@implementation TiAirshipPushReceivedEvent

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

+ (instancetype)eventWithPush:(TiAirshipPush *)push {
    return [[self alloc] initWithData:push.payload];
}

- (nonnull id)eventData {
    return self.data;
}

- (nonnull NSString *)eventName {
    return TiAirshipPushReceivedEventName;
}

@end
