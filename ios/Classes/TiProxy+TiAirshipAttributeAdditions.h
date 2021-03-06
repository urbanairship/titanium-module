/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
@import TitaniumKit;
@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

@interface TiProxy(TiAirshipAttributeAdditions)
-(void)setAttributeFromArgs:(id)args
                onMutations:(UAAttributeMutations *)mutations;

-(void)removeAttributeFromArgs:(id)args
                   onMutations:(UAAttributeMutations *)mutations;
@end

NS_ASSUME_NONNULL_END
