//
//  UIBarButtonItem+FlatUI.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/8/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FlatUI)

// styles a single bar button item
- (void) configureFlatButtonWithColor:(UIColor *)color
                     highlightedColor:(UIColor *)highlightedColor
                         cornerRadius:(CGFloat) cornerRadius UI_APPEARANCE_SELECTOR;

// styles all bar button items that exist within a class heirarchy (same as UIAppearanceProxy methods)
+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius
                       whenContainedIn:(Class <UIAppearanceContainer>)containerClass, ... NS_REQUIRES_NIL_TERMINATION;

// styles all bar button items (can be overwritten with the above methods)
+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius;


// removes the text shadows off a single bar button item (sadly, this can't be easily done for all buttons simultaneously)
- (void) removeTitleShadow;

@end
