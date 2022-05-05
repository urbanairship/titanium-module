/* Copyright Airship and Contributors */

#import "TiAirshipChannelTagGroupsEditorProxy.h"
#import "TiProxy+TiAirshipTagGroupOperationAddition.h"

@import AirshipCore;

@interface TiAirshipChannelTagGroupsEditorProxy ()
@property (nonatomic, strong) UATagGroupsEditor *editor;
@end

@implementation TiAirshipChannelTagGroupsEditorProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        self.editor = [UAirship.channel editTagGroups];
    }
    return self;
}

- (void)addTags:(id)args {
    [self addTagGroupsWithArgs:args editor:self.editor];
}

- (void)removeTags:(id)args {
    [self removeTagGroupsWithArgs:args editor:self.editor];
}

- (void)setTags:(id)args {
    [self setTagGroupsWithArgs:args editor:self.editor];
}

- (void)applyTags:(id)args {
    [self.editor apply];
}


@end
