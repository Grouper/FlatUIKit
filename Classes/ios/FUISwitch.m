//
//  FUISwitch.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "FUISwitch.h"
#import "UIImage+FlatUI.h"
#import "UIColor+FlatUI.h"
#import <QuartzCore/QuartzCore.h>

@interface FUISwitch()
@property(weak, readwrite, nonatomic) UIView *thumbView;
@property(weak, readwrite, nonatomic) UIScrollView *internalContainer;
@end

@implementation FUISwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void) sharedInit {
    self.clipsToBounds = YES;
    UIScrollView *internalContainer = [[UIScrollView alloc] init];
    internalContainer.pagingEnabled = YES;
    internalContainer.showsHorizontalScrollIndicator = NO;
    internalContainer.showsVerticalScrollIndicator = NO;
    internalContainer.bounces = NO;
    internalContainer.userInteractionEnabled = NO;
    self.internalContainer = internalContainer;
    UILabel *offLabel = [[UILabel alloc] init];
    UILabel *onLabel = [[UILabel alloc] init];
    offLabel.backgroundColor = [UIColor clearColor];
    onLabel.backgroundColor = [UIColor clearColor];
    offLabel.textAlignment = NSTextAlignmentCenter;
    onLabel.textAlignment = NSTextAlignmentCenter;
    offLabel.text = @"OFF";
    onLabel.text = @"ON";
    self.offLabel = offLabel;
    self.onLabel = onLabel;
    [internalContainer addSubview:offLabel];
    [internalContainer addSubview:onLabel];
    UIView *thumbView = [[UIView alloc] init];
    [internalContainer addSubview:thumbView];
    self.thumbView = thumbView;
    [self addSubview:internalContainer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    panGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGestureRecognizer];
    _on = YES;
    _percentOn = 1;
    self.layer.cornerRadius = 3.0;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    //container
    CGSize size = self.frame.size;
    size.width *= 2;
    size.width -= self.frame.size.height;
    self.internalContainer.contentSize = size;
    self.internalContainer.frame = self.bounds;
    CGFloat contentHeight = self.internalContainer.contentSize.height;
    
    //thumb image
    CGFloat insetFraction = .75;
    CGFloat thumbEdgeSize = floorf(contentHeight * insetFraction);
    CGFloat thumbInset = (contentHeight - thumbEdgeSize) / 2;
    self.thumbView.frame = CGRectMake((self.internalContainer.contentSize.width - contentHeight) / 2 + thumbInset, thumbInset, thumbEdgeSize, thumbEdgeSize);
    self.thumbView.layer.cornerRadius = thumbEdgeSize / 2;
    
    //labels
    CGRect left = CGRectMake(0, 0, (self.internalContainer.contentSize.width - self.thumbView.frame.size.width)/2, contentHeight);
    CGRect right = left;
    right.origin.x = self.internalContainer.contentSize.width - left.size.width;
    self.offLabel.frame = right;
    self.onLabel.frame = left;
    [self setOn:_on];
}

- (void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    if (_on != on) {
        _on = on;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    [self setPercentOn:_on * 1.0f animated:animated];
}

- (void) setPercentOn:(CGFloat)percentOn {
    [self setPercentOn:percentOn animated:NO];
}

- (void) setPercentOn:(CGFloat)percentOn animated:(BOOL)animated {
    _percentOn = percentOn;
    [self updateBackground];
    CGFloat maxOffset = self.internalContainer.contentSize.width - self.frame.size.width;
    CGPoint newOffset = CGPointMake((1 - _percentOn) * maxOffset, 0);
    [self.internalContainer setContentOffset:newOffset animated:animated];
}

- (void) panned:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint translation = [gestureRecognizer translationInView:self.internalContainer];
    [gestureRecognizer setTranslation:CGPointZero inView:self.internalContainer];
    CGPoint newOffset = self.internalContainer.contentOffset;
    newOffset.x -= translation.x;
    CGFloat maxOffset = self.internalContainer.contentSize.width - self.frame.size.width;
    newOffset.x = MAX(newOffset.x, 0);
    newOffset.x = MIN(newOffset.x, maxOffset);
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan ||
        gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        [self setPercentOn:(1 - newOffset.x/maxOffset) animated:NO];
        
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        BOOL left = newOffset.x > maxOffset / 2;
        [self setOn:(!left) animated:YES];
    }
    
}

- (void) tapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self setOn:!self.on animated:YES];
}

- (void) setOnBackgroundColor:(UIColor *)onBackgroundColor {
    _onBackgroundColor = onBackgroundColor;
    [self updateBackground];
}

- (void) setOffBackgroundColor:(UIColor *)offBackgroundColor {
    _offBackgroundColor = offBackgroundColor;
    [self updateBackground];
}

- (void) setOnColor:(UIColor *)onColor {
    _onColor = onColor;
    [self updateBackground];
}

- (void) setOffColor:(UIColor *)offColor {
    _offColor = offColor;
    [self updateBackground];
}

- (void) updateBackground {
    self.backgroundColor = [UIColor blendedColorWithForegroundColor:self.onBackgroundColor
                                                    backgroundColor:self.offBackgroundColor
                                                       percentBlend:self.percentOn];
    UIColor *contentColor = [UIColor blendedColorWithForegroundColor:self.onColor
                                                     backgroundColor:self.offColor
                                                        percentBlend:self.percentOn];
    self.onLabel.textColor = contentColor;
    self.offLabel.textColor = contentColor;
    self.thumbView.backgroundColor = contentColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted)
        self.backgroundColor = self.highlightedColor;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setHighlighted:YES];
}

@end
