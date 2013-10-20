//
// Created by Jonathon Hibbard on 6/13/13.
// Copyright (c) 2013 Integrated Events. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "UIToolbar+FlatUI.h"
#import "UIImage+FlatUI.h"

@implementation UIToolbar (FlatUI)

- (void)configureFlatToolbarWithColor:(UIColor *)color {
    [self setBackgroundImage:[UIImage imageWithColor:color cornerRadius:0]
          forToolbarPosition:UIToolbarPositionAny
                  barMetrics:UIBarMetricsDefault];
    
    if ([self respondsToSelector:@selector(setShadowImage:forToolbarPosition:)]) {
        UIImage *clearShadowImage = [UIImage imageWithColor:[UIColor clearColor] cornerRadius:0];
        [self setShadowImage:clearShadowImage forToolbarPosition:UIToolbarPositionAny];
    }
}

@end
