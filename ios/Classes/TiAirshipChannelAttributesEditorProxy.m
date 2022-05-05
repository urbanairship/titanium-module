/* Copyright Airship and Contributors */

#import "TiAirshipChannelAttributesEditorProxy.h"
#import "TiProxy+TiAirshipAttributeAdditions.h"
@import TitaniumKit;

@import AirshipCore;

@interface TiAirshipChannelAttributesEditorProxy()
@property (nonatomic, strong) UAAttributesEditor *editor;
@end

@implementation TiAirshipChannelAttributesEditorProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        self.editor = [UAirship.channel editAttributes];
    }
    return self;
}

-(void)setAttribute:(id)args {
    [self setAttributeFromArgs:args editor:self.editor];
}

-(void)removeAttribute:(id)args {
    [self removeAttributeFromArgs:args editor:self.editor];
}

-(void)applyAttributes:(id)args {
    [self.editor apply];
}

@end
