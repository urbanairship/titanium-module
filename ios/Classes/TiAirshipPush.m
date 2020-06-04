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

+ (instancetype)tiPushFromNotificationContent:(UANotificationContent *)notificationContent {
    id payload = [self parsePayload:notificationContent];
    return [[self alloc] initWithPayload:payload];
}

+ (nonnull NSDictionary *)parsePayload:(nullable UANotificationContent *)notificationContent {
    if (!notificationContent) {
        return @{};
    }

    // remove extraneous key/value pairs
    NSMutableDictionary *extras = [NSMutableDictionary dictionaryWithDictionary:notificationContent.notificationInfo];

    if([[extras allKeys] containsObject:@"aps"]) {
        [extras removeObjectForKey:@"aps"];
    }

    if([[extras allKeys] containsObject:@"_"]) {
        [extras removeObjectForKey:@"_"];
    }

    NSString *identifier = notificationContent.notification.request.identifier;

    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
    [payload setValue:notificationContent.alertBody forKey:@"message"];
    [payload setValue:notificationContent.alertTitle forKey:@"title"];
    [payload setValue:identifier forKey:@"notificationId"];
    if (extras.count) {
        [payload setValue:extras forKey:@"extras"];
    }
    return payload;
}

@end
