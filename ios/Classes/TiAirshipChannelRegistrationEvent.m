/* Copyright Airship and Contributors */

#import "TiAirshipChannelRegistrationEvent.h"

NSString *const TiAirshipChannelRegistrationEventName = @"EVENT_CHANNEL_UPDATED";

@interface TiAirshipChannelRegistrationEvent()
@property (nonatomic, copy) NSDictionary *data;
@end

@implementation TiAirshipChannelRegistrationEvent

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

+ (instancetype)eventWithChannel:(NSString *)channel
                     deviceToken:(nullable NSString *)deviceToken {
    NSDictionary *data;
    if (deviceToken) {
        data = @{ @"channelId": channel,
                  @"deviceToken": deviceToken,
                  @"pushToken": deviceToken };
    } else {
        data = @{ @"channelId": channel };
    }
    return [[self alloc] initWithData:data];
}


- (nonnull id)eventData {
    return self.data;
}

- (nonnull NSString *)eventName {
    return TiAirshipChannelRegistrationEventName;
}

@end

