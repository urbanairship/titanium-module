/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>
@import TitaniumKit;
@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

@interface TiProxy(TiAirshipAttributeAdditions)
-(void)setAttributeFromArgs:(id)args editor:(UAAttributesEditor *)editor;
-(void)removeAttributeFromArgs:(id)args editor:(UAAttributesEditor *)editor;
@end

NS_ASSUME_NONNULL_END
