/* Copyright Airship and Contributors */

#import "TiAirshipChannelTagsEditorProxy.h"
#import "TiUtils.h"
@import AirshipCore;

@interface TiAirshipChannelTagsEditorProxy ()
@property (nonatomic, strong) NSMutableSet<NSString *> *tagsToAdd;
@property (nonatomic, strong) NSMutableSet<NSString *> *tagsToRemove;
@property (nonatomic) BOOL clear;
@end

@implementation TiAirshipChannelTagsEditorProxy

- (instancetype)init {
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
    [self.tagsToRemove removeObjectsInArray:args];
}

- (void)removeTags:(id)args {
    ENSURE_ARRAY(args);
    [self.tagsToRemove addObjectsFromArray:args];
    [self.tagsToAdd removeObjectsInArray:args];
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
