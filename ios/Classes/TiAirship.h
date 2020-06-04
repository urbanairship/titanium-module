/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiAirshipEventEmitter.h"
#import "TiAirshipPush.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Handles listeners and plugin state for the module. Needed
 * since the module lifecycle does not match the app lifecycle.
 */
@interface TiAirship : NSObject

@property (nonatomic, copy, nullable) NSString *deepLink;
@property (nonatomic, strong, nullable) TiAirshipPush *launchPush;
@property (nonatomic, readonly) TiAirshipEventEmitter *eventEmitter;

+ (TiAirship *)shared;

/**
 * Called in autpilot after Airship is ready.
 */
- (void)takeOff;

@end

NS_ASSUME_NONNULL_END
