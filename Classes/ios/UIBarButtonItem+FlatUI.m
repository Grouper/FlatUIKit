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

+ (void) configureFlatButtonsWithColor:(UIColor *) color
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
    
    id appearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], [UINavigationController class], nil];
    
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
    
    UIImage *buttonImage = [UIImage imageWithColor:color cornerRadius:cornerRadius];
    [appearance setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    id toolbarAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil];
    [toolbarAppearance setBackgroundImage:[UIImage buttonImageWithColor:color cornerRadius:cornerRadius shadowColor:color shadowInsets:UIEdgeInsetsZero] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius
                       whenContainedIn:(Class <UIAppearanceContainer>)ContainerClass
{
    
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
    
    id appearance = [UIBarButtonItem appearanceWhenContainedIn:ContainerClass, nil];
    
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
    
    UIImage *buttonImage = [UIImage imageWithColor:color cornerRadius:cornerRadius];
    [appearance setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    id toolbarAppearance = [UIBarButtonItem appearanceWhenContainedIn:ContainerClass, nil];
    [toolbarAppearance setBackgroundImage:[UIImage buttonImageWithColor:color cornerRadius:cornerRadius shadowColor:color shadowInsets:UIEdgeInsetsZero] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
}

- (void) removeTitleShadow {
    NSMutableDictionary *titleTextAttributes = [[self titleTextAttributesForState:UIControlStateNormal] mutableCopy];
    if (!titleTextAttributes) {
        titleTextAttributes = [NSMutableDictionary dictionary];
    }
    [titleTextAttributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [self setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
}

@end
