//
//  UIStepper+FlatUI.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStepper (FlatUI)

- (void) configureFlatStepperWithColor:(UIColor *)color
                      highlightedColor:(UIColor *)highlightedColor
                         disabledColor:(UIColor *)disabledColor
                             iconColor:(UIColor *)iconColor;

@end
