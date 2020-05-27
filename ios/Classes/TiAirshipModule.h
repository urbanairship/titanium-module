/* Copyright Urban Airship and Contributors */

#import "TiModule.h"
#import "TiAirshipDeeplink.h"

NS_ASSUME_NONNULL_BEGIN

@import AirshipCore;
@import AirshipMessageCenter;

@interface TiAirshipModule : TiModule <UAPushNotificationDelegate, TiAirshipDeepLinkDelegate>;

NS_ASSUME_NONNULL_END

@end
