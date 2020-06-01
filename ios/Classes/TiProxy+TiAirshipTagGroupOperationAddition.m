/* Copyright Airship and Contributors */

#import "TiProxy+TiAirshipTagGroupOperationAddition.h"
#import "TiBase.h"

@implementation TiProxy(TiAirshipTagGroupOperationAddition)

- (TiAirshipTagGroupOperation *)operationFromArgs:(id)args
                                             type:(TiAirshipTagGroupOperationType)type {

    ENSURE_ARG_COUNT(args, 2);
    ENSURE_ARRAY(args);
    for (NSString *arg in args) {
        ENSURE_STRING(arg);
    }

    NSArray *array = args;
    NSString *group = array[0];
    NSMutableArray *tags = [args mutableCopy];
    [tags removeObjectAtIndex:0];

    return [TiAirshipTagGroupOperation operationForType:type tags:tags group:group];
}

@end
