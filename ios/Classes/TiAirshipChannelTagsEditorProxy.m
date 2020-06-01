/* Copyright Airship and Contributors */

#import "TiAirshipChannelTagsEditorProxy.h"
#import "TiUtils.h"
@import AirshipCore;

@interface TiAirshipChannelTagsEditorProxy ()
@property (nonatomic, strong) NSMutableSet<NSString *> *tagsToAdd;
@property (nonatomic, strong) NSMutableSet<NSString *> *tagsToRemove;
@property (nonatomic) bool clear;
@end

@implementation TiAirshipChannelTagsEditorProxy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tagsToAdd = [NSMutableSet set];
        self.tagsToRemove = [NSMutableSet set];
    }
    return self;
}

- (void)clearTags {
    self.clear = YES;
}

- (void)addTags:(id)args {
    ENSURE_ARRAY(args);
    [self.tagsToAdd addObjectsFromArray:args];
    for (id tag in args) {
        [self.tagsToRemove removeObject:tag];
    }
}

- (void)removeTags:(id)args {
    ENSURE_ARRAY(args);
    [self.tagsToRemove addObjectsFromArray:args];
    for (id tag in args) {
        [self.tagsToAdd removeObject:tag];
    }
}

- (void)applyTags:(id)args {
    UAChannel *channel = [UAirship channel];
    if (self.clear) {
        channel.tags = @[];
    }


    [channel addTags:[self.tagsToAdd allObjects]];
    [channel removeTags:[self.tagsToRemove allObjects]];
    [channel updateRegistration];
}

@end
