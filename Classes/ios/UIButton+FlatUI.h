//
//  UIButton+FlatUI.h
//  FlatUIKitExample
//
//  Created by 木村圭佑 on 2013/06/11.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (FlatUI)

@property(nonatomic, readwrite) UIColor *buttonColor;
@property(nonatomic, readwrite) UIColor *shadowColor;
@property(nonatomic, readwrite) CGFloat shadowHeight;
@property(nonatomic, readwrite) CGFloat cornerRadius;

@end
