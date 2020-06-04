/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

/**
 * Wraps Airship push.
 */
@interface TiAirshipPush : NSObject

@property (readonly, copy) NSDictionary *payload;

+ (instancetype)tiPushFromNotificationContent:(nullable UANotificationContent *)notificationContent;

@end

NS_ASSUME_NONNULL_END
