/* Copyright Airship and Contributors */

#import "TiAirshipNotificationResponse.h"
#import "TiAirshipPush.h"

@interface TiAirshipNotificationResponse()
@property (nonatomic, copy) NSDictionary *payload;
@end

@implementation TiAirshipNotificationResponse

- (instancetype)initWithPayload:(NSDictionary *)payload {
    self = [super init];
    if (self) {
        self.payload = payload;
    }
    return self;
}

+ (instancetype)tiResponseFromNotificationResponse:(nullable UANotificationResponse *)response {
    id payload = [self parseResponse:response];
    return [[self alloc] initWithPayload:payload];
}

+ (nonnull NSDictionary *)parseResponse:(nullable UANotificationResponse *)response {
    if (!response) {
        return @{};
    }

    NSMutableDictionary *payload = [NSMutableDictionary dictionary];

    TiAirshipPush *push = [TiAirshipPush tiPushFromNotificationContent:response.notificationContent];
    [payload addEntriesFromDictionary:push.payload];


    if ([response.actionIdentifier isEqualToString:UANotificationDefaultActionIdentifier]) {
        [payload setValue:@(YES) forKey:@"isForeground"];
    } else {
        NSString *categoryID = response.notificationContent.categoryIdentifier;
        NSString *actionID = response.actionIdentifier;

        UANotificationAction *notificationAction = [TiAirshipNotificationResponse notificationActionForCategoryID:categoryID
                                                                                                         actionID:actionID];
        BOOL isForeground = notificationAction.options & UNNotificationActionOptionForeground;

        [payload setValue:@(isForeground) forKey:@"isForeground"];
        [payload setValue:actionID forKey:@"actionId"];
    }

    return payload;
}


+ (UANotificationAction *)notificationActionForCategoryID:(NSString *)categoryID actionID:(NSString *)actionID {
    NSSet *categories = [UAirship push].combinedCategories;

    UANotificationCategory *notificationCategory;
    UANotificationAction *notificationAction;

    for (UANotificationCategory *possibleCategory in categories) {
        if ([possibleCategory.identifier isEqualToString:categoryID]) {
            notificationCategory = possibleCategory;
            break;
        }
    }

    if (!notificationCategory) {
        UA_LERR(@"Unknown notification category identifier %@", categoryID);
        return nil;
    }

    NSMutableArray *possibleActions = [NSMutableArray arrayWithArray:notificationCategory.actions];

    for (UANotificationAction *possibleAction in possibleActions) {
        if ([possibleAction.identifier isEqualToString:actionID]) {
            notificationAction = possibleAction;
            break;
        }
    }

    if (!notificationAction) {
        UA_LERR(@"Unknown notification action identifier %@", actionID);
        return nil;
    }

    return notificationAction;
}

@end
