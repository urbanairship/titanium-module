/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TiAirshipTagGroupOperationType) {
    TiAirshipTagGroupOperationTypeAdd,
    TiAirshipTagGroupOperationTypeRemove,
    TiAirshipTagGroupOperationTypeSet
};

@interface TiAirshipTagGroupOperation : NSObject

@property (nonatomic, assign, readonly) TiAirshipTagGroupOperationType type;
@property (nonatomic, copy, readonly) NSArray *tags;
@property (nonatomic, copy, readonly) NSString *group;

+ (instancetype)operationForType:(TiAirshipTagGroupOperationType)type
                            tags:(NSArray *)tags
                           group:(NSString *)group;
@end

NS_ASSUME_NONNULL_END
