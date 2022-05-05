/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

@interface TiAirshipUtils : NSObject

+ (UANotificationOptions)optionsFromOptionsArray:(NSArray *)options;
+ (NSArray<NSString *> *)authorizedSettingsArray:(UAAuthorizedNotificationSettings)settings;
+ (NSString *)authorizedStatusString:(UAAuthorizationStatus)status;


+ (NSDictionary *)eventBodyForNotificationContent:(NSDictionary *)userInfo notificationIdentifier:(nullable NSString *)identifier;

+ (NSDictionary *)eventBodyForNotificationResponse:(UNNotificationResponse *)notificationResponse;

+ (UAFeatures)stringArrayToFeatures:(NSArray *)stringArray;
+ (NSArray *)featureToStringArray:(UAFeatures)features;
+ (BOOL)isValidFeatureArray:(NSArray *)stringArray;
@end

NS_ASSUME_NONNULL_END
