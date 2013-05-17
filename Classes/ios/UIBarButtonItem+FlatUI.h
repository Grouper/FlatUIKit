//
//  UIBarButtonItem+FlatUI.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/8/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FlatUI)

+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius;

- (void) removeTitleShadow;

@end
