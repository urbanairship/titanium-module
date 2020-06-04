/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

/**
 * Wraps Airship push.
 */
@interface TiAirshipPush : NSObject

+ (instancetype)pushFromNotificationResponse:(nullable UANotificationResponse *)notificationResponse;

+ (instancetype)pushFromNotificationContent:(nullable UANotificationContent *)notificationContent;

@property (readonly, copy) NSDictionary *payload;
@end

NS_ASSUME_NONNULL_END
