/* Copyright Urban Airship and Contributors */

#import "TiModule.h"
#import "UAPush.h"
#import "ComUrbanairshipDeeplink.h"

@interface ComUrbanairshipModule : TiModule <UAPushNotificationDelegate, UARegistrationDelegate, UADeepLinkDelegate>


@end
