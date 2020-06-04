/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiAirshipEvent.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TiAirshipChannelRegistrationEventName;

@interface TiAirshipChannelRegistrationEvent : NSObject

+ (instancetype)eventWithChannel:(NSString *)channel
                     deviceToken:(nullable NSString *)deviceToken;

@end

NS_ASSUME_NONNULL_END
