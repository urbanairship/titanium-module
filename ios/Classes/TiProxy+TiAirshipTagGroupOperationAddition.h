//
//  TiProxy+UAAdditions.h
//  AirshipTitanium
//
//  Created by Ryan Lepinski on 6/1/20.
//

#import <Foundation/Foundation.h>
#import "TiProxy.h"
#import "TiAirshipTagGroupOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiProxy (TiAirshipTagGroupOperationAddition)

- (TiAirshipTagGroupOperation *)operationFromArgs:(id)args
                                             type:(TiAirshipTagGroupOperationType)type;
@end

NS_ASSUME_NONNULL_END
