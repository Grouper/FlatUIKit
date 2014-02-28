//
//  FUIButton.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "FUIButton.h"
#import "UIImage+FlatUI.h"

@interface FUIButton()
@property(nonatomic) UIEdgeInsets defaultEdgeInsets;
@property(nonatomic) UIEdgeInsets normalEdgeInsets;
@property(nonatomic) UIEdgeInsets highlightedEdgeInsets;
@end

@implementation FUIButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.defaultEdgeInsets = self.titleEdgeInsets;
    }
    return self;
}

- (void) setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    [super setTitleEdgeInsets:titleEdgeInsets];
    self.defaultEdgeInsets = titleEdgeInsets;
    [self setShadowHeight:self.shadowHeight];
}

- (void) setHighlighted:(BOOL)highlighted {
    UIEdgeInsets insets = highlighted ? self.highlightedEdgeInsets : self.normalEdgeInsets;
    [super setTitleEdgeInsets:insets];
    [super setHighlighted:highlighted];
}

- (void) setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self configureFlatButton];
}

- (void) setButtonColor:(UIColor *)buttonColor {
    _buttonColor = buttonColor;
    [self configureFlatButton];
}

- (void) setShadowColor:(UIColor *)shadowColor {
    _shadowColor = shadowColor;
    [self configureFlatButton];
}

- (void) setHighlightedColor:(UIColor *)highlightedColor {
    _highlightedColor = highlightedColor;
    [self configureFlatButton];
}

- (void) setDisabledColor:(UIColor *)disabledColor {
    _disabledColor = disabledColor;
    [self configureFlatButton];
}

- (void) setDisabledShadowColor:(UIColor *)disabledShadowColor {
    _disabledShadowColor = disabledShadowColor;
    [self configureFlatButton];
}

- (void) setShadowHeight:(CGFloat)shadowHeight {
    _shadowHeight = shadowHeight;
    UIEdgeInsets insets = self.defaultEdgeInsets;
    insets.top += shadowHeight;
    self.highlightedEdgeInsets = insets;
    insets.top -= shadowHeight * 2.0f;
    self.normalEdgeInsets = insets;
    [super setTitleEdgeInsets:insets];
    [self configureFlatButton];
}

- (void) configureFlatButton {
    UIImage *normalBackgroundImage = [UIImage buttonImageWithColor:self.buttonColor
                                                      cornerRadius:self.cornerRadius
                                                       shadowColor:self.shadowColor
                                                      shadowInsets:UIEdgeInsetsMake(0, 0, self.shadowHeight, 0)];

    UIColor *highlightedColor = self.highlightedColor == nil ? self.buttonColor : self.highlightedColor;
    UIImage *highlightedBackgroundImage = [UIImage buttonImageWithColor:highlightedColor
                                                           cornerRadius:self.cornerRadius
                                                            shadowColor:[UIColor clearColor]
                                                           shadowInsets:UIEdgeInsetsMake(self.shadowHeight, 0, 0, 0)];

    if (self.disabledColor) {
        UIColor *disabledShadowColor = self.disabledShadowColor == nil ? self.shadowColor : self.disabledShadowColor;
        UIImage *disabledBackgroundImage = [UIImage buttonImageWithColor:self.disabledColor
                                                            cornerRadius:self.cornerRadius
                                                             shadowColor:disabledShadowColor
                                                            shadowInsets:UIEdgeInsetsMake(0, 0, self.shadowHeight, 0)];
        [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
    }

    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}

@end
