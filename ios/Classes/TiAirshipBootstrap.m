

#import "TiAirshipBootstrap.h"

@implementation TiAirshipBootstrap

+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                      object:nil
                                                       queue:nil usingBlock:^(NSNotification * _Nonnull note) {

        // Using reflection here since I was running into troubles referencing swift
        // classes in an app from obj-c.
        SEL selector = NSSelectorFromString(@"attemptTakeOffWithLaunchOptions:");
        id class = NSClassFromString(@"TiAirshipAutopilot");
        IMP imp = [class methodForSelector:selector];
        void (*takeOff)(id, SEL, NSDictionary *) = (void *)imp;
        takeOff(class, selector, note.userInfo);
    }];
}

@end
