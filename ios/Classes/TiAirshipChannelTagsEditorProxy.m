/* Copyright Airship and Contributors */

#import "TiAirshipChannelTagsEditorProxy.h"
@import TitaniumKit;
@import AirshipCore;

@interface TiAirshipChannelTagsEditorProxy ()
@property (nonatomic, strong) UATagEditor *editor;
@end

@implementation TiAirshipChannelTagsEditorProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        self.editor = [UAirship.channel editTags];
    }
    return self;
}

- (void)clearTags {
    [self.editor clearTags];
}

- (void)addTags:(id)args {
    ENSURE_ARRAY(args);
    [self.editor addTags:args];
}

- (void)removeTags:(id)args {
    ENSURE_ARRAY(args);
    [self.editor removeTags:args];
}

- (void)applyTags:(id)args {
    [self.editor apply];
}

@end
