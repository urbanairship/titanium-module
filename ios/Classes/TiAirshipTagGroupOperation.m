/* Copyright Airship and Contributors */

#import "TiAirshipTagGroupOperation.h"

@interface TiAirshipTagGroupOperation ()
@property (nonatomic, assign) TiAirshipTagGroupOperationType type;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy) NSString *group;
@end

@implementation TiAirshipTagGroupOperation

- (instancetype)initWithType:(TiAirshipTagGroupOperationType)type
                        tags:(NSArray *)tags
                       group:(NSString *)group {
    self = [super init];
    if (self) {
        self.type = type;
        self.tags = tags;
        self.group = group;
    }
    return self;
}

+ (instancetype)operationForType:(TiAirshipTagGroupOperationType)type
                            tags:(NSArray *)tags
                           group:(NSString *)group {
    return [[self alloc] initWithType:type tags:tags group:group];
}

@end
