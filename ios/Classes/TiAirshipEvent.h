/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TiAirshipEvent <NSObject>

- (NSString *)eventName;
- (id)eventData;

@end

NS_ASSUME_NONNULL_END
