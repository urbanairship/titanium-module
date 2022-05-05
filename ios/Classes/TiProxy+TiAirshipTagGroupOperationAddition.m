/* Copyright Airship and Contributors */

#import "TiProxy+TiAirshipTagGroupOperationAddition.h"

@import TitaniumKit;

@implementation TiProxy(TiAirshipTagGroupOperationAddition)

- (void)addTagGroupsWithArgs:(id)args editor:(UATagGroupsEditor *)editor {
    [self parseTagGroupEdits:args completionHandler:^(NSArray *tags, NSString *group) {
        [editor addTags:tags group:group];
    }];
}

- (void)removeTagGroupsWithArgs:(id)args editor:(UATagGroupsEditor *)editor {
    [self parseTagGroupEdits:args completionHandler:^(NSArray *tags, NSString *group) {
        [editor removeTags:tags group:group];
    }];
}

- (void)setTagGroupsWithArgs:(id)args editor:(UATagGroupsEditor *)editor {
    [self parseTagGroupEdits:args completionHandler:^(NSArray *tags, NSString *group) {
        [editor setTags:tags group:group];
    }];
}

- (void)parseTagGroupEdits:(id)args completionHandler:(void (^)(NSArray *, NSString *))completionHandler {

    ENSURE_ARG_COUNT(args, 2);
    ENSURE_ARRAY(args);
    for (NSString *arg in args) {
        ENSURE_STRING(arg);
    }

    NSArray *array = args;
    NSString *group = array[0];
    NSMutableArray *tags = [args mutableCopy];
    [tags removeObjectAtIndex:0];

    completionHandler(tags, group);
}

@end
