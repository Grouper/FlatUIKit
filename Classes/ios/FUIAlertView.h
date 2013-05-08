//
//  FUIAlertView.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FUIAlertViewDelegate;

@interface FUIAlertView : UIView


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id<FUIAlertViewDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property(nonatomic,assign) id<FUIAlertViewDelegate> delegate;    // weak reference
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *message;   // secondary explanation text

// adds a button with the title. returns the index (0 based) of where it was added. buttons are displayed in the order added except for the
// cancel button which will be positioned based on HI requirements. buttons cannot be customized.
- (NSInteger)addButtonWithTitle:(NSString *)title;    // returns index of button. 0 based.
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;
@property(nonatomic,readonly) NSInteger numberOfButtons;
@property(nonatomic) NSInteger cancelButtonIndex;      // if the delegate does not implement -alertViewCancel:, we pretend this button was clicked on. default is -1

// TODO: not implemented
//@property(nonatomic,readonly) NSInteger firstOtherButtonIndex;	// -1 if no otherButtonTitles or initWithTitle:... not used

@property(nonatomic,readonly,getter=isVisible) BOOL visible;

// shows popup alert animated.
- (void)show;

// hides alert sheet or popup. use this method when you need to explicitly dismiss the alert.
// it does not need to be called if the user presses on a button
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;


@property(nonatomic) NSMutableArray *buttons;
@property(nonatomic, weak, readonly) UILabel *titleLabel;
@property(nonatomic, weak, readonly) UILabel *messageLabel;
@property(nonatomic, weak, readonly) UIView *backgroundOverlay;
@property(nonatomic, weak, readonly) UIView *alertContainer;
@property(nonatomic) CGFloat buttonSpacing;
@property(nonatomic) CGFloat animationDuration;

//setting these properties overwrites any other button colors/fonts that have already been set
@property(nonatomic, strong) UIFont *defaultButtonFont;
@property(nonatomic, strong) UIColor *defaultButtonTitleColor;
@property(nonatomic, strong) UIColor *defaultButtonColor;
@property(nonatomic, strong) UIColor *defaultButtonShadowColor;

@end


@protocol FUIAlertViewDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(FUIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
// TODO: not implemented
//- (void)alertViewCancel:(FUIAlertView *)alertView;

- (void)willPresentAlertView:(FUIAlertView *)alertView;  // before animation and showing view
- (void)didPresentAlertView:(FUIAlertView *)alertView;  // after animation

- (void)alertView:(FUIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(FUIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

// Called after edits in any of the default fields added by the style
// TODO: not implemented
//- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView;

@end