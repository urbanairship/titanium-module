/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiProxy.h"
#import "TiAirshipEvent.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Event emitter that handles queuing and resending events if there are no active
 * listeners for the event type.
 */
@interface TiAirshipEventEmitter : NSObject

-(void)addListenerForEvent:(NSString *)event
                     count:(NSUInteger)count
                     proxy:(TiProxy *)proxy;

-(void)removeListenerForEvent:(NSString *)event
                        count:(NSUInteger)count
                        proxy:(TiProxy *)proxy;

-(void)fireEvent:(id<TiAirshipEvent>)event;

@end

NS_ASSUME_NONNULL_END
