//
//  UIBarButtonItem+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/8/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIBarButtonItem+FlatUI.h"
#import "UIImage+FlatUI.h"

@implementation UIBarButtonItem (FlatUI)

- (void) configureFlatButtonWithColor:(UIColor *)color
                     highlightedColor:(UIColor *)highlightedColor
                         cornerRadius:(CGFloat) cornerRadius {
  [UIBarButtonItem configureItemOrProxy:self forFlatButtonWithColor:color highlightedColor:highlightedColor cornerRadius:cornerRadius];
}

+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius {
  [self configureFlatButtonsWithColor:color highlightedColor:highlightedColor cornerRadius:cornerRadius whenContainedIn:[UINavigationBar class], [UINavigationController class], [UIToolbar class], nil];
}

+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius
                       whenContainedIn:(Class <UIAppearanceContainer>)containerClass, ... {
  va_list vl;
  va_start(vl, containerClass);
  id appearance = [UIBarButtonItem appearanceWhenContainedIn:containerClass, nil];
  va_end(vl);
  [UIBarButtonItem configureItemOrProxy:appearance forFlatButtonWithColor:color highlightedColor:highlightedColor cornerRadius:cornerRadius];
}


- (void) removeTitleShadow {
    NSArray *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted)];
    
    for (NSNumber *state in states) {
        UIControlState controlState = [state unsignedIntegerValue];
        NSMutableDictionary *titleTextAttributes = [[self titleTextAttributesForState:controlState] mutableCopy];
        if (!titleTextAttributes) {
            titleTextAttributes = [NSMutableDictionary dictionary];
        }
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
            // iOS6 methods
            NSShadow *shadow = [[NSShadow alloc] init];
            [shadow setShadowOffset:CGSizeZero];
            [shadow setShadowColor:[UIColor clearColor]];
            [titleTextAttributes setObject:shadow forKey:NSShadowAttributeName];
#else
            // Pre-iOS6 methods
            [titleTextAttributes setValue:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
            [titleTextAttributes setValue:[NSValue valueWithUIOffset:UIOffsetZero] forKey:UITextAttributeTextShadowOffset];
#endif
        
        [self setTitleTextAttributes:titleTextAttributes forState:controlState];
    }
}

//helper method, basically a wrapper to allow creating a custom UIAppearance method that doesn't conform to the usual naming style
+ (void) configureItemOrProxy:(id)appearance
       forFlatButtonWithColor:(UIColor *)color
             highlightedColor:(UIColor *)highlightedColor
                 cornerRadius:(CGFloat) cornerRadius {
  UIImage *backButtonPortraitImage = [UIImage backButtonImageWithColor:color
                                                            barMetrics:UIBarMetricsDefault
                                                          cornerRadius:cornerRadius];
  UIImage *highlightedBackButtonPortraitImage = [UIImage backButtonImageWithColor:highlightedColor
                                                                       barMetrics:UIBarMetricsDefault
                                                                     cornerRadius:cornerRadius];
  UIImage *backButtonLandscapeImage = [UIImage backButtonImageWithColor:color
                                                             barMetrics:UIBarMetricsLandscapePhone
                                                           cornerRadius:2];
  UIImage *highlightedBackButtonLandscapeImage = [UIImage backButtonImageWithColor:highlightedColor
                                                                        barMetrics:UIBarMetricsLandscapePhone
                                                                      cornerRadius:2];
  
  [appearance setBackButtonBackgroundImage:backButtonPortraitImage
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
  [appearance setBackButtonBackgroundImage:backButtonLandscapeImage
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsLandscapePhone];
  [appearance setBackButtonBackgroundImage:highlightedBackButtonPortraitImage
                                  forState:UIControlStateHighlighted
                                barMetrics:UIBarMetricsDefault];
  [appearance setBackButtonBackgroundImage:highlightedBackButtonLandscapeImage
                                  forState:UIControlStateHighlighted
                                barMetrics:UIBarMetricsLandscapePhone];
  
  [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(1.0f, 1.0f) forBarMetrics:UIBarMetricsDefault];
  [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(1.0f, 1.0f) forBarMetrics:UIBarMetricsLandscapePhone];
  
  UIImage *buttonImageNormal       = [UIImage imageWithColor:color cornerRadius:cornerRadius];
  UIImage *buttonImageHightlighted = [UIImage imageWithColor:highlightedColor cornerRadius:cornerRadius];
  [appearance setBackgroundImage:buttonImageNormal forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  [appearance setBackgroundImage:buttonImageHightlighted forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

@end
