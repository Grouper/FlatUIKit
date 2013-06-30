//
//  UIPopoverController+FlatUI.m
//  FlatUIKit
//
//  Created by Jack Flintermann on 6/29/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIPopoverController+FlatUI.h"
#import "FUIPopoverBackgroundView.h"

@implementation UIPopoverController (FlatUI)

- (void) configureFlatPopoverWithBackgroundColor:(UIColor *)backgroundColor
                                    cornerRadius:(CGFloat)cornerRadius {
    [FUIPopoverBackgroundView setBackgroundColor:backgroundColor];
    [FUIPopoverBackgroundView setCornerRadius:cornerRadius];
    [self setPopoverLayoutMargins:[FUIPopoverBackgroundView contentViewInsets]];
    [self setPopoverBackgroundViewClass:[FUIPopoverBackgroundView class]];
}

@end
