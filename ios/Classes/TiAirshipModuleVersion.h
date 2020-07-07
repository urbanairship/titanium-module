/* Copyright Airship and Contributors */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 * Ti Airship Module Version.
 */
@interface TiAirshipModuleVersion : NSObject

///---------------------------------------------------------------------------------------
/// @name Ti Airship Module Version Core Methods
///---------------------------------------------------------------------------------------

/**
 * Returns the Ti Airship Module version.
 */
+ (nonnull NSString *)get;

@end

NS_ASSUME_NONNULL_END
