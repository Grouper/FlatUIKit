//
//  FUITextField.h
//  FlatUI
//
//  Created by Andrej Mihajlov on 8/25/13.
//  Copyright (c) 2013 Andrej Mihajlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUITextField : UITextField

@property (nonatomic, assign) UIEdgeInsets edgeInsets UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textFieldColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

@end
