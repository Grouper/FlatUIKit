//
//  UISlider+FlatUI.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (FlatUI)

- (void) configureFlatSliderWithTrackColor:(UIColor *)trackColor
                             progressColor:(UIColor *)progressColor
                                thumbColor:(UIColor *)thumbColor;

- (void) configureFlatSliderWithTrackColor:(UIColor *)trackColor
                             progressColor:(UIColor *)progressColor
                          thumbColorNormal:(UIColor *)thumbColorNormal
                     thumbColorHighlighted:(UIColor *)highlightedThumbColor;

@end
