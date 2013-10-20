//
//  UITabBar+FlatUI.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (FlatUI)

- (void)configureFlatTabBarWithColor:(UIColor *)color; UI_APPEARANCE_SELECTOR
- (void)configureFlatTabBarWithSelectedColor:(UIColor *)selectedColor; UI_APPEARANCE_SELECTOR

- (void)configureFlatTabBarWithColor:(UIColor *)color
                       selectedColor:(UIColor *)selectedColor;

@end
