//
//  FUIActionSheet.h
//  FlatUIKitExample
//
//  Created by Kevin A. Hoogheem on 7/10/14.
//
//

#import <UIKit/UIKit.h>

@protocol FUIActionSheetDelegate;

@interface FUIActionSheet : UIView


@property(nonatomic, weak) id<FUIActionSheetDelegate> delegate;    // weak reference

- (id)initWithTitle:(NSString *)title
			   delegate:(id<FUIActionSheetDelegate>)delegate
	  cancelButtonTitle:(NSString *)cancelButtonTitle
 destructiveButtonTitle:(NSString *)destructiveButtonTitle
	  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

///Title for the FUIActionSheet
@property(nonatomic, copy) NSString *title;

// adds a button with the title. returns the index (0 based) of where it was added. buttons are displayed in the order added except for the destructive and cancel button which will be positioned based on HI requirements.
- (NSInteger)addButtonWithTitle:(NSString *)title;
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;	// returns index of button. 0 based.
@property(nonatomic,readonly) NSInteger numberOfButtons;

@property(nonatomic) NSInteger cancelButtonIndex;      // if the delegate does not implement -actionSheetCancel:, we pretend this button was clicked on. default is -1
@property(nonatomic) NSInteger destructiveButtonIndex;        // sets destructive (red) button. -1 means none set. default is -1. ignored if only one button

@property(nonatomic,readonly) NSInteger firstOtherButtonIndex;	// -1 if no otherButtonTitles or initWithTitle:... not used
@property(nonatomic,readonly,getter=isVisible) BOOL visible;

// show a sheet animated. you can specify either a toolbar, a tab bar, a bar butto item or a plain view. We do a special animation if the sheet rises from

/*  not implimented yet.
- (void)showFromToolbar:(UIToolbar *)view;
- (void)showFromTabBar:(UITabBar *)view;
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated NS_AVAILABLE_IOS(3_2);
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated NS_AVAILABLE_IOS(3_2);
- (void)showInView:(UIView *)view;
*/
- (void)show;

// hides alert sheet or popup. use this method when you need to explicitly dismiss the alert.
// it does not need to be called if the user presses on a button
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;


//NON conforming additions

@property (nonatomic, copy) void(^onOkAction)(NSInteger buttonIndex);  //called if dismissed with other button
@property (nonatomic, copy) void(^onCancelAction)(void); //called if dismissed with cancel button
@property (nonatomic, copy) void(^onDestructiveAction)(void); //called if dismissed with destructive button
@property (nonatomic, copy) void(^onDismissAction)(NSInteger buttonIndex); //called after onOkAction or onCancelAction.


@property(nonatomic, weak, readonly) UILabel *titleLabel;
@property(nonatomic, weak, readonly) UIView *backgroundOverlay;
@property(nonatomic, weak, readonly) UIView *actionContainer;

///The amount of animation to bring sheet on/off screen
@property(nonatomic) CGFloat animationDuration UI_APPEARANCE_SELECTOR;
/// The amount of spacing between the Buttons (Destructive and otherButtons)
@property(nonatomic) CGFloat buttonSpacing UI_APPEARANCE_SELECTOR;
/// Determines if we use a fade in the showing and hiding of the ActionSheet
@property(nonatomic) BOOL shouldFadeOnShowHide;

//setting these properties overwrites any other button properties that have already been set.

/// Sets the default button Font
@property(nonatomic, strong) UIFont *defaultButtonFont UI_APPEARANCE_SELECTOR;
/// Sets the default button Title Color.  (Destructive button is not effected by this!)
@property(nonatomic, strong) UIColor *defaultButtonTitleColor UI_APPEARANCE_SELECTOR;
/// Sets the default button color
@property(nonatomic, strong) UIColor *defaultButtonColor UI_APPEARANCE_SELECTOR;
/// Sets the default button shadown color
@property(nonatomic, strong) UIColor *defaultButtonShadowColor UI_APPEARANCE_SELECTOR;
/// Sets the default button corner radius
@property(nonatomic, readwrite) CGFloat defaultButtonCornerRadius UI_APPEARANCE_SELECTOR;
/// Sets the default button shadow height
@property(nonatomic, readwrite) CGFloat defaultButtonShadowHeight UI_APPEARANCE_SELECTOR;

@end



@protocol FUIActionSheetDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(FUIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button. If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(FUIActionSheet *)actionSheet;

- (void)willPresentActionSheet:(FUIActionSheet *)actionSheet;  // before animation and showing view
- (void)didPresentActionSheet:(FUIActionSheet *)actionSheet;  // after animation

- (void)actionSheet:(FUIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)actionSheet:(FUIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end

