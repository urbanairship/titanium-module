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

/**
 * Custom deep link action that forwards incoming deep links to a delegate.
 */
@interface UADeepLinkAction : UAAction

/**
    * Deep link delegate.
 */
@property (nonatomic, weak, nullable) id<UADeepLinkDelegate> deepLinkDelegate;

@end
