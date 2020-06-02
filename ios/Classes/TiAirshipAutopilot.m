/* Copyright Airship and Contributors */

#import "TiAirshipAutopilot.h"
#import "TiApp.h"
#import "TiAirshipDeeplink.h"

#import <objc/runtime.h>

@implementation TiAirshipAutopilot

+ (void)load {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:[self class] selector:@selector(didFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
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

#pragma mark - Method Swizzling

+ (void)didFinishLaunching {
    static dispatch_once_t takeoOffOnceToken_;

    dispatch_once(&takeoOffOnceToken_, ^{
        [self performTakeOff];
    });
}

+ (void)performTakeOff {
    NSDictionary *appProperties = [TiApp tiAppProperties];
    UAConfig *config = [UAConfig defaultConfig];

    config.productionAppKey = appProperties[ProductionAppKeyConfigKey];
    config.productionAppSecret = appProperties[ProductionAppSecretConfigKey];
    config.developmentAppKey = appProperties[DevelopmentAppKeyConfigKey];
    config.developmentAppSecret = appProperties[DevelopmentAppSecretConfigKey];
    config.inProduction = [appProperties[ProductionConfigKey] boolValue];
    config.dataCollectionOptInEnabled = [appProperties[DataCollectionOptInKey] boolValue];
    [UAirship takeOff:config];

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
    [[UAirship shared].actionRegistry updateAction:[TiAirshipDeepLinkAction shared] forEntryWithName:kUADeepLinkActionDefaultRegistryName];
}

@end
