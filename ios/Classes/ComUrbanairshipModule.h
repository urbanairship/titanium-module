/*
 Copyright 2017 Urban Airship and Contributors
*/

#import "TiModule.h"
#import "UAPush.h"
#import "ComUrbanAirshipDeeplink.h"

@interface ComUrbanairshipModule : TiModule <UAPushNotificationDelegate, UARegistrationDelegate, UADeepLinkDelegate>


@end
