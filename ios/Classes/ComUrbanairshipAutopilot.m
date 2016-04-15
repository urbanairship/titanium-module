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
    [center addObserver:[ComUrbanairshipAutopilot class] selector:@selector(performTakeOff:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

// Config keys
NSString *const ProductionAppKeyConfigKey = @"com.urbanairship.production_app_key";
NSString *const ProductionAppSecretConfigKey = @"com.urbanairship.production_app_secret";
NSString *const DevelopmentAppKeyConfigKey = @"com.urbanairship.development_app_key";
NSString *const DevelopmentAppSecretConfigKey = @"com.urbanairship.development_app_secret";
NSString *const ProductionConfigKey = @"com.urbanairship.in_production";

+ (NSBundle *)resources {
    static dispatch_once_t onceToken;
    static dispatch_once_t resourcesBundle_;

    dispatch_once(&onceToken, ^{
        // Don't assume that we are within the main bundle
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"modules/com.urbanairship/AirshipResources.bundle"];

        resourcesBundle_ = [NSBundle bundleWithPath:path];
        if (!resourcesBundle_) {
            UA_LIMPERR(@"AirshipResources.bundle could not be found.");
        }
    });
    return resourcesBundle_;
}

+ (void)performTakeOff:(NSNotification *)notification {
    // Need to change where UAirship looks for the AirshipResources.bundle
    const char *airshipClassName = [NSStringFromClass([UAirship class]) UTF8String];
    const char *moduleClassName = [NSStringFromClass([ComUrbanairshipAutopilot class]) UTF8String];

    Method swizzleMethod = class_getClassMethod(objc_getMetaClass(moduleClassName), @selector(resources));
    class_replaceMethod(objc_getMetaClass(airshipClassName),
                        @selector(resources),
                        method_getImplementation(swizzleMethod),
                        method_getTypeEncoding(swizzleMethod));


    NSDictionary *appProperties = [TiApp tiAppProperties];
    UAConfig *config = [UAConfig defaultConfig];
    config.developmentAppKey = appProperties[DevelopmentAppKeyConfigKey];
    config.productionAppKey = appProperties[ProductionAppKeyConfigKey];
    config.productionAppSecret = appProperties[ProductionAppSecretConfigKey];
    config.developmentAppKey = appProperties[DevelopmentAppKeyConfigKey];
    config.developmentAppSecret = appProperties[DevelopmentAppSecretConfigKey];
    config.inProduction = [appProperties[ProductionConfigKey] boolValue];

    [UAirship takeOff:config];
}


@end
