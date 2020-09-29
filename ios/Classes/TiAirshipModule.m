/* Copyright Airship and Contributors */

@import TitaniumKit;
#import "TiAirshipModule.h"
#import "TiAirship.h"
#import "TiAirshipPushReceivedEvent.h"
#import "TiAirshipDeepLinkEvent.h"
#import "TiAirshipChannelRegistrationEvent.h"
#import "TiAirshipNotificationResponseEvent.h"
#import "TiAirshipNotificationOptInChangedEvent.h"
#import "TiAirshipUtils.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TiAirshipModule

#pragma mark Internal

// This is generated for your module, please do not change it
- (id)moduleGUID {
    return @"240dc468-ccad-479d-9510-14e9a7cae5c9";
}

// This is generated for your module, please do not change it
- (NSString *)moduleId {
    return @"ti.airship";
}

- (void)_listenerAdded:(NSString *)type count:(int)count {
    [[TiAirship shared].eventEmitter addListenerForEvent:type count:count proxy:self];
}

- (void)_listenerRemoved:(NSString *)type count:(int)count {
    [[TiAirship shared].eventEmitter removeListenerForEvent:type count:count proxy:self];
}

#pragma Public APIs

-(NSString *)EVENT_PUSH_RECEIVED {
    return TiAirshipPushReceivedEventName;
}

-(NSString *)EVENT_CHANNEL_UPDATED {
    return TiAirshipChannelRegistrationEventName;
}

-(NSString *)EVENT_DEEP_LINK_RECEIVED {
    return TiAirshipDeepLinkEventName;
}

-(NSString *)EVENT_NOTIFICATION_RESPONSE {
    return TiAirshipNotificationResponseEventName;
}

-(NSString *)EVENT_NOTIFICATION_OPT_IN_CHANGED {
    return TiAirshipNotificationOptInChangedEventName;
}

- (void)displayMessageCenter:(id)args {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UAMessageCenter shared] display];
    });
}

- (id)userNotificationsEnabled {
    return NUMBOOL([UAirship push].userPushNotificationsEnabled);
}

- (void)setUserNotificationsEnabled:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    [UAirship push].userPushNotificationsEnabled = [args boolValue];
    [[UAirship push] updateRegistration];
}

- (id)isAutoBadgeEnabled {
    return NUMBOOL([UAirship push].autobadgeEnabled);
}

- (void)setIsAutoBadgeEnabled:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    [UAirship push].autobadgeEnabled = [args boolValue];
    [[UAirship push] updateRegistration];
}

- (id)badgeNumber {
    return NUMINTEGER([UAirship push].badgeNumber);
}

- (void)setBadgeNumber:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    [UAirship push].badgeNumber = [args integerValue];
}

- (void)resetBadge:(id)args {
    [[UAirship push] resetBadge];
}

- (NSArray *)tags {
    return [UAirship channel].tags;
}

- (void)setTags:(id)args {
    ENSURE_ARRAY(args);
    [UAirship channel].tags = args;
    [[UAirship push] updateRegistration];
}

-(id)channelId {
    return [UAirship channel].identifier;
}

-(id)pushToken {
    return [UAirship push].deviceToken;
}

-(id)isUserNotificationsOptedIn {
    BOOL optedIn = [UAirship push].authorizedNotificationSettings != 0;
    return NUMBOOL(optedIn);
}

-(id)authorizedNotificationSettings {
    return [TiAirshipUtils authorizedNotificationsDictionary:[UAirship push].authorizedNotificationSettings];
}

-(id)authorizedNotificationStatus {
    switch ([UAirship push].authorizationStatus) {
        case UAAuthorizationStatusDenied:
            return @"denied";
        case UAAuthorizationStatusAuthorized:
            return @"authorized";
        case UAAuthorizationStatusProvisional:
            return @"provisional";
        case UAAuthorizationStatusNotDetermined:
        default:
            return @"not_determined";
    }
}

