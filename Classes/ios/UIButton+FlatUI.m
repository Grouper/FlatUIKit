//
//  UIButton+FlatUI.m
//  FlatUI
//
//  Created by Keisuke Kimura on 6/11/13.
//  Copyright (c) 2013 Keisuke Kimura. All rights reserved.
//

#import "UIButton+FlatUI.h"

#import <objc/runtime.h>

#import "UIImage+FlatUI.h"

const void *kButtonColorAssociatedObjectKey = "kButtonColorAssociatedObjectKey";
const void *kShadowColorAssociatedObjectKey = "kShadowColorAssociatedObjectKey";
const void *kShadowHeightAssociatedObjectKey = "kShadowHeightAssociatedObjectKey";
const void *kCornerRadiusAssociatedObjectKey = "kCornerRadiusAssociatedObjectKey";
const void *kDefaultEdgeInsetsAssociatedObjectKey = "kDefaultEdgeInsetsAssociatedObjectKey";
const void *kNormalEdgeInsetsAssociatedObjectKey = "kNormalEdgeInsetsAssociatedObjectKey";
const void *kHighlightedEdgeInsetsAssociatedObjectKey = "kHighlightedEdgeInsetsAssociatedObjectKey";

@interface UIButton(/*private*/)

@property(nonatomic) UIEdgeInsets defaultEdgeInsets;
@property(nonatomic) UIEdgeInsets normalEdgeInsets;
@property(nonatomic) UIEdgeInsets highlightedEdgeInsets;

@end

@implementation UIButton (FlatUI)

@dynamic buttonColor;
@dynamic shadowColor;
@dynamic shadowHeight;
@dynamic cornerRadius;

- (void)setHighlighted:(BOOL)highlighted {
    self.titleEdgeInsets = highlighted ? self.highlightedEdgeInsets : self.normalEdgeInsets;
    [super setHighlighted:highlighted];
}

- (UIColor *)buttonColor
{
    return objc_getAssociatedObject(self, kButtonColorAssociatedObjectKey);
}

- (void)setButtonColor:(UIColor *)buttonColor
{
    objc_setAssociatedObject(self,
                             kButtonColorAssociatedObjectKey,
                             buttonColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self configureFlatButton];
}

- (UIColor *)shadowColor
{
    return objc_getAssociatedObject(self, kShadowColorAssociatedObjectKey);
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    objc_setAssociatedObject(self,
                             kShadowColorAssociatedObjectKey,
                             shadowColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configureFlatButton];
}

- (CGFloat)shadowHeight
{
    NSNumber *shadowHeightNumber = objc_getAssociatedObject(self, kShadowHeightAssociatedObjectKey);
    
    return [shadowHeightNumber floatValue];
}

- (void)setShadowHeight:(CGFloat)shadowHeight
{
    objc_setAssociatedObject(self,
                             kShadowHeightAssociatedObjectKey,
                             @(shadowHeight),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIEdgeInsets insets = self.defaultEdgeInsets;
    self.highlightedEdgeInsets = insets;
    insets.top -= shadowHeight;
    self.normalEdgeInsets = insets;
    self.titleEdgeInsets = insets;
    [self configureFlatButton];
}

- (CGFloat)cornerRadius
{
    NSNumber *cornerRadiusNumber = objc_getAssociatedObject(self, kCornerRadiusAssociatedObjectKey);
    
    return [cornerRadiusNumber floatValue];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    objc_setAssociatedObject(self,
                             kCornerRadiusAssociatedObjectKey,
                             @(cornerRadius),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configureFlatButton];


}

- (UIEdgeInsets)defaultEdgeInsets
{
    NSValue *defaultEdgeInsetsValue = objc_getAssociatedObject(self, kDefaultEdgeInsetsAssociatedObjectKey);

    if(defaultEdgeInsetsValue == nil){
        return self.titleEdgeInsets;
    }
    return [defaultEdgeInsetsValue UIEdgeInsetsValue];
}

- (void)setDefaultEdgeInsets:(UIEdgeInsets)defaultEdgeInsets
{
    NSValue *defaultEdgeInsetsValue = [NSValue valueWithUIEdgeInsets:defaultEdgeInsets];
    
    objc_setAssociatedObject(self,
                             kDefaultEdgeInsetsAssociatedObjectKey,
                             defaultEdgeInsetsValue,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)normalEdgeInsets
{
    NSValue *normalEdgeInsetsValue = objc_getAssociatedObject(self, kNormalEdgeInsetsAssociatedObjectKey);
    
    if(normalEdgeInsetsValue == nil){
        return UIEdgeInsetsZero;
    }
    
    return [normalEdgeInsetsValue UIEdgeInsetsValue];
}

- (void)setNormalEdgeInsets:(UIEdgeInsets)normalEdgeInsets
{
    NSValue *normalEdgeInsetsValue = [NSValue valueWithUIEdgeInsets:normalEdgeInsets];
    
    objc_setAssociatedObject(self,
                             kNormalEdgeInsetsAssociatedObjectKey,
                             normalEdgeInsetsValue,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)highlightedEdgeInsets
{
    NSValue *highlightedEdgeInsetsValue = objc_getAssociatedObject(self, kHighlightedEdgeInsetsAssociatedObjectKey);
    
    if(highlightedEdgeInsetsValue == nil){
        return UIEdgeInsetsZero;
    }
    
    return [highlightedEdgeInsetsValue UIEdgeInsetsValue];
}

- (void)setHighlightedEdgeInsets:(UIEdgeInsets)highlightedEdgeInsets
{
    NSValue *highlightedEdgeInsetsValue = [NSValue valueWithUIEdgeInsets:highlightedEdgeInsets];
    
    objc_setAssociatedObject(self,
                             kHighlightedEdgeInsetsAssociatedObjectKey,
                             highlightedEdgeInsetsValue,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)configureFlatButton {
    UIImage *normalBackgroundImage = [UIImage buttonImageWithColor:self.buttonColor
                                                      cornerRadius:self.cornerRadius
                                                       shadowColor:self.shadowColor
                                                      shadowInsets:UIEdgeInsetsMake(0, 0, self.shadowHeight, 0)];
    UIImage *highlightedBackgroundImage = [UIImage buttonImageWithColor:self.buttonColor
                                                           cornerRadius:self.cornerRadius
                                                            shadowColor:[UIColor clearColor]
                                                           shadowInsets:UIEdgeInsetsMake(self.shadowHeight, 0, 0, 0)];
    
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    
}

@end
