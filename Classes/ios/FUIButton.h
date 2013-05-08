//
//  FUIButton.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUIButton : UIButton

@property(nonatomic, readwrite) UIColor *buttonColor;
@property(nonatomic, readwrite) UIColor *shadowColor;
@property(nonatomic, readwrite) CGFloat shadowHeight;
@property(nonatomic, readwrite) CGFloat cornerRadius;

@end
