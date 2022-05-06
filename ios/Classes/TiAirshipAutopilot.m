/* Copyright Airship and Contributors */

#import "TiAirshipAutopilot.h"
#import "TiAirship.h"

@import TitaniumKit;
@import AirshipCore;

@implementation TiAirshipAutopilot

- (void)load {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                      object:nil
                                                       queue:nil usingBlock:^(NSNotification * _Nonnull note) {

        [self attemptTakeOffWithLaunchOptions:note.userInfo];
    }];
}

// Config keys
static NSString *const ProductionAppKeyConfigKey = @"com.urbanairship.production_app_key";
static NSString *const ProductionAppSecretConfigKey = @"com.urbanairship.production_app_secret";
static NSString *const DevelopmentAppKeyConfigKey = @"com.urbanairship.development_app_key";
static NSString *const DevelopmentAppSecretConfigKey = @"com.urbanairship.development_app_secret";
static NSString *const ProductionConfigKey = @"com.urbanairship.in_production";
static NSString *const NotificationPresentationAlertKey = @"com.urbanairship.ios_foreground_notification_presentation_alert";
static NSString *const NotificationPresentationBadgeKey = @"com.urbanairship.ios_foreground_notification_presentation_badge";
static NSString *const NotificationPresentationSoundKey = @"com.urbanairship.ios_foreground_notification_presentation_sound";

static NSString *const DataCollectionOptInKey = @"com.urbanairship.data_collection_opt_in_enabled";
static NSString *const CloudSiteConfigKey = @"com.urbanairship.site";
static NSString *const CloudSiteEUString = @"EU";

- (void)attemptTakeOffWithLaunchOptions:(NSDictionary *)launchOptions {
    NSDictionary *appProperties = [TiApp tiAppProperties];
    UAConfig *config = [UAConfig defaultConfig];

    config.productionAppKey = appProperties[ProductionAppKeyConfigKey];
    config.productionAppSecret = appProperties[ProductionAppSecretConfigKey];
    config.developmentAppKey = appProperties[DevelopmentAppKeyConfigKey];
    config.developmentAppSecret = appProperties[DevelopmentAppSecretConfigKey];
    config.inProduction = [appProperties[ProductionConfigKey] boolValue];
    config.site = [TiAirshipAutopilot parseCloudSiteString:appProperties[CloudSiteConfigKey]];
    config.URLAllowListScopeOpenURL = @[@"*"];

    [UAirship takeOff:config launchOptions:launchOptions];

    // Set the iOS default foreground presentation options if specified in the tiapp.xml else default to None
    UNNotificationPresentationOptions options = UNNotificationPresentationOptionNone;

    if (appProperties[NotificationPresentationAlertKey]) {
        if ([appProperties[NotificationPresentationAlertKey] boolValue]) {
            options = options | UNNotificationPresentationOptionAlert;
        }
    }

    if (appProperties[NotificationPresentationBadgeKey] != nil) {
        if ([appProperties[NotificationPresentationBadgeKey] boolValue]) {
            options = options | UNNotificationPresentationOptionBadge;
        }
    }

    if (appProperties[NotificationPresentationSoundKey] != nil) {
        if ([appProperties[NotificationPresentationSoundKey] boolValue]) {
            options = options | UNNotificationPresentationOptionSound;
        }
    }

    UA_LDEBUG(@"Foreground presentation options: %lu", (unsigned long)options);

    [UAirship push].defaultPresentationOptions = options;

    [[TiAirship shared] takeOff];
}

+ (UACloudSite)parseCloudSiteString:(NSString *)site {
    if ([CloudSiteEUString caseInsensitiveCompare:site] == NSOrderedSame) {
        return UACloudSiteEU;
    } else {
        return UACloudSiteUS;
    }
}

@end
