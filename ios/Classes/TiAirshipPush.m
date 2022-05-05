/* Copyright Airship and Contributors */

#import "TiAirshipPush.h"
#import "TiAirshipUtils.h"

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
    id payload = [TiAirshipUtils eventBodyForNotificationContent:userInfo notificationIdentifier:nil];
    return [[self alloc] initWithPayload:payload];
}

@end
