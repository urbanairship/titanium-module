/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

@import TitaniumKit;
@import AirshipCore;

NS_ASSUME_NONNULL_BEGIN

@interface TiProxy (TiAirshipTagGroupOperationAddition)

- (void)addTagGroupsWithArgs:(id)args editor:(UATagGroupsEditor *)editor;
- (void)removeTagGroupsWithArgs:(id)args editor:(UATagGroupsEditor *)editor;
- (void)setTagGroupsWithArgs:(id)args editor:(UATagGroupsEditor *)editor;

@end

NS_ASSUME_NONNULL_END
