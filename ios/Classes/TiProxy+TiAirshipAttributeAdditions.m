/* Copyright Airship and Contributors */

#import "TiProxy+TiAirshipAttributeAdditions.h"
@import TitaniumKit;

@implementation TiProxy(TiAirshipAttributeAdditions)

-(void)setAttributeFromArgs:(id)args editor:(UAAttributesEditor *)editor {
    ENSURE_ARG_COUNT(args, 2);
    ENSURE_STRING(args[0]);

    id attribute = args[0];
    id value = args[1];
    if ([value isKindOfClass:[NSDate class]]) {
        [editor setDate:value attribute:attribute];
    } else if ([value isKindOfClass:[NSNumber class]]) {
        [editor setNumber:value attribute:attribute];
    } else if ([value isKindOfClass:[NSString class]]) {
        [editor setString:value attribute:attribute];
    }
}

-(void)removeAttributeFromArgs:(id)args editor:(UAAttributesEditor *)editor {
    ENSURE_SINGLE_ARG(args, NSString);
    [editor removeAttribute:args];
}

@end
