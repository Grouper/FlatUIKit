//
//  FUIActionSheet.m
//  FlatUIKitExample
//
//  Created by Kevin A. Hoogheem on 7/10/14.
//
//

#import "FUIActionSheet.h"
#import "UIFont+FlatUI.h"
#import "FUIButton.h"

@interface FUIActionSheet()

@property(nonatomic) BOOL hasCancelButton;
@property(nonatomic) BOOL hasDestructiveButton;
@property(nonatomic, strong) NSMutableArray *buttons;

@property(nonatomic, weak) UIView *actionContentContainer;
@property(nonatomic) NSInteger maxHeight;

@end

const CGFloat kCancelButtonPadding = 10.0f;


@implementation FUIActionSheet

+ (void)initialize {
    if (self == [FUIActionSheet class]) {
        FUIActionSheet *appearance = [self appearance];
        [appearance setButtonSpacing:5.0f];
        [appearance setAnimationDuration:0.9f];
    }
}

- (id)initWithTitle:(NSString *)title
		   delegate:(id<FUIActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
	self = [super initWithFrame:CGRectZero];
    if (self) {
		self.title = title;
        self.delegate = delegate;

		// This mask is set to force lay out of subviews when superview's bounds change
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

		UIView *backgroundOverlay = [[UIView alloc] init];
        backgroundOverlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [self addSubview:backgroundOverlay];
        backgroundOverlay.alpha = 0;
        _backgroundOverlay = backgroundOverlay;

		UIView *actionContainer = [[UIView alloc] init];
        actionContainer.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:actionContainer];
        [self bringSubviewToFront:actionContainer];
        _actionContainer = actionContainer;
		
		UIView *actionContentContainer = [[UIView alloc] init];
        actionContentContainer.backgroundColor = [UIColor clearColor];
        [self.actionContainer addSubview:actionContentContainer];
        [self.actionContainer bringSubviewToFront:actionContentContainer];
        _actionContentContainer = actionContentContainer;

		UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.title;
        [actionContentContainer addSubview:titleLabel];
        _titleLabel = titleLabel;

		_cancelButtonIndex = -1;
		if (cancelButtonTitle) {
            _cancelButtonIndex = [self addButtonWithTitle:cancelButtonTitle];
            [self setHasCancelButton:YES];
        }
		
		_destructiveButtonIndex = -1;
		if (destructiveButtonTitle) {
			_destructiveButtonIndex = [self addButtonWithTitle:destructiveButtonTitle];
            [self setHasDestructiveButton:YES];
		}
		
		va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [self addButtonWithTitle:arg];
        }
        va_end(args);
		
		//0,1,2 are the only valid options here
		_firstOtherButtonIndex = 0 + (self.hasDestructiveButton + self.hasCancelButton);
				
		[self setShouldFadeOnShowHide:TRUE];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];

	}
	
	return self;
}

- (void)dealloc	{

	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}


#pragma mark - System Resign of the ActionSheet
- (void)applicationWillResignActive:(UIApplication *)application {
	[self resignActionSheetFromSystem];
}


#pragma mark - Layout
- (void)resignActionSheetFromSystem {
	
	//What is interesting is that actionSheetCancel does not seem to be used anymore in iOS 6+
	//Maybe use just remove this support too.
	if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheetCancel:)]) {
		[self.delegate actionSheetCancel:self];
	}else {
		// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button. If not defined in the delegate, we simulate a click in the cancel button
		//only dismissing when delegate is not responding
		[self dismissWithClickedButtonIndex:0 animated:FALSE];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];

	self.backgroundOverlay.frame = self.bounds;
	CGFloat padding = 10;
	CGRect contentContainerFrame = CGRectMake(padding, padding, 0, 0);
	contentContainerFrame.size = [self calculateSize];
	
	self.actionContentContainer.frame = contentContainerFrame;
	CGRect actionContainerFrame = CGRectInset(contentContainerFrame, -padding, -padding);
		
	actionContainerFrame.origin = CGPointMake(floorf((self.frame.size.width - actionContainerFrame.size.width) / 2), floorf((self.frame.size.height - actionContainerFrame.size.height)));

	self.actionContainer.frame = actionContainerFrame;
	
	//Title
	CGRect titleFrame = self.titleLabel.frame;
	titleFrame.size.width = self.actionContentContainer.frame.size.width;
	self.titleLabel.frame = titleFrame;
	[self.titleLabel sizeToFit];
	titleFrame = self.titleLabel.frame;
	CGPoint titleOrigin = CGPointMake(floorf((self.actionContentContainer.frame.size.width - self.titleLabel.frame.size.width)/2), padding/2);
	titleFrame.origin = titleOrigin;
	self.titleLabel.frame = titleFrame;

	
	__block CGFloat startingButtonY = self.actionContentContainer.frame.size.height - [self totalButtonHeight] - (self.hasCancelButton ? kCancelButtonPadding : 0);
	[self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		FUIButton *button = obj;
		
		//Color the desctructiveButton red.
		if (self.hasDestructiveButton && idx == _destructiveButtonIndex) {
			[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal & UIControlStateHighlighted];
		}
		
		//for the Cancel Button lets make it bold
		if (idx == _cancelButtonIndex) {
			button.titleLabel.font = [UIFont boldFlatFontOfSize:button.titleLabel.font.pointSize];
		}

		if (self.hasCancelButton && idx == 0) {
			CGFloat lastButtonY = self.actionContentContainer.frame.size.height - button.frame.size.height;
			[self setButton:obj atHeight:lastButtonY];
		} else {
			[self setButton:obj atHeight:startingButtonY];
			startingButtonY += (button.frame.size.height + self.buttonSpacing);
		}
	}];
	
}

