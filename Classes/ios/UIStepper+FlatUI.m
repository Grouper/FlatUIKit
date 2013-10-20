//
//  UIStepper+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIStepper+FlatUI.h"
#import "UIImage+FlatUI.h"
#import <CoreText/CoreText.h>

@implementation UIStepper (FlatUI)

- (void) configureFlatStepperWithColor:(UIColor *)color
                      highlightedColor:(UIColor *)highlightedColor
                         disabledColor:(UIColor *)disabledColor
                             iconColor:(UIColor *)iconColor {
    
    // iOS 6 compat check
    if ([self respondsToSelector:@selector(setBackgroundImage:forState:)]) {
        UIImage *normalImage = [UIImage imageWithColor:color cornerRadius:2.0];
        UIImage *highlightedImage = [UIImage imageWithColor:highlightedColor cornerRadius:2.0];
        UIImage *disabledImage = [UIImage imageWithColor:disabledColor cornerRadius:2.0];
        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
        [self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        [self setBackgroundImage:disabledImage forState:UIControlStateDisabled];
        [self setDividerImage:[UIImage imageWithColor:highlightedColor cornerRadius:0]
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateNormal];
        [self setDividerImage:[UIImage imageWithColor:highlightedColor cornerRadius:0]
          forLeftSegmentState:UIControlStateHighlighted
            rightSegmentState:UIControlStateNormal];
        [self setDividerImage:[UIImage imageWithColor:highlightedColor cornerRadius:0]
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateHighlighted];
        
        UIImage *plusImage = [UIImage stepperPlusImageWithColor:iconColor];
        UIImage *minusImage = [UIImage stepperMinusImageWithColor:iconColor];
        [self setIncrementImage:plusImage forState:UIControlStateNormal];
        [self setIncrementImage:plusImage forState:UIControlStateDisabled];
        [self setDecrementImage:minusImage forState:UIControlStateNormal];
        [self setDecrementImage:minusImage forState:UIControlStateDisabled];
    }
}

@end
