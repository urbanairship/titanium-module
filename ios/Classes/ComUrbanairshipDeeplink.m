/* Copyright 2017 Urban Airship and Contributors */

#import "ComUrbanairshipDeeplink.h"

@implementation ComUrbanAirshipDeepLinkAction

- (BOOL)acceptsArguments:(UAActionArguments *)arguments {
    if (arguments.situation == UASituationBackgroundPush || arguments.situation == UASituationBackgroundInteractiveButton) {
        return NO;
    }
    return [arguments.value isKindOfClass:[NSURL class]] || [arguments.value isKindOfClass:[NSString class]];
}


- (void)performWithArguments:(UAActionArguments *)arguments completionHandler:(UAActionCompletionHandler)completionHandler {
    NSString *deepLink;

    if (![arguments.value isEqual:nil]) {
        if([arguments.value isKindOfClass:[NSURL class]]) {
            deepLink = [arguments.value absoluteString];
        }   else {
            deepLink = arguments.value;
        }

        if (self.deepLinkDelegate) {
          [self.deepLinkDelegate deepLinkReceived:deepLink];
        }

        completionHandler([UAActionResult resultWithValue:arguments.value]);
    }
}

@end
