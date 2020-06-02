/* Copyright Airship and Contributors */

#import "TiAirshipNamedUserTagGroupsEditorProxy.h"
#import "TiAirshipTagGroupOperation.h"
#import "TiProxy+TiAirshipTagGroupOperationAddition.h"

@import AirshipCore;

@interface TiAirshipNamedUserTagGroupsEditorProxy ()
@property (nonatomic, strong) NSMutableArray<TiAirshipTagGroupOperation *> *operations;
@end

@implementation TiAirshipNamedUserTagGroupsEditorProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        self.operations = [NSMutableArray array];
    }
    return self;
}

- (void)addTags:(id)args {
    [self.operations addObject:[self operationFromArgs:args
                                                  type:TiAirshipTagGroupOperationTypeAdd]];
}

- (void)removeTags:(id)args {
    [self.operations addObject:[self operationFromArgs:args
                                                  type:TiAirshipTagGroupOperationTypeRemove]];
}

- (void)setTags:(id)args {
    [self.operations addObject:[self operationFromArgs:args
                                                  type:TiAirshipTagGroupOperationTypeSet]];
}

- (void)applyTags:(id)args {
    UANamedUser *namedUser = [UAirship namedUser];

    for (TiAirshipTagGroupOperation *operation in self.operations) {
        switch (operation.type) {
            case TiAirshipTagGroupOperationTypeSet:
                [namedUser setTags:operation.tags group:operation.group];
                break;
            case TiAirshipTagGroupOperationTypeAdd:
                [namedUser addTags:operation.tags group:operation.group];
                break;
            case TiAirshipTagGroupOperationTypeRemove:
                [namedUser removeTags:operation.tags group:operation.group];
                break;
        }
    }

    [namedUser updateTags];
}

@end
