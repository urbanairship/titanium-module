/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

/**
 * Wraps Airship push.
 */
@interface TiAirshipPush : NSObject

+ (instancetype)pushFromNotificaationResponse:(nullable UANotificationResponse *)response;

+ (instancetype)pushFromNotificaationContent:(nullable UANotificationContent *)notificationContent;

@property (readonly, copy) NSDictionary *payload;
@end

NS_ASSUME_NONNULL_END
