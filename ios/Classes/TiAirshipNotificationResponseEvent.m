/* Copyright Airship and Contributors */

#import "TiAirshipNotificationResponseEvent.h"

NSString *const TiAirshipNotificationResponseEventName = @"EVENT_NOTIFICATION_RESPONSE";

@interface TiAirshipNotificationResponseEvent()
@property (nonatomic, copy) NSDictionary *data;
@end

@implementation TiAirshipNotificationResponseEvent

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

+ (instancetype)eventWithResponse:(TiAirshipNotificationResponse *)response {
    return [[self alloc] initWithData:response.payload];
}

- (nonnull id)eventData {
    return self.data;
}

- (nonnull NSString *)eventName {
    return TiAirshipNotificationResponseEventName;
}

@end
