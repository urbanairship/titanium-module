/* Copyright Airship and Contributors */

#import "TiAirshipPush.h"

@interface TiAirshipPush()
@property (nonatomic, copy) NSDictionary *payload;
@end

@implementation TiAirshipPush

- (instancetype)initWithPayload:(NSDictionary *)payload {
    self = [super init];
    if (self) {
        self.payload = payload;
    }
    return self;
}

+ (instancetype)tiPushFromNotificationContent:(NSDictionary *)userInfo {
    id payload = [self parsePayload:userInfo];
    return [[self alloc] initWithPayload:payload];
}

+ (nonnull NSDictionary *)parsePayload:(nullable NSDictionary *)userInfo {
    if (!userInfo) {
        return @{};
    }
//
//    // remove extraneous key/value pairs
//    NSMutableDictionary *extras = [NSMutableDictionary dictionaryWithDictionary:notificationContent.userInfo];
//
//    if([[extras allKeys] containsObject:@"aps"]) {
//        [extras removeObjectForKey:@"aps"];
//    }
//
//    if([[extras allKeys] containsObject:@"_"]) {
//        [extras removeObjectForKey:@"_"];
//    }
//
////TODO:    [payload setValue:identifier forKey:@"notificationId"];
//
//
//    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
//    [payload setValue:notificationContent.body forKey:@"message"];
//    [payload setValue:notificationContent.title forKey:@"title"];
//    if (extras.count) {
//        [payload setValue:extras forKey:@"extras"];
//    }
//    return payload;

    return @{};
}

@end
