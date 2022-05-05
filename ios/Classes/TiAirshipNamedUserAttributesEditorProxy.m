/* Copyright Airship and Contributors */

#import "TiAirshipNamedUserAttributesEditorProxy.h"
#import "TiProxy+TiAirshipAttributeAdditions.h"
@import TitaniumKit;
@import AirshipCore;

@interface TiAirshipNamedUserAttributesEditorProxy()
@property (nonatomic, strong) UAAttributesEditor *editor;
@end

@implementation TiAirshipNamedUserAttributesEditorProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        self.editor = [UAirship.contact editAttributes];
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
