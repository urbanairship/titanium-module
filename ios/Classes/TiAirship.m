/* Copyright Airship and Contributors */

#import "TiAirship.h"
#import "TiAirshipPush.h"
#import "TiAirshipPushReceivedEvent.h"
#import "TiAirshipDeepLinkEvent.h"
#import "TiAirshipChannelRegistrationEvent.h"
#import "TiAirshipNotificationResponseEvent.h"
#import "TiAirshipNotificationOptInChangedEvent.h"
#import "TiAirshipModuleVersion.h"


@import AirshipCore;

static TiAirship *shared_;
static dispatch_once_t onceToken;

@interface TiAirship() <UAPushNotificationDelegate, UADeepLinkDelegate, UARegistrationDelegate>
@property (nonatomic, strong) TiAirshipEventEmitter *eventEmitter;
@end

@implementation TiAirship

+ (TiAirship *)shared {
    dispatch_once(&onceToken, ^{
        shared_ = [[TiAirship alloc] init];
    });
    return shared_;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.eventEmitter = [[TiAirshipEventEmitter alloc] init];
    }
    return self;
}

- (void)takeOff {
    [UAirship push].pushNotificationDelegate = self;
    [UAirship push].registrationDelegate = self;
    [UAirship shared].deepLinkDelegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(channelRegistrationSucceeded:)
                                                 name:UAChannelUpdatedEvent
                                               object:nil];


    // Register the plugin with analytics
    [[UAirship shared].analytics registerSDKExtension:UASDKExtensionTitanium version:[TiAirshipModuleVersion get]];

    self.launchNotificationResponse = [TiAirshipNotificationResponse tiResponseFromNotificationResponse:[UAirship push].launchNotificationResponse];
}

#pragma mark UAPushNotificationDelegate

- (void)receivedNotificationResponse:(UANotificationResponse *)notificationResponse completionHandler:(void(^)(void))completionHandler {
    UA_LDEBUG(@"The application was launched or resumed from a notification %@", notificationResponse);

    id tiResponse =  [TiAirshipNotificationResponse tiResponseFromNotificationResponse:notificationResponse];
    self.launchNotificationResponse = tiResponse;

    id event = [TiAirshipNotificationResponseEvent eventWithResponse:tiResponse];
    [self.eventEmitter fireEvent:event];
    completionHandler();
}

- (void)receivedBackgroundNotification:(UANotificationContent *)notificationContent
                     completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    UA_LDEBUG(@"Received a background notification %@", notificationContent);
    id tiPush = [TiAirshipPush tiPushFromNotificationContent:notificationContent];
    id event = [TiAirshipPushReceivedEvent eventWithPush:tiPush foreground:NO];
    [self.eventEmitter fireEvent:event];
}

- (void)receivedForegroundNotification:(UANotificationContent *)notificationContent
                     completionHandler:(void(^)(void))completionHandler {
    UA_LDEBUG(@"Received a foreground notification %@", notificationContent);
    id tiPush = [TiAirshipPush tiPushFromNotificationContent:notificationContent];
    id event = [TiAirshipPushReceivedEvent eventWithPush:tiPush foreground:YES];
    [self.eventEmitter fireEvent:event];
    completionHandler();
}

#pragma mark UARegistrationDelegate

- (void)notificationAuthorizedSettingsDidChange:(UAAuthorizedNotificationSettings)authorizedSettings {
    id event = [TiAirshipNotificationOptInChangedEvent eventWithAuthroizedSettings:authorizedSettings];
    [self.eventEmitter fireEvent:event];
}

#pragma mark Channel Registration

- (void)channelRegistrationSucceeded:(NSNotification *)notification {
    NSString *channelID = notification.userInfo[UAChannelUpdatedEventChannelKey];
    NSString *deviceToken = [UAirship push].deviceToken;

    UA_LINFO(@"Channel registration successful %@.", channelID);

    id event = [TiAirshipChannelRegistrationEvent eventWithChannel:channelID
                                                       deviceToken:deviceToken];
    [self.eventEmitter fireEvent:event];
}

#pragma mark UADeepLinkDelegate

-(void)receivedDeepLink:(nonnull NSURL *)url
      completionHandler:(nonnull void (^)(void))completionHandler {
    self.deepLink = url.absoluteString;

    id event = [TiAirshipDeepLinkEvent eventWithDeepLink:self.deepLink];
    [self.eventEmitter fireEvent:event];

    completionHandler();
}

@end
