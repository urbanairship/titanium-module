/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiAirshipEvent.h"
#import "TiAirshipPush.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TiAirshipPushReceivedEventName;

@interface TiAirshipPushReceivedEvent : NSObject <TiAirshipEvent>

+ (instancetype)eventWithPush:(TiAirshipPush *)push;

@end

NS_ASSUME_NONNULL_END
