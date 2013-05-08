//
//  FUISwitch.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUISwitch : UIControl

@property(nonatomic,getter=isOn) BOOL on;
@property(nonatomic, readwrite) UIColor *onBackgroundColor;
@property(nonatomic, readwrite) UIColor *offBackgroundColor;
@property(nonatomic, readwrite) UIColor *onColor;
@property(nonatomic, readwrite) UIColor *offColor;
@property(nonatomic, readwrite) UIColor *highlightedColor;
@property(nonatomic, readwrite) CGFloat percentOn;
@property(weak, readwrite, nonatomic) UILabel *offLabel;
@property(weak, readwrite, nonatomic) UILabel *onLabel;
- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action


@end
