/* Copyright 2017 Urban Airship and Contributors */

#import "ComUrbanairshipDeeplink.h"

@implementation ComUrbanAirshipDeepLinkAction


+(ComUrbanAirshipDeepLinkAction *)shared {
  static dispatch_once_t pred_;
  static ComUrbanAirshipDeepLinkAction *sharedInstance_;
  dispatch_once(&pred, ^{
    sharedInstance_ = [ComUrbanAirshipDeepLinkAction alloc] init];
  });

  return sharedInstance_;
}

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

        self.deepLink = deepLink;
        if (self.delegate) {
          [self.delegate deepLinkReceived:deepLink];
        }

        completionHandler([UAActionResult resultWithValue:arguments.value]);
    }
}

@end
