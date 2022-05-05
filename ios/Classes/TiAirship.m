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
                                             selector:@selector(channelRegistrationSucceeded)
                                                 name:UAChannel.channelCreatedEvent
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(channelRegistrationSucceeded)
                                                 name:UAChannel.channelUpdatedEvent
                                               object:nil];

    // Register the plugin with analytics
    [UAirship.analytics registerSDKExtension:UASDKExtensionTitanium
                                     version:[TiAirshipModuleVersion get]];

    self.launchNotificationResponse = [TiAirshipNotificationResponse tiResponseFromNotificationResponse:[UAirship push].launchNotificationResponse];
}

#pragma mark UAPushNotificationDelegate

- (void)receivedForegroundNotification:(NSDictionary * _Nonnull)userInfo
                     completionHandler:(void (^ _Nonnull)(void))completionHandler {
    id tiPush = [TiAirshipPush tiPushFromNotificationContent:userInfo];
    id event = [TiAirshipPushReceivedEvent eventWithPush:tiPush foreground:YES];
    [self.eventEmitter fireEvent:event];
    completionHandler();
}

- (void)receivedBackgroundNotification:(NSDictionary * _Nonnull)userInfo
                     completionHandler:(void (^ _Nonnull)(UIBackgroundFetchResult))completionHandler {
    id tiPush = [TiAirshipPush tiPushFromNotificationContent:userInfo];
    id event = [TiAirshipPushReceivedEvent eventWithPush:tiPush foreground:NO];
    [self.eventEmitter fireEvent:event];
}

- (void)receivedNotificationResponse:(UNNotificationResponse * _Nonnull)notificationResponse
                   completionHandler:(void (^ _Nonnull)(void))completionHandler {
    id tiResponse =  [TiAirshipNotificationResponse tiResponseFromNotificationResponse:notificationResponse];
    self.launchNotificationResponse = tiResponse;

    id event = [TiAirshipNotificationResponseEvent eventWithResponse:tiResponse];
    [self.eventEmitter fireEvent:event];
    completionHandler();
}

#pragma mark UARegistrationDelegate

- (void)notificationAuthorizedSettingsDidChange:(UAAuthorizedNotificationSettings)authorizedSettings {
    id event = [TiAirshipNotificationOptInChangedEvent eventWithAuthroizedSettings:authorizedSettings];
    [self.eventEmitter fireEvent:event];
}

#pragma mark Channel Registration

- (void)channelRegistrationSucceeded {
    NSString *channelID = UAirship.channel.identifier;
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