- (void)setButton:(UIButton *)button atHeight:(CGFloat)height {
    CGRect buttonFrame = button.frame;
    buttonFrame.origin = CGPointMake(0, height);
    buttonFrame.size.width = self.actionContentContainer.frame.size.width;
    button.frame = buttonFrame;
}


- (CGFloat) totalButtonHeight {
    __block CGFloat buttonHeight = 0;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
        buttonHeight += (button.frame.size.height + self.buttonSpacing);
    }];
    buttonHeight -= self.buttonSpacing;
    return buttonHeight;
}


- (CGSize) calculateSize {
    CGFloat contentWidth = 250;
    
    CGFloat titleHeight;

	
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        // iOS7 methods
        CGRect titleRect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(contentWidth, CGFLOAT_MAX)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:self.titleLabel.font}
                                                              context:nil];

        titleHeight = titleRect.size.height;
    } else {
        // Pre-iOS7 methods
        titleHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)].height;
    }
    
	CGFloat buttonHeight = [self totalButtonHeight];
    CGFloat contentHeight = titleHeight + 10  + 10 + buttonHeight + (self.hasCancelButton ? kCancelButtonPadding : 0);

	
	if(self.maxHeight && contentHeight > self.maxHeight)
        return CGSizeMake(contentWidth, MAX(titleHeight + 10 + buttonHeight, self.maxHeight));
    else
        return CGSizeMake(contentWidth, contentHeight);

}


- (NSInteger) numberOfButtons {
    return (NSInteger)self.buttons.count;
}

- (NSInteger)addButtonWithTitle:(NSString *)title {
    if (!title) return -1;
    if (!self.buttons) {
        self.buttons = [NSMutableArray array];
    }
	
    FUIButton *button = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    button.cornerRadius = 2;
    button.buttonColor = [UIColor lightGrayColor];
    button.shadowColor = [UIColor darkGrayColor];
    button.shadowHeight = 2;
	[button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionContentContainer addSubview:button];
    [self.buttons addObject:button];
    return (NSInteger)self.buttons.count-1;
}

#pragma mark - Button Action

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex < 0 || buttonIndex > (NSInteger)self.buttons.count) {
        return nil;
    }
    return [[self.buttons objectAtIndex:(NSUInteger)buttonIndex] titleForState:UIControlStateNormal];
}

- (void) buttonPressed:(FUIButton *)sender {
    NSUInteger index = [self.buttons indexOfObject:sender];
	
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:(NSInteger)index];
    }
    
    if (index == self.cancelButtonIndex && self.onCancelAction) {
        self.onCancelAction();
    } else if (index == self.destructiveButtonIndex && self.onDestructiveAction) {
		self.onDestructiveAction();
	} else if (index != (self.cancelButtonIndex || self.destructiveButtonIndex ) && self.onOkAction) {
        self.onOkAction(index);
    }
    
    [self dismissWithClickedButtonIndex:(NSInteger)index animated:YES];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    //todo delegate
    
	//_dismissButtonIndex = buttonIndex;
    
    self.actionContainer.transform = CGAffineTransformIdentity;
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
        [self.delegate actionSheet:self willDismissWithButtonIndex:buttonIndex];
    }
	
	[UIView animateWithDuration:self.animationDuration animations:^{
		if (self.shouldFadeOnShowHide) {
			self.actionContainer.alpha = 0;
		}
		self.backgroundOverlay.alpha = 0;
		
		CGRect frame = self.actionContainer.frame;
		frame.origin.y = [[UIScreen mainScreen] bounds].size.height;
		self.actionContainer.frame = frame;
		
		//
		//self.actionContainer.transform = CGAffineTransformMakeScale(0.7, 0.7);
	} completion:^(BOOL finished) {
		_visible = NO;
		
		if (self.onDismissAction) {
			self.onDismissAction(buttonIndex);
		}

		if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
			[self.delegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
		}
		
		[self removeFromSuperview];
		
	}];

	
    
}

