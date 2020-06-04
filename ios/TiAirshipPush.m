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

+ (instancetype)pushFromNotificationResponse:(nullable UANotificationResponse *)response {
    id payload = [self parsePayload:response.notificationContent.notificationInfo];
    return [[self alloc] initWithPayload:payload];
}

+ (instancetype)pushFromNotificationContent:(nullable UANotificationContent *)notificationContent {
    id payload = [self parsePayload:notificationContent.notificationInfo];
    return [[self alloc] initWithPayload:payload];
}

+ (nonnull NSDictionary *)parsePayload:(nullable NSDictionary *)notificationInfo {
    NSString *incomingAlert = @"";
    NSMutableDictionary *incomingExtras = [NSMutableDictionary dictionary];

    if (notificationInfo) {
        incomingAlert = [self alertForUserInfo:notificationInfo];
        [incomingExtras setDictionary:[self extrasForUserInfo:notificationInfo]];
    }

    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
    [payload setValue:incomingAlert forKey:@"message"];
    [payload setValue:incomingExtras forKey:@"extras"];
    return payload;
}

/**
 * Helper method to parse the alert from a notification.
 *
 * @param userInfo The notification.
 * @return The notification's alert.
 */
+ (NSString *)alertForUserInfo:(NSDictionary *)userInfo {
    NSString *alert = @"";

    if ([[userInfo allKeys] containsObject:@"aps"]) {
        NSDictionary *apsDict = [userInfo objectForKey:@"aps"];
        //TODO: what do we want to do in the case of a localized alert dictionary?
        if ([[apsDict valueForKey:@"alert"] isKindOfClass:[NSString class]]) {
            alert = [apsDict valueForKey:@"alert"];
        }
    }

    return alert;
}

/**
 * Helper method to parse the extras from a notification.
 *
 * @param userInfo The notification.
 * @return The notification's extras.
 */
+ (NSMutableDictionary *)extrasForUserInfo:(NSDictionary *)userInfo {

    // remove extraneous key/value pairs
    NSMutableDictionary *extras = [NSMutableDictionary dictionaryWithDictionary:userInfo];

    if([[extras allKeys] containsObject:@"aps"]) {
        [extras removeObjectForKey:@"aps"];
    }
    if([[extras allKeys] containsObject:@"_"]) {
        [extras removeObjectForKey:@"_"];
    }

    return extras;
}


@end
