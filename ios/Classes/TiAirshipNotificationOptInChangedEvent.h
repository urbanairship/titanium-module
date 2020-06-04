/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiAirshipEvent.h"

@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TiAirshipNotificationOptInChangedEventName;

@interface TiAirshipNotificationOptInChangedEvent : NSObject <TiAirshipEvent>

+ (instancetype)eventWithAuthroizedSettings:(UAAuthorizedNotificationSettings)settings;

@end

NS_ASSUME_NONNULL_END
