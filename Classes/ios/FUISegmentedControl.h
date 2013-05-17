//
//  FUISegmentedControl.h
//  FlatUIKitExample
//
//  Created by Alex Medearis on 5/17/13.
//
//

#import <UIKit/UIKit.h>

@interface FUISegmentedControl : UISegmentedControl

@property(nonatomic, readwrite) UIColor *selectedColor;
@property(nonatomic, readwrite) UIColor *deselectedColor;
@property(nonatomic, readwrite) UIColor *dividerColor;
@property(nonatomic, readwrite) CGFloat cornerRadius;
@property(nonatomic, readwrite) UIFont *selectedFont;
@property(nonatomic, readwrite) UIFont *deselectedFont;
@property(nonatomic, readwrite) UIColor *selectedFontColor;
@property(nonatomic, readwrite) UIColor *deselectedFontColor;



@end
