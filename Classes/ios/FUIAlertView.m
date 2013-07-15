//
//  FUIAlertView.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "FUIAlertView.h"
#import "FUIButton.h"

@interface FUIAlertView()

@property(nonatomic, weak) UIView *alertContentContainer;

@end

@implementation FUIAlertView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id<FUIAlertViewDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        
        self.buttonSpacing = 10;
        self.animationDuration = 0.2f;
        
        UIView *backgroundOverlay = [[UIView alloc] init];
        backgroundOverlay.backgroundColor = [UIColor blueColor];
        [self addSubview:backgroundOverlay];
        backgroundOverlay.alpha = 0;
        _backgroundOverlay = backgroundOverlay;
        
        UIView *alertContainer = [[UIView alloc] init];
        alertContainer.backgroundColor = [UIColor yellowColor];
        [self addSubview:alertContainer];
        [self bringSubviewToFront:alertContainer];
        _alertContainer = alertContainer;
        
        UIView *alertContentContainer = [[UIView alloc] init];
        alertContentContainer.backgroundColor = [UIColor clearColor];
        [self.alertContainer addSubview:alertContentContainer];
        [self.alertContainer bringSubviewToFront:alertContentContainer];
        _alertContentContainer = alertContentContainer;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.title;
        [alertContentContainer addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.text = self.message;
        [alertContentContainer addSubview:messageLabel];
        _messageLabel = messageLabel;

        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            [self setHasCancelButton:YES];
        }
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [self addButtonWithTitle:arg];
        }
        va_end(args);
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    if (CGAffineTransformIsIdentity(self.alertContainer.transform)) {
        self.backgroundOverlay.frame = self.bounds;
        CGFloat padding = 15;
        CGRect contentContainerFrame = CGRectMake(padding, padding, 0, 0);
        contentContainerFrame.size = [self calculateSize];
        self.alertContentContainer.frame = contentContainerFrame;
        CGRect alertContainerFrame = CGRectInset(contentContainerFrame, -padding, -padding);
        alertContainerFrame.origin = CGPointMake(floorf((self.frame.size.width - alertContainerFrame.size.width) / 2),
                                                 floorf((self.frame.size.height - alertContainerFrame.size.height) / 2));
        alertContainerFrame.origin.y = MAX(10, alertContainerFrame.origin.y - 30);
        self.alertContainer.frame = alertContainerFrame;
        CGRect titleFrame = self.titleLabel.frame;
        titleFrame.size.width = self.alertContentContainer.frame.size.width;
        self.titleLabel.frame = titleFrame;
        [self.titleLabel sizeToFit];
        titleFrame = self.titleLabel.frame;
        CGPoint titleOrigin = CGPointMake(floorf((self.alertContentContainer.frame.size.width - self.titleLabel.frame.size.width)/2), 0);
        titleFrame.origin = titleOrigin;
        self.titleLabel.frame = titleFrame;
        CGRect messageFrame = self.messageLabel.frame;
        messageFrame.size.width = self.alertContentContainer.frame.size.width;
        self.messageLabel.frame = messageFrame;
        [self.messageLabel sizeToFit];
        messageFrame = self.messageLabel.frame;
        CGPoint messageOrigin = CGPointMake((self.alertContentContainer.frame.size.width - self.messageLabel.frame.size.width)/2, CGRectGetMaxY(titleFrame) + 10);
        messageFrame.origin = messageOrigin;
        self.messageLabel.frame = messageFrame;

        __block CGFloat startingButtonY = self.alertContentContainer.frame.size.height - [self totalButtonHeight];
        [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton *button = obj;
            if (self.hasCancelButton && idx == 0) {
                CGFloat lastButtonY = self.alertContentContainer.frame.size.height - button.frame.size.height;
                [self setButton:obj atHeight:lastButtonY];
            } else {
                [self setButton:obj atHeight:startingButtonY];
                startingButtonY += (button.frame.size.height + self.buttonSpacing);
            }
        }];
    }
}

