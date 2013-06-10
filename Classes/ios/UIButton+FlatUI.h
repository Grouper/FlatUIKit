//
//  UIButton+FlatUI.h
//  FlatUI
//
//  Created by Keisuke Kimura on 6/11/13.
//  Copyright (c) 2013 Keisuke Kimura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FlatUI)

@property(nonatomic, readwrite) UIColor *buttonColor;
@property(nonatomic, readwrite) UIColor *shadowColor;
@property(nonatomic, readwrite) CGFloat shadowHeight;
@property(nonatomic, readwrite) CGFloat cornerRadius;

@end
