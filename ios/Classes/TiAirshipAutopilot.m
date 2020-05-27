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

#pragma mark - Method Swizzling

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    // Fixes crash in Titanium
}

+ (void)didFinishLaunching {
    static dispatch_once_t takeoOffOnceToken_;

    dispatch_once(&takeoOffOnceToken_, ^{
        [self performTakeOff];
    });
}

+ (void)performTakeOff {
    // Titanium forwards application:didReceiveRemoteNotification:fetchCompletionHandler: to
    // application:didReceiveRemoteNotification:, however that method is not defined. We will
    // add the method if missing.
    id delegate = [UIApplication sharedApplication].delegate;
    if (delegate && ![delegate respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {

        Method delegateMethod = class_getInstanceMethod([self class], @selector(application:didReceiveRemoteNotification:));

        BOOL swizzled = class_addMethod([delegate class],
                        @selector(application:didReceiveRemoteNotification:),
                        method_getImplementation(delegateMethod),
                        method_getTypeEncoding(delegateMethod));
    }

    NSDictionary *appProperties = [TiApp tiAppProperties];
    UAConfig *config = [UAConfig defaultConfig];

    config.productionAppKey = appProperties[ProductionAppKeyConfigKey];
    config.productionAppSecret = appProperties[ProductionAppSecretConfigKey];
    config.developmentAppKey = appProperties[DevelopmentAppKeyConfigKey];
    config.developmentAppSecret = appProperties[DevelopmentAppSecretConfigKey];
    config.inProduction = [appProperties[ProductionConfigKey] boolValue];
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
