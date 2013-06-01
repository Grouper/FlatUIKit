//
//  FUIPopoverController.m
//  FlatUI
//
//  Created by Ignacio Romero Zurbuchen on 5/30/13.
//  Copyright (c) 2013 DZEN. All rights reserved.
//

#import "FUIPopoverController.h"
#import "UIImage+FlatUI.h"
#import <QuartzCore/QuartzCore.h>

#define CONTENT_INSET 10.0
#define CAP_INSET 25.0
#define ARROW_BASE 40.0
#define ARROW_HEIGHT 20.0

static UIColor *backgroundColor;

@interface FUIPopoverBackgroundView : UIPopoverBackgroundView
@end

@interface FUIPopoverBackgroundView ()
@property (nonatomic, readwrite, strong) UIImageView *backgroundView;
@property (nonatomic, readwrite, strong) UIImageView *arrowView;

@end

@implementation FUIPopoverBackgroundView
@synthesize backgroundView = _backgroundView;
@synthesize arrowView = _arrowView;
@synthesize arrowOffset = _arrowOffset;
@synthesize arrowDirection = _arrowDirection;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *backgroundImage = [[[UIImage imageWithColor:backgroundColor cornerRadius:9] imageWithMinimumSize:CGSizeMake(frame.size.width,frame.size.width)] resizableImageWithCapInsets:UIEdgeInsetsMake(CAP_INSET,CAP_INSET,CAP_INSET,CAP_INSET)];
        _backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        [self addSubview:_backgroundView];
        
        _arrowView = [[UIImageView alloc] initWithImage:[FUIPopoverBackgroundView arrowImage]];
        [self addSubview:_arrowView];
    }
    return self;
}

+ (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsMake(CONTENT_INSET, CONTENT_INSET, CONTENT_INSET, CONTENT_INSET);
}

+ (CGFloat)arrowHeight {
    return ARROW_HEIGHT;
}

+ (CGFloat)arrowBase {
    return ARROW_BASE;
}

//+ (BOOL)wantsDefaultContentAppearance {
//    return NO;
//}

- (CGFloat)arrowOffset {
    return _arrowOffset;
}

- (void)setArrowOffset:(CGFloat)arrowOffset {
    _arrowOffset = arrowOffset;
}

- (UIPopoverArrowDirection)arrowDirection {
    return _arrowDirection;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    _arrowDirection = arrowDirection;
}

+ (UIImage *)arrowImage
{
    //Create a UIBezierPath for a Triangle
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50,100), NO, [UIScreen mainScreen].scale);
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(25, 0)];
    [bezierPath addLineToPoint:CGPointMake(0, 100)];
    [bezierPath addLineToPoint:CGPointMake(50, 100)];
    [bezierPath closePath];
    [backgroundColor setFill];
    [bezierPath fill];
    
    //Create a UIImage using the current context.
    UIImage *arrow = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return arrow;
}

- (void)setLayoutContainerCornerRadius:(CGFloat)radius
{
    //Loop inside the superview's subviews to customize its LayoutContainerView
    //This rounds the inside corners and removes the inner shadow.
    for (UIView *view in self.superview.subviews) {
        for (UIView *subview in view.subviews) {
            if (subview.layer.cornerRadius == 0.0) {
                subview.layer.cornerRadius = radius;
                for (UIView *subsubview in subview.subviews) {
                    if (subsubview.class == [UIImageView class])
                        [subsubview removeFromSuperview];
                }
            }
        }
    }
}

- (void)removeInnerShadow
{
    //Loop inside the superview's subviews to customize its LayoutContainerView
    //by hidding its inner shadow.
    for (UIView *view in self.superview.subviews) {
        for (UIView *subview in view.subviews) {
            for (UIView *subsubview in subview.subviews) {
                if (subsubview.class == [UIImageView class])
                    [subsubview setHidden:YES];
                
                for (UIView *subsubsubview in subsubview.subviews) {
                    if (subsubsubview.class == [UIImageView class])
                        [subsubsubview setHidden:YES];
                }
            }
        }
    }
}



#pragma mark - Layout subviews

-  (void)layoutSubviews {
    
    //Calling super draws the shadow auto-magically
    //[super layoutSubviews];
    
    CGFloat _height = self.frame.size.height;
    CGFloat _width = self.frame.size.width;
    CGFloat _left = 0.0;
    CGFloat _top = 0.0;
    CGFloat _coordinate = 0.0;
    CGAffineTransform _rotation = CGAffineTransformIdentity;
    
    switch (self.arrowDirection) {
        case UIPopoverArrowDirectionUp:
            _top += ARROW_HEIGHT;
            _height -= ARROW_HEIGHT;
            _coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (ARROW_BASE/2);
            _arrowView.frame = CGRectMake(_coordinate, 0, ARROW_BASE, ARROW_HEIGHT);
            break;
            
        case UIPopoverArrowDirectionDown:
            _height -= ARROW_HEIGHT;
            _coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (ARROW_BASE/2);
            _arrowView.frame = CGRectMake(_coordinate, _height, ARROW_BASE, ARROW_HEIGHT);
            _rotation = CGAffineTransformMakeRotation( M_PI );
            break;
            
        case UIPopoverArrowDirectionLeft:
            _left += ARROW_HEIGHT;
            _width -= ARROW_HEIGHT;
            _coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (ARROW_HEIGHT/2);
            _arrowView.frame = CGRectMake(-abs(ARROW_BASE-ARROW_HEIGHT)/2, _coordinate, ARROW_BASE, ARROW_HEIGHT);
            _rotation = CGAffineTransformMakeRotation( -M_PI_2 );
            break;
            
        case UIPopoverArrowDirectionRight:
            _width -= ARROW_HEIGHT;
            _coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (ARROW_HEIGHT/2);
            _arrowView.frame = CGRectMake(_width - (abs(ARROW_BASE-ARROW_HEIGHT))/2, _coordinate, ARROW_BASE, ARROW_HEIGHT);
            _rotation = CGAffineTransformMakeRotation( M_PI_2 );
            break;
            
        default:
            break;
    }
    
    _backgroundView.frame =  CGRectMake(_left, _top, _width, _height);
    [_arrowView setTransform:_rotation];
    
    [self removeInnerShadow];
}

@end


@implementation FUIPopoverController

- (id)initWithContentViewController:(UIViewController *)viewController
{
    self = [super initWithContentViewController:viewController];
    
    if (self)
    {
        [self setPopoverLayoutMargins:[FUIPopoverBackgroundView contentViewInsets]];
        [self setPopoverBackgroundViewClass:[FUIPopoverBackgroundView class]];
    }
    
    return self;
}

- (void)setBackgroundColor:(UIColor *)color
{
    backgroundColor = color;
}

@end
