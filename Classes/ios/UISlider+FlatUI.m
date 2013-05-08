//
//  UISlider+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UISlider+FlatUI.h"
#import "UIImage+FlatUI.h"

@implementation UISlider (FlatUI)

- (void) configureFlatSliderWithTrackColor:(UIColor *)trackColor
                             progressColor:(UIColor *)progressColor
                                thumbColor:(UIColor *)thumbColor {
    
    UIImage *progressImage = [[UIImage imageWithColor:progressColor cornerRadius:5.0]
                              imageWithMinimumSize:CGSizeMake(10, 10)];
    UIImage *trackImage = [[UIImage imageWithColor:trackColor cornerRadius:5.0]
                           imageWithMinimumSize:CGSizeMake(10, 10)];

    [self setMinimumTrackImage:progressImage forState:UIControlStateNormal];
    [self setMaximumTrackImage:trackImage forState:UIControlStateNormal];
    UIImage *normalSliderImage = [UIImage circularImageWithColor:thumbColor size:CGSizeMake(24, 24)];
    [self setThumbImage:normalSliderImage forState:UIControlStateNormal];
}

@end
