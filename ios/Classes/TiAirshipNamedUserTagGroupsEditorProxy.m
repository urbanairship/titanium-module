/* Copyright Airship and Contributors */

#import "TiAirshipNamedUserTagGroupsEditorProxy.h"
#import "TiProxy+TiAirshipTagGroupOperationAddition.h"

@import AirshipCore;

@interface TiAirshipNamedUserTagGroupsEditorProxy ()
@property (nonatomic, strong) UATagGroupsEditor *editor;
@end

@implementation TiAirshipNamedUserTagGroupsEditorProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        self.editor = [UAirship.contact editTagGroups];
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
