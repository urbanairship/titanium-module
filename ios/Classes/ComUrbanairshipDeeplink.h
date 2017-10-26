/* Copyright 2017 Urban Airship and Contributors */

#import "AirshipLib.h"
#import <CoreData/CoreData.h>

@class ComUrbanAirshipDeepLinkAction;


/**
 * Deep link delegate method.
 */
@protocol UADeepLinkDelegate <NSObject>

/**
 * Called when a new deep link is received.
 * @param deepLink The deep link.
 */
- (void)deepLinkReceived:(nonnull NSString *)deepLink;

@end


/**
 * Custom deep link action that forwards incoming deep links to a delegate.
 */
@interface ComUrbanAirshipDeepLinkAction : UADeepLinkAction

+ (nonnull ComUrbanAirshipDeepLinkAction *)shared;

/**
 * Deep link string.
 */
@property (nonatomic, copy, nonnull) NSString *deepLink;

/**
  * Deep link delegate.
 */
@property (nonatomic, strong, nullable) id<UADeepLinkDelegate> deepLinkDelegate;

@end
