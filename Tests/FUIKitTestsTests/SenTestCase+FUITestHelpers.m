//
//  SenTestCase+FUIKitTestHelpers.m
//  FUIKitTests
//
//  Copyright (c) 2013 Grouper. All rights reserved.
//

#import "SenTestCase+FUITestHelpers.h"

@implementation SenTestCase (FUITestHelpers)

- (void)waitForAnimations {
    NSTimeInterval timeout = 0.1;
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:timeout];
    while ([loopUntil timeIntervalSinceNow] > 0)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    }
}

@end
