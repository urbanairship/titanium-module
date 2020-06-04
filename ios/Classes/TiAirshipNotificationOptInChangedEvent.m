/* Copyright Airship and Contributors */

#import "TiAirshipNotificationOptInChangedEvent.h"
#import "TiAirshipUtils.h"

NSString *const TiAirshipNotificationOptInChangedEventName = @"EVENT_NOTIFICATION_OPT_IN_CHANGED";

@interface TiAirshipNotificationOptInChangedEvent()
@property (nonatomic, copy) NSDictionary *data;
@end

@implementation TiAirshipNotificationOptInChangedEvent

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

+(instancetype)eventWithAuthroizedSettings:(UAAuthorizedNotificationSettings)authorizedSettings {
    id data = @{
        @"optIn": @(authorizedSettings != UAAuthorizedNotificationSettingsNone),
        @"authorizedSettings": [TiAirshipUtils authorizedNotificationsDictionary:authorizedSettings]
    };
    return [[self alloc] initWithData:data];
}

- (nonnull id)eventData {
    return self.data;
}

- (nonnull NSString *)eventName {
    return TiAirshipNotificationOptInChangedEventName;
}


@end
