//
//  FUISegmentedControl.h
//  FlatUIKitExample
//
//  Created by Alex Medearis on 5/17/13.
//
//

#import <UIKit/UIKit.h>

@interface FUISegmentedControl : UISegmentedControl

@property(nonatomic, strong, readwrite) UIColor *selectedColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *disabledColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *deselectedColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *highlightedColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *dividerColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, readwrite) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIFont *selectedFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIFont *disabledFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIFont *deselectedFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIFont *highlightedFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *selectedFontColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *deselectedFontColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *disabledFontColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *highlightedFontColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readwrite) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, readwrite) CGFloat borderWidth UI_APPEARANCE_SELECTOR;

@end