#pragma mark - Appearance
- (void) setDefaultButtonFont:(UIFont *)defaultButtonFont {
    _defaultButtonFont = defaultButtonFont;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
        button.titleLabel.font = defaultButtonFont;
    }];
}

//Set the Default Button Title Color.. However keep the DesctutiveButtons color the desctructiveColor!
- (void) setDefaultButtonTitleColor:(UIColor *)defaultButtonTitleColor {
    _defaultButtonTitleColor = defaultButtonTitleColor;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
		if (idx != _destructiveButtonIndex) {
			[button setTitleColor:defaultButtonTitleColor forState:UIControlStateNormal & UIControlStateHighlighted];
		}
    }];
}

- (void) setDefaultButtonColor:(UIColor *)defaultButtonColor {
    _defaultButtonColor = defaultButtonColor;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
        button.buttonColor = defaultButtonColor;
    }];
}

- (void) setDefaultButtonShadowColor:(UIColor *)defaultButtonShadowColor {
    _defaultButtonShadowColor = defaultButtonShadowColor;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
        button.shadowColor = defaultButtonShadowColor;
    }];
}

- (void) setDefaultButtonCornerRadius:(CGFloat)defaultButtonCornerRadius {
    _defaultButtonCornerRadius = defaultButtonCornerRadius;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
        button.cornerRadius = defaultButtonCornerRadius;
    }];
}

- (void) setDefaultButtonShadowHeight:(CGFloat)defaultButtonShadowHeight {
    _defaultButtonShadowHeight = defaultButtonShadowHeight;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
        button.shadowHeight = defaultButtonShadowHeight;
    }];
}



#pragma mark - Show ActionSheet

- (CGRect)positionOffScreen {
	CGRect frame = self.actionContainer.frame;
	frame.origin = CGPointMake(floorf((self.frame.size.width - frame.size.width) / 2), floorf((self.frame.size.height - frame.size.height)));
	
	frame.origin.y = [[UIScreen mainScreen] bounds].size.height + self.actionContainer.frame.size.height;

	return frame;
}


- (void)show {
	[self showInView:nil];
}

- (void)showInView:(UIView *)view {

	if (self.shouldFadeOnShowHide) {
		self.actionContainer.alpha = 0;
	}

    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController && !topController.presentedViewController.isBeingDismissed) {
        topController = topController.presentedViewController;
    }
    UIView *rootView = topController.view;
    self.frame = rootView.bounds;
    
	
    if (self.delegate && [self.delegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        [self.delegate willPresentActionSheet:self];
    }

	__block CGRect frame = self.actionContainer.frame;
	self.actionContainer.frame = [self positionOffScreen];

	[rootView addSubview:self];
    [rootView bringSubviewToFront:self];

	//for 7 lets use the spring animation..
	if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
		
		[UIView animateWithDuration:self.animationDuration
							  delay:0.0
			 usingSpringWithDamping:0.6
			  initialSpringVelocity:0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^(void) {
							 if (self.shouldFadeOnShowHide) {
								 self.actionContainer.alpha = 1;
							 }
							 self.backgroundOverlay.alpha = 1;


							 frame.origin.y = [[UIScreen mainScreen] bounds].size.height - self.actionContainer.frame.size.height;
							 self.actionContainer.frame = frame;
		} completion:^(BOOL finished0) {
			_visible = YES;
			if (self.delegate && [self.delegate respondsToSelector:@selector(didPresentActionSheet:)]) {
				[self.delegate didPresentActionSheet:self];
			}
		}];

	}else {

		[UIView animateWithDuration:self.animationDuration animations:^{
			if (self.shouldFadeOnShowHide) {
				self.actionContainer.alpha = 1;
			}
			self.backgroundOverlay.alpha = 1;
			
			frame.origin.y = [[UIScreen mainScreen] bounds].size.height - self.actionContainer.frame.size.height;
		} completion:^(BOOL finished0) {
			_visible = YES;
			if (self.delegate && [self.delegate respondsToSelector:@selector(didPresentActionSheet:)]) {
				[self.delegate didPresentActionSheet:self];
			}
		}];

	}
	
}




@end
