//
//  UITextField+FlatUI.h
//  FlatUIKit
//
//  Created by Marcus Kida on 04.06.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (FlatUI)

- (void) configureFlatTextfieldWithColor:(UIColor *)color
                               fontColor:(UIColor *)fontColor
                        placeholderColor:(UIColor *)placeholderColor
                             shadowColor:(UIColor *)shadowColor
                            cornerRadius:(CGFloat)cornerRadius
                            shadowHeight:(CGFloat)shadowHeight UI_APPEARANCE_SELECTOR;

+ (void) configureFlatTextfieldsWithColor:(UIColor *) color
                                fontColor:(UIColor *)fontColor
                         placeholderColor:(UIColor *)placeholderColor
                              shadowColor:(UIColor *)shadowColor
                             cornerRadius:(CGFloat)cornerRadius
                             shadowHeight:(CGFloat)shadowHeight
                          whenContainedIn:(Class <UIAppearanceContainer>)containerClass, ... NS_REQUIRES_NIL_TERMINATION;

+ (void) configureFlatTextfieldsWithColor:(UIColor *) color
                                fontColor:(UIColor *)fontColor
                         placeholderColor:(UIColor *)placeholderColor
                              shadowColor:(UIColor *)shadowColor
                             cornerRadius:(CGFloat)cornerRadius
                             shadowHeight:(CGFloat)shadowHeight;

@end
