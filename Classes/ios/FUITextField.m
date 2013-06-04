//
//  FUITextField.m
//  FlatUIKit
//
//  Created by Marcus Kida on 04.06.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import "FUITextField.h"
#import "UIImage+FlatUI.h"

@implementation FUITextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void) setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self configureFlatButton];
}

- (void) setColor:(UIColor *)color
{
    _color = color;
    [self configureFlatButton];
}

- (void) setFontColor:(UIColor *)fontColor
{
    _fontColor = fontColor;
    [self configureFlatButton];
}

- (void) setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self configureFlatButton];
}

- (void) setTextfieldShadowColor:(UIColor *)shadowColor
{
    _textfieldShadowColor = shadowColor;
    [self configureFlatButton];
}

- (void) setShadowHeight:(CGFloat)shadowHeight
{
    _shadowHeight = shadowHeight;
    [self configureFlatButton];
}

- (void) configureFlatButton
{
    [self setBorderStyle:UITextBorderStyleNone];
    [self setTextColor:_fontColor];
    
    UIImage *normalBackgroundImage = [UIImage buttonImageWithColor:_color
                                                      cornerRadius:_cornerRadius
                                                       shadowColor:_textfieldShadowColor
                                                      shadowInsets:UIEdgeInsetsMake(0, 0, _shadowHeight, 0)];
    [self setBackground:normalBackgroundImage];
    [[UILabel appearanceWhenContainedIn:[UITextField class], nil] setTextColor:_placeholderColor];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    [self setLeftView:paddingView];
    [self setRightView:paddingView];
    [self setLeftViewMode:UITextFieldViewModeAlways];
    [self setRightViewMode:UITextFieldViewModeAlways];
}

@end
