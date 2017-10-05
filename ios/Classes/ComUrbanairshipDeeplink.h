/* Copyright 2017 Urban Airship and Contributors */

#import "AirshipLib.h"
#import <CoreData/CoreData.h>


/**
 * Deep link delegate method.
 */
@protocol UADeepLinkDelegate <NSObject>

/**
 * Called when a new deep link is received.
 * @param deepLink The deep link.
 */
- (void)deepLinkReceived:(NSString *)deepLink;

@end

+(ComUrbanAirshipDeepLinkAction *)shared;

/**
 * Custom deep link action that forwards incoming deep links to a delegate.
 */
@interface ComUrbanAirshipDeepLinkAction : UADeepLinkAction

@property (nonatomic, copy) NSString *deepLink;

/**
  * Deep link delegate.
 */
@property (nonatomic, strong, nullable) id<UADeepLinkDelegate> deepLinkDelegate;

@end
