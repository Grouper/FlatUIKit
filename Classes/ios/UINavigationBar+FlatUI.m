//
//  UINavigationBar+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UINavigationBar+FlatUI.h"
#import "UIImage+FlatUI.h"

@implementation UINavigationBar (FlatUI)

- (void) configureFlatNavigationBarWithColor:(UIColor *)color {
    [self setBackgroundImage:[UIImage imageWithColor:color cornerRadius:0]
               forBarMetrics:UIBarMetricsDefault & UIBarMetricsLandscapePhone];
    NSMutableDictionary *titleTextAttributes = [[self titleTextAttributes] mutableCopy];
    if (!titleTextAttributes) {
        titleTextAttributes = [NSMutableDictionary dictionary];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending) {
        // iOS6 methods
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowOffset:CGSizeZero];
        [shadow setShadowColor:[UIColor clearColor]];
        [titleTextAttributes setObject:shadow forKey:NSShadowAttributeName];
    } else {
        // Pre-iOS6 methods
        [titleTextAttributes setValue:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
        [titleTextAttributes setValue:[NSValue valueWithUIOffset:UIOffsetZero] forKey:UITextAttributeTextShadowOffset];

    }
    
    [self setTitleTextAttributes:titleTextAttributes];
    if ([self respondsToSelector:@selector(setShadowImage:)]) {
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor] cornerRadius:0]];
    }
}

@end
