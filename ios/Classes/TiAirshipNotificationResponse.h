
#import <Foundation/Foundation.h>

@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

@interface TiAirshipNotificationResponse : NSObject

@property (readonly, copy) NSDictionary *payload;

+ (instancetype)tiResponseFromNotificationResponse:(nullable UANotificationResponse *)notificationResponse;

@end

NS_ASSUME_NONNULL_END
