/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiAirshipEvent.h"
#import "TiAirshipNotificationResponse.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TiAirshipNotificationResponseEventName;

@interface TiAirshipNotificationResponseEvent : NSObject <TiAirshipEvent>

+ (instancetype)eventWithResponse:(TiAirshipNotificationResponse *)response;

@end

NS_ASSUME_NONNULL_END
