/* Copyright Airship and Contributors */

#import "TiAirshipNotificationResponse.h"
#import "TiAirshipUtils.h"

@interface TiAirshipNotificationResponse()
@property (nonatomic, copy) NSDictionary *payload;
@end

@implementation TiAirshipNotificationResponse

- (instancetype)initWithPayload:(NSDictionary *)payload {
    self = [super init];
    if (self) {
        self.payload = payload;
    }
    return self;
}

+ (instancetype)tiResponseFromNotificationResponse:(nullable UNNotificationResponse *)response {
    id payload = [TiAirshipUtils eventBodyForNotificationResponse:response];
    return [[self alloc] initWithPayload:payload];
}

@end
