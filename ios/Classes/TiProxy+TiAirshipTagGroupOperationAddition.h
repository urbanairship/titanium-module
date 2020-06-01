/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiProxy.h"
#import "TiAirshipTagGroupOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiProxy (TiAirshipTagGroupOperationAddition)

- (TiAirshipTagGroupOperation *)operationFromArgs:(id)args
                                             type:(TiAirshipTagGroupOperationType)type;
@end

NS_ASSUME_NONNULL_END
