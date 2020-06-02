/* Copyright Airship and Contributors */

#import "TiProxy+TiAirshipAttributeAdditions.h"
#import "TiBase.h"

@implementation TiProxy(TiAirshipAttributeAdditions)


-(void)setAttributeFromArgs:(id)args onMutations:(UAAttributeMutations *)mutations {
    ENSURE_ARG_COUNT(args, 2);
    ENSURE_STRING(args[0]);

    id attribute = args[0];
    id value = args[1];
    if ([value isKindOfClass:[NSDate class]]) {
        [mutations setDate:value forAttribute:attribute];
    } else if ([value isKindOfClass:[NSNumber class]]) {
        [mutations setNumber:value forAttribute:attribute];
    } else if ([value isKindOfClass:[NSString class]]) {
        [mutations setString:value forAttribute:attribute];
    }
}

-(void)removeAttributeFromArgs:(id)args onMutations:(UAAttributeMutations *)mutations {
    ENSURE_SINGLE_ARG(args, NSString);
    [mutations removeAttribute:args];
}
@end
