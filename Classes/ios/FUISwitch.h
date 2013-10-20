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
@property(nonatomic, strong, readwrite) UIColor *onBackgroundColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *offBackgroundColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *onColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *offColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *highlightedColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, readwrite) CGFloat switchCornerRadius UI_APPEARANCE_SELECTOR;
@property(nonatomic, readwrite) CGFloat percentOn;
@property(weak, readwrite, nonatomic) UILabel *offLabel;
@property(weak, readwrite, nonatomic) UILabel *onLabel;

- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action

@end
