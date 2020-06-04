/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiAirshipEvent.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TiAirshipDeepLinkEventName;

@interface TiAirshipDeepLinkEvent : NSObject

+ (instancetype)eventWithDeepLink:(NSString *)deepLink;

@end

NS_ASSUME_NONNULL_END