- (void)setButton:(UIButton *)button atHeight:(CGFloat)height {
    CGRect buttonFrame = button.frame;
    buttonFrame.origin = CGPointMake(0, height);
    buttonFrame.size.width = self.alertContentContainer.frame.size.width;
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
    CGFloat titleHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)].height;
    CGFloat messageHeight = [self.messageLabel.text sizeWithFont:self.messageLabel.font constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)].height;
    CGFloat buttonHeight = [self totalButtonHeight];
    return CGSizeMake(contentWidth, titleHeight + 10 + messageHeight + 10 + buttonHeight);
}

- (NSInteger) numberOfButtons {
    return self.buttons.count;
}

- (void)show {
    self.alertContainer.transform = CGAffineTransformMakeScale(0.01, 0.01);
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController && !topController.presentedViewController.isBeingDismissed) {
        topController = topController.presentedViewController;
    }
    UIView *rootView = topController.view;
    self.frame = rootView.bounds;
    
    [rootView addSubview:self];
    [rootView bringSubviewToFront:self];
    if ([self.delegate respondsToSelector:@selector(willPresentAlertView:)]) {
        [self.delegate willPresentAlertView:self];
    }
    [UIView animateWithDuration:self.animationDuration/1.5 animations:^{
        self.backgroundOverlay.alpha = 1.0f;
        self.alertContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);}
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:self.animationDuration/2 animations:^{
                             self.alertContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);} completion:^(BOOL finished) {
                                 
                                 [UIView animateWithDuration:self.animationDuration/2 animations:^{
                                     self.alertContainer.transform = CGAffineTransformIdentity;
                                 } completion:^(BOOL finished) {
                                     _visible = YES;
                                     if ([self.delegate respondsToSelector:@selector(didPresentAlertView:)]) {
                                         [self.delegate didPresentAlertView:self];
                                     }
                                 }];
                             }];
                     }];
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex < 0 || buttonIndex > self.buttons.count) {
        return nil;
    }
    return [[self.buttons objectAtIndex:buttonIndex] titleForState:UIControlStateNormal];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    //todo delegate
    
    self.alertContainer.transform = CGAffineTransformIdentity;
    if ([self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [self.delegate alertView:self willDismissWithButtonIndex:buttonIndex];
    }
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.backgroundOverlay.alpha = 0.0f;
        self.alertContainer.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _visible = NO;
        if ([self.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
            [self.delegate alertView:self didDismissWithButtonIndex:buttonIndex];
        }
    }];
}

- (NSInteger)addButtonWithTitle:(NSString *)title {
    if (!title) return -1;
    if (!self.buttons) {
        self.buttons = [NSMutableArray array];
    }
    FUIButton *button = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    button.cornerRadius = 3;
    button.buttonColor = [UIColor greenColor];
    button.shadowColor = [UIColor brownColor];
    button.shadowHeight = 3;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContentContainer addSubview:button];
    [self.buttons addObject:button];
    return self.buttons.count-1;
}

- (void) buttonPressed:(FUIButton *)sender {
    NSInteger index = [self.buttons indexOfObject:sender];
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:index];
    }
    [self dismissWithClickedButtonIndex:index animated:YES];
}

- (void)clickButtonAtIndex:(NSInteger)buttonIndex {
    [[self.buttons objectAtIndex:buttonIndex] sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void) setDefaultButtonFont:(UIFont *)defaultButtonFont {
    _defaultButtonFont = defaultButtonFont;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
        button.titleLabel.font = defaultButtonFont;
    }];
}

- (void) setDefaultButtonTitleColor:(UIColor *)defaultButtonTitleColor {
    _defaultButtonTitleColor = defaultButtonTitleColor;
    [self.buttons enumerateObjectsUsingBlock:^(FUIButton *button, NSUInteger idx, BOOL *stop) {
        [button setTitleColor:defaultButtonTitleColor forState:UIControlStateNormal & UIControlStateHighlighted];
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

@end
