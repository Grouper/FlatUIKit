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
    [titleTextAttributes setValue:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
    [titleTextAttributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [self setTitleTextAttributes:titleTextAttributes];
    if([self respondsToSelector:@selector(setShadowImage:)])
    {
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor] cornerRadius:0]];
    }
}

@end
