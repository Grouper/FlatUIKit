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
@property (nonatomic, strong) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor* separatorColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat separatorHeight UI_APPEARANCE_SELECTOR;

@end
