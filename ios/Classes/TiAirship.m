/* Copyright Airship and Contributors */

#import "TiAirship.h"
#import "TiAirshipPush.h"
#import "TiAirshipPushReceivedEvent.h"
#import "TiAirshipDeepLinkEvent.h"
#import "TiAirshipChannelRegistrationEvent.h"

@import AirshipCore;

static TiAirship *shared_;
static dispatch_once_t onceToken;

@interface TiAirship() <UAPushNotificationDelegate, UADeepLinkDelegate>
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
    [UAirship shared].deepLinkDelegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(channelRegistrationSucceeded:)
                                                 name:UAChannelUpdatedEvent
                                               object:nil];

    self.launchPush = [TiAirshipPush pushFromNotificationResponse:[UAirship push].launchNotificationResponse];
}

#pragma mark UAPushNotificationDelegate

- (void)receivedNotificationResponse:(UANotificationResponse *)notificationResponse completionHandler:(void(^)(void))completionHandler {
    UA_LDEBUG(@"The application was launched or resumed from a notification %@", notificationResponse);
    self.launchPush = [TiAirshipPush pushFromNotificationResponse:notificationResponse];
    completionHandler();
}

- (void)receivedForegroundNotification:(UANotificationContent *)notificationContent completionHandler:(void(^)(void))completionHandler {
    UA_LDEBUG(@"Received a notification while the app was already in the foreground %@", notificationContent);

    [[UAirship push] setBadgeNumber:0]; // zero badge after push received

    id tiPush = [TiAirshipPush pushFromNotificationContent:notificationContent];
    id event = [TiAirshipPushReceivedEvent eventWithPush:tiPush];
    [self.eventEmitter fireEvent:event];
    completionHandler();
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
