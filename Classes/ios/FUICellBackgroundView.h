//
//  UACellBackgroundView.h
//  FlatUI
//
//  Created by Maciej Swic on 2013-05-30.
//  Licensed under the MIT license.

typedef enum  {
	FUICellBackgroundViewPositionSingle = 0,
	FUICellBackgroundViewPositionTop,
	FUICellBackgroundViewPositionBottom,
	UACellBackgroundViewPositionMiddle
} FUICellBackgroundViewPosition;

@interface FUICellBackgroundView : UIView

@property (nonatomic) FUICellBackgroundViewPosition position;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor* separatorColor;
@property (nonatomic) CGFloat separatorHeight;

@end
