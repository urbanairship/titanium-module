/* Copyright Airship and Contributors */

#import "TiAirshipModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiAirship.h"
#import "TiAirshipPushReceivedEvent.h"
#import "TiAirshipDeepLinkEvent.h"
#import "TiAirshipChannelRegistrationEvent.h"

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

- (id)namedUser {
    return [UAirship namedUser].identifier;
}

- (void)setNamedUser:(id)args {
    ENSURE_SINGLE_ARG_OR_NIL(args, NSString);
    [UAirship namedUser].identifier = args;
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
    TiAirshipPush *push = [TiAirship shared].launchPush;

    if ([TiUtils boolValue:[args firstObject] def:NO]) {
        [TiAirship shared].launchPush = nil;
    }

    return push.payload ?: @{};
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
