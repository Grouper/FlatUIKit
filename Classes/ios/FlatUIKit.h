//
//  FlatUIKit.h
//  FlatUI
//
//  Created by Keisuke Kimura on 2013/06/08.
//  Copyright (c) 2013年 Keisuke Kimura. All rights reserved.
//

#ifndef FlatUI_FlatUIKit_h
#define FlatUI_FlatUIKit_h

#ifndef __IPHONE_5_0
#error "FlatUIKit uses features only available in iOS SDK 5.0 and later."
#endif

#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#endif

#endif

#import "FUIAlertView.h"
#import "FUIButton.h"
#import "FUICellBackgroundView.h"
#import "FUISegmentedControl.h"
#import "FUISwitch.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UIImage+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "UITabBar+FlatUI.h"
#import "UITableViewCell+FlatUI.h"

#ifdef __IPHONE_6_0
#import "UIStepper+FlatUI.h"
#endif
