/* Copyright Urban Airship and Contributors */

#import <Foundation/Foundation.h>

@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

/**
 * Deep link delegate method.
 */
@protocol TiAirshipDeepLinkDelegate <NSObject>

/**
 * Called when a new deep link is received.
 * @param deepLink The deep link.
 */
- (void)deepLinkReceived:(nonnull NSString *)deepLink;

@end


/**
 * Custom deep link action that forwards incoming deep links to a delegate.
 */
@interface TiAirshipDeepLinkAction : UADeepLinkAction

+ (TiAirshipDeepLinkAction *)shared;

/**
 * Deep link string.
 */
@property (nonatomic, copy) NSString *deepLink;

/**
  * Deep link delegate.
 */
@property (nonatomic, strong, nullable) id<TiAirshipDeepLinkDelegate> deepLinkDelegate;

@end

NS_ASSUME_NONNULL_END