-(void)enableUserNotifications:(id)args {
    ENSURE_SINGLE_ARG_OR_NIL(args, KrollCallback)
    KrollCallback *callback = args;

    UA_WEAKIFY(self)
    [[UAirship push] enableUserPushNotifications:^(BOOL success) {
        UA_STRONGIFY(self)
        if (self && callback) {
            [callback call:@[@{@"success": @(success)}] thisObject:self];
        }
    }];
}

- (id)namedUser {
    return [UAirship namedUser].identifier;
}

- (void)setNamedUser:(id)args {
    ENSURE_SINGLE_ARG_OR_NIL(args, NSString);
    [UAirship namedUser].identifier = args;
}

- (id)isInAppAutomationPaused {
    return NUMBOOL([UAInAppAutomation shared].isPaused);
}

- (void)setIsInAppAutomationPaused:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    [UAInAppAutomation shared].paused = [args boolValue];
}

- (void)associateIdentifier:(id)args {
    ENSURE_ARG_COUNT(args, 2);
    NSString *keyString = [TiUtils stringValue:[args objectAtIndex:0]];

    if (keyString.length == 0) {
        UA_LDEBUG(@"AssociateIdentifier failed, key cannot be nil.");
        return;
    }

    NSString *identifierString = [TiUtils stringValue:[args objectAtIndex:1]];

    if (identifierString.length == 0) {
        UA_LDEBUG(@"AssociateIdentifier removed identifier for key: %@", keyString);
    } else {
        UA_LDEBUG(@"AssociateIdentifier with identifier: %@ for key: %@", identifierString, keyString);
    }

    UAAssociatedIdentifiers *identifiers = [[UAirship shared].analytics currentAssociatedDeviceIdentifiers];
    [identifiers setIdentifier:identifierString forKey:keyString];
    [[UAirship shared].analytics associateDeviceIdentifiers:identifiers];
}

- (void)addCustomEvent:(id)args {
    ENSURE_ARG_COUNT(args, 1);
    NSDictionary *payload;

    if ([args[0] isKindOfClass:[NSString class]]) {
        NSString *customEventString = [TiUtils stringValue:[args objectAtIndex:0]];
        if (customEventString.length == 0) {
            UA_LERR(@"Missing event payload.");
            return;
        }
        NSError *jsonError;
        NSData *data = [customEventString dataUsingEncoding:NSUTF8StringEncoding];
        payload = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        if (jsonError) {
            UA_LERR(@"Invalid custom event payload %@", customEventString);
            return;
        }
    } else {
        ENSURE_SINGLE_ARG(args, NSDictionary);
        payload = args;
    }

    UA_LDEBUG(@"Add custom event: %@", payload);
    [UAActionRunner runActionWithName:@"add_custom_event_action"
                                value:payload
                            situation:UASituationManualInvocation];

}

- (id)getLaunchNotification:(id)args {
    TiAirshipNotificationResponse *response = [TiAirship shared].launchNotificationResponse;

    if ([TiUtils boolValue:[args firstObject] def:NO]) {
        [TiAirship shared].launchNotificationResponse = nil;
    }

    return response.payload ?: @{};
}

- (id)launchNotification {
    [self getLaunchNotification:@[NUMBOOL(NO)]];
}

- (id)getDeepLink:(id)args {
    NSString *deepLink = [TiAirship shared].deepLink;

    if ([TiUtils boolValue:[args firstObject] def:NO]) {
        [TiAirship shared].deepLink = nil;
    }

    return deepLink;
}

- (void)trackScreen:(id)args {
    ENSURE_SINGLE_ARG(args, NSString)
    [[UAirship analytics] trackScreen:args];
}

- (void)setIsDataCollectionEnabled:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber)
    [UAirship shared].dataCollectionEnabled = [args boolValue];
}

- (id)isDataCollectionEnabled {
    return NUMBOOL([UAirship shared].isDataCollectionEnabled);
}

- (void)setIsPushTokenRegistrationEnabled:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber)
    [UAirship push].pushTokenRegistrationEnabled = [args boolValue];
}

- (id)isPushTokenRegistrationEnabled {
    return NUMBOOL([UAirship push].pushTokenRegistrationEnabled);
}

@end

NS_ASSUME_NONNULL_END
