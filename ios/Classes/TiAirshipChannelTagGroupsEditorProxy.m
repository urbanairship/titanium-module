/* Copyright Airship and Contributors */

#import "TiAirshipChannelTagGroupsEditorProxy.h"
#import "TiAirshipTagGroupOperation.h"
#import "TiProxy+TiAirshipTagGroupOperationAddition.h"

@import AirshipCore;

@interface TiAirshipChannelTagGroupsEditorProxy ()
@property (nonatomic, strong) NSMutableArray<TiAirshipTagGroupOperation *> *operations;
@end

@implementation TiAirshipChannelTagGroupsEditorProxy

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
    UAChannel *channel = [UAirship channel];

    for (TiAirshipTagGroupOperation *operation in self.operations) {
        switch (operation.type) {
            case TiAirshipTagGroupOperationTypeSet:
                [channel setTags:operation.tags group:operation.group];
                break;
            case TiAirshipTagGroupOperationTypeAdd:
                [channel addTags:operation.tags group:operation.group];
                break;
            case TiAirshipTagGroupOperationTypeRemove:
                [channel removeTags:operation.tags group:operation.group];
                break;
        }
    }

    [channel updateRegistration];
}

@end
