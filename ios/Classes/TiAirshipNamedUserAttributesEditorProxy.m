/* Copyright Airship and Contributors */

#import "TiAirshipNamedUserAttributesEditorProxy.h"
#import "TiProxy+TiAirshipAttributeAddtions.h"
#import "TiBase.h"

@import AirshipCore;

@interface TiAirshipNamedUserAttributesEditorProxy()
@property (nonatomic, strong) UAAttributeMutations *mutations;

@end
@implementation TiAirshipNamedUserAttributesEditorProxy

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
