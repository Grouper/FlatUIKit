//
//  FUIButton.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUIButton : UIButton

@property(nonatomic, strong, readwrite) UIColor *buttonColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *shadowColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *highlightedColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *disabledColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *disabledShadowColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, readwrite) CGFloat shadowHeight UI_APPEARANCE_SELECTOR;
@property(nonatomic, readwrite) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

@end
