/* Copyright Airship and Contributors */

#import "TiAirshipDeepLinkEvent.h"

NSString *const TiAirshipDeepLinkEventName = @"EVENT_DEEP_LINK_RECEIVED";

@interface TiAirshipDeepLinkEvent()
@property (nonatomic, copy) NSDictionary *data;
@end

@implementation TiAirshipDeepLinkEvent

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

+(instancetype)eventWithDeepLink:(NSString *)deepLink {
    id data = @{ @"deepLink" : deepLink };
    return [[self alloc] initWithData:data];
}

- (nonnull id)eventData {
    return self.data;
}

- (nonnull NSString *)eventName {
    return TiAirshipDeepLinkEventName;
}

@end
