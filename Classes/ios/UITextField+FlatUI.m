//
//  UITextField+FlatUI.m
//  FlatUIKit
//
//  Created by Marcus Kida on 04.06.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import "UITextField+FlatUI.h"
#import "UIImage+FlatUI.h"

@implementation UITextField (FlatUI)

- (void) configureFlatTextfieldWithColor:(UIColor *)color
                               fontColor:(UIColor *)fontColor
                        placeholderColor:(UIColor *)placeholderColor
                             shadowColor:(UIColor *)shadowColor
                            cornerRadius:(CGFloat)cornerRadius
                            shadowHeight:(CGFloat)shadowHeight
{
    [UITextField configureItemOrProxy:self forFlatTextfieldWithColor:color fontColor:fontColor placeholderColor:placeholderColor shadowColor:shadowColor cornerRadius:cornerRadius shadowHeight:shadowHeight];
}

+ (void) configureFlatTextfieldsWithColor:(UIColor *) color
                                fontColor:(UIColor *)fontColor
                         placeholderColor:(UIColor *)placeholderColor
                              shadowColor:(UIColor *)shadowColor
                             cornerRadius:(CGFloat)cornerRadius
                             shadowHeight:(CGFloat)shadowHeight
{
    [self configureFlatTextfieldsWithColor:color fontColor:fontColor placeholderColor:placeholderColor shadowColor:shadowColor cornerRadius:cornerRadius shadowHeight:shadowHeight whenContainedIn:[UIView class], nil];
}

+ (void) configureFlatTextfieldsWithColor:(UIColor *)color
                                fontColor:(UIColor *)fontColor
                         placeholderColor:(UIColor *)placeholderColor
                              shadowColor:(UIColor *)shadowColor
                             cornerRadius:(CGFloat)cornerRadius
                             shadowHeight:(CGFloat)shadowHeight
                          whenContainedIn:(Class <UIAppearanceContainer>)containerClass, ...
{
    va_list vl;
    va_start(vl, containerClass);
    id appearance = [UITextField appearanceWhenContainedIn:containerClass, nil];
    va_end(vl);
    [UITextField configureItemOrProxy:appearance forFlatTextfieldWithColor:color fontColor:fontColor placeholderColor:placeholderColor shadowColor:shadowColor cornerRadius:cornerRadius shadowHeight:shadowHeight];
}

+ (void) configureItemOrProxy:(id)appearance
    forFlatTextfieldWithColor:(UIColor *)color
                    fontColor:(UIColor *)fontColor
             placeholderColor:(UIColor *)placeholderColor
                  shadowColor:(UIColor *)shadowColor
                 cornerRadius:(CGFloat)cornerRadius
                 shadowHeight:(CGFloat)shadowHeight
{
    UITextField *textField = (UITextField *)appearance;
    
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setTextColor:fontColor];
    
    UIImage *normalBackgroundImage = [UIImage buttonImageWithColor:color
                                                      cornerRadius:cornerRadius
                                                       shadowColor:shadowColor
                                                      shadowInsets:UIEdgeInsetsMake(0, 0, shadowHeight, 0)];
    
    [textField setBackground:normalBackgroundImage];
    [[UILabel appearanceWhenContainedIn:[UITextField class], nil] setTextColor:placeholderColor];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    [textField setLeftView:paddingView];
    [textField setRightView:paddingView];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setRightViewMode:UITextFieldViewModeAlways];
}

@end
