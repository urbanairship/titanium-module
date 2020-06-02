/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
#import "TiProxy.h"
@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

@interface TiProxy(TiAirshipAttributeAddtions)
-(void)setAttributeFromArgs:(id)args
                onMutations:(UAAttributeMutations *)mutations;

-(void)removeAttributeFromArgs:(id)args
                   onMutations:(UAAttributeMutations *)mutations;
@end

NS_ASSUME_NONNULL_END
