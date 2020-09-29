/* Copyright Airship and Contributors */

#import "TiAirshipChannelAttributesEditorProxy.h"
#import "TiProxy+TiAirshipAttributeAdditions.h"
@import TitaniumKit;

@import AirshipCore;

@interface TiAirshipChannelAttributesEditorProxy()
@property (nonatomic, strong) UAAttributeMutations *mutations;

@end
@implementation TiAirshipChannelAttributesEditorProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutations = [UAAttributeMutations mutations];
    }
    return self;
}

-(void)setAttribute:(id)args {
    [self setAttributeFromArgs:args onMutations:self.mutations];
}

-(void)removeAttribute:(id)args {
    [self removeAttributeFromArgs:args onMutations:self.mutations];
}

-(void)applyAttributes:(id)args {
    [[UAirship channel] applyAttributeMutations:self.mutations];
}

@end
