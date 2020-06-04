/* Copyright Airship and Contributors */

#import "TiAirshipUtils.h"

@implementation TiAirshipUtils

+ (NSDictionary *)authorizedNotificationsDictionary:(UAAuthorizedNotificationSettings)authorizedSettings {
    return @{
        @"alert": @((authorizedSettings & UAAuthorizedNotificationSettingsAlert) != 0),
        @"badge": @((authorizedSettings & UAAuthorizedNotificationSettingsBadge) != 0),
        @"sound": @((authorizedSettings & UAAuthorizedNotificationSettingsSound) != 0),
        @"lockScreen": @((authorizedSettings & UAAuthorizedNotificationSettingsLockScreen) != 0),
        @"carPlayBool": @((authorizedSettings & UAAuthorizedNotificationSettingsCarPlay) != 0),
        @"notificationCenter": @((authorizedSettings & UAAuthorizedNotificationSettingsNotificationCenter) != 0),
        @"announcement": @((authorizedSettings & UAAuthorizedNotificationSettingsAnnouncement) != 0),
        @"criticalAlert": @((authorizedSettings & UAAuthorizedNotificationSettingsCriticalAlert) != 0)
    };
}

@end
