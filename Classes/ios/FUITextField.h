//
//  FUITextField.h
//  FlatUIKit
//
//  Created by Marcus Kida on 04.06.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUITextField : UITextField

@property(nonatomic, readwrite) UIColor *color;
@property(nonatomic, readwrite) UIColor *fontColor;
@property(nonatomic, readwrite) UIColor *placeholderColor;
@property(nonatomic, readwrite) UIColor *textfieldShadowColor;
@property(nonatomic, readwrite) CGFloat cornerRadius;
@property(nonatomic, readwrite) CGFloat shadowHeight;

@end
