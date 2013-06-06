//
//  UIToolbar+FlatUI.m
//  FlatUIKitExample
//
//  Created by whdvl on 13. 6. 6..
//
//

#import "UIToolbar+FlatUI.h"
#import "UIImage+FlatUI.h"
@implementation UIToolbar (FlatUI)

- (void) configureFlatToolBarWithColor:(UIColor *)color {
    [self setBackgroundImage:[UIImage imageWithColor:color cornerRadius:0]
          forToolbarPosition:UIToolbarPositionAny
                  barMetrics:UIBarMetricsDefault & UIBarMetricsLandscapePhone];

    [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor] cornerRadius:0]
      forToolbarPosition:UIToolbarPositionAny];

}

@end
