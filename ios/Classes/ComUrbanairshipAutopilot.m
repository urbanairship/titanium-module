/*
 Copyright 2016 Urban Airship and Contributors
*/

#import "ComUrbanairshipAutopilot.h"
#import "AirshipLib.h"
#import "TiApp.h"
#import <objc/runtime.h>

@implementation ComUrbanairshipAutopilot

+ (void)load {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:[ComUrbanairshipAutopilot class] selector:@selector(didFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

// Config keys
NSString *const ProductionAppKeyConfigKey = @"com.urbanairship.production_app_key";
NSString *const ProductionAppSecretConfigKey = @"com.urbanairship.production_app_secret";
NSString *const DevelopmentAppKeyConfigKey = @"com.urbanairship.development_app_key";
NSString *const DevelopmentAppSecretConfigKey = @"com.urbanairship.development_app_secret";
NSString *const ProductionConfigKey = @"com.urbanairship.in_production";
NSString *const NotificationPresentationAlertKey = @"com.urbanairship.ios_foreground_notification_presentation_alert";
NSString *const NotificationPresentationBadgeKey = @"com.urbanairship.ios_foreground_notification_presentation_badge";
NSString *const NotificationPresentationSoundKey = @"com.urbanairship.ios_foreground_notification_presentation_sound";

+ (NSBundle *)resources {
    static dispatch_once_t resourceDispatchOnceToken_;
    static NSBundle *resourcesBundle_;

    dispatch_once(&resourceDispatchOnceToken_, ^{
        // Don't assume that we are within the main bundle
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"modules/com.urbanairship/AirshipResources.bundle"];

        resourcesBundle_ = [NSBundle bundleWithPath:path];
        if (!resourcesBundle_) {
            UA_LIMPERR(@"AirshipResources.bundle could not be found.");
        }
    });

    return resourcesBundle_;
}


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
    // Need to change where UAirship looks for the AirshipResources.bundle
    const char *airshipClassName = [NSStringFromClass([UAirship class]) UTF8String];
    const char *moduleClassName = [NSStringFromClass([ComUrbanairshipAutopilot class]) UTF8String];

    Method swizzleMethod = class_getClassMethod(objc_getMetaClass(moduleClassName), @selector(resources));
    class_replaceMethod(objc_getMetaClass(airshipClassName),
                        @selector(resources),
                        method_getImplementation(swizzleMethod),
                        method_getTypeEncoding(swizzleMethod));


    // Titanium forwards application:didReceiveRemoteNotification:fetchCompletionHandler: to
    // application:didReceiveRemoteNotification:, however that method is not defined. We will
    // add the method if missing.
    id delegate = [UIApplication sharedApplication].delegate;
    if (delegate && ![delegate respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {

        Method delegateMethod = class_getInstanceMethod([ComUrbanairshipAutopilot class], @selector(application:didReceiveRemoteNotification:));

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
}


@end
