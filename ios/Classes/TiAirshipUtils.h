/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

@interface TiAirshipUtils : NSObject

+ (NSDictionary *)authorizedNotificationsDictionary:(UAAuthorizedNotificationSettings)authorizedSettings;

@end

NS_ASSUME_NONNULL_END
