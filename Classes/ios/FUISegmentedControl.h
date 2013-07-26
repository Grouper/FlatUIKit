//
//  FUISegmentedControl.h
//  FlatUIKitExample
//
//  Created by Alex Medearis on 5/17/13.
//
//

#import <UIKit/UIKit.h>

@interface FUISegmentedControl : UISegmentedControl

@property(nonatomic, strong, readwrite) UIColor *selectedColor;
@property(nonatomic, strong, readwrite) UIColor *deselectedColor;
@property(nonatomic, strong, readwrite) UIColor *dividerColor;
@property(nonatomic, readwrite) CGFloat cornerRadius;
@property(nonatomic, strong, readwrite) UIFont *selectedFont;
@property(nonatomic, strong, readwrite) UIFont *deselectedFont;
@property(nonatomic, strong, readwrite) UIColor *selectedFontColor;
@property(nonatomic, strong, readwrite) UIColor *deselectedFontColor;



@end
