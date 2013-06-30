//
//  FUIPopoverBackgroundView.m
//  FlatUIKitExample
//
//  Created by Jack Flintermann on 6/5/13.
//
//

#import "FUIPopoverBackgroundView.h"
#import "UIImage+FlatUI.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+FlatUI.h"

#define CONTENT_INSET 10.0
#define ARROW_BASE 40.0
#define ARROW_HEIGHT 20.0

static CGFloat _cornerRadius = 9.0;
static UIColor *_backgroundColor;

@interface FUIPopoverBackgroundView() {
    UIImageView *_borderImageView;
    UIImageView *_arrowView;
    CGFloat _arrowOffset;
    UIPopoverArrowDirection _arrowDirection;
}
@end

@implementation FUIPopoverBackgroundView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (!_backgroundColor) {
            _backgroundColor = [UIColor midnightBlueColor];
        }

        _borderImageView = [[UIImageView alloc] init];
        [self addSubview:_borderImageView];
        
        _arrowView = [[UIImageView alloc] init];
        [self setupImages];
        [self addSubview:_arrowView];
        self.layer.shadowColor = [UIColor clearColor].CGColor;
    }
    return self;
}

+ (void) setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
}

+ (void) setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
}

- (void) setupImages {
    _borderImageView.image = [self borderImage];
    _arrowView.image = [self arrowImage];
}

- (UIImage *)borderImage {
    return [[[UIImage imageWithColor:_backgroundColor cornerRadius:_cornerRadius] imageWithMinimumSize:self.frame.size] resizableImageWithCapInsets:UIEdgeInsetsMake(_cornerRadius, _cornerRadius, _cornerRadius, _cornerRadius)];
}

- (UIImage *)arrowImage
{
    //Create a UIBezierPath for a Triangle
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ARROW_BASE, ARROW_HEIGHT), NO, [UIScreen mainScreen].scale);
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(ARROW_BASE / 2, 0)];
    [bezierPath addLineToPoint:CGPointMake(0, ARROW_HEIGHT)];
    [bezierPath addLineToPoint:CGPointMake(ARROW_BASE, ARROW_HEIGHT)];
    [bezierPath closePath];
    [_backgroundColor setFill];
    [bezierPath fill];
    
    //Create a UIImage using the current context.
    UIImage *arrow = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return arrow;
}

+ (BOOL)wantsDefaultContentAppearance {
    return NO;
}

/*
 The following code is taken from the Treehouse blog and can be found (along with other awesome stuff) at
 http://blog.teamtreehouse.com/customizing-the-design-of-uipopovercontroller
*/

- (CGFloat) arrowOffset {
    return _arrowOffset;
}

- (void) setArrowOffset:(CGFloat)arrowOffset {
    _arrowOffset = arrowOffset;
}

- (UIPopoverArrowDirection)arrowDirection {
    return _arrowDirection;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    _arrowDirection = arrowDirection;
}


+ (UIEdgeInsets)contentViewInsets{
    return UIEdgeInsetsMake(CONTENT_INSET, CONTENT_INSET, CONTENT_INSET, CONTENT_INSET);
}

+ (CGFloat)arrowHeight{
    return ARROW_HEIGHT;
}

+ (CGFloat)arrowBase{
    return ARROW_BASE;
}


#pragma mark - Layout subviews
-  (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat _height = self.frame.size.height;
    CGFloat _width = self.frame.size.width;
    CGFloat _left = 0.0;
    CGFloat _top = 0.0;
    CGFloat _coordinate = 0.0;
    CGAffineTransform _rotation = CGAffineTransformIdentity;
    
    
    switch (_arrowDirection) {
        default:
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
            _left += ARROW_BASE;
            _width -= ARROW_BASE;
            _coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (ARROW_HEIGHT/2);
            _arrowView.frame = CGRectMake(0, _coordinate, ARROW_BASE, ARROW_HEIGHT);
            _rotation = CGAffineTransformMakeRotation( -M_PI_2 );
            break;
            
        case UIPopoverArrowDirectionRight:
            _width -= ARROW_BASE;
            _coordinate = ((self.frame.size.height / 2) + self.arrowOffset)- (ARROW_HEIGHT/2);
            _arrowView.frame = CGRectMake(_width, _coordinate, ARROW_BASE, ARROW_HEIGHT);
            _rotation = CGAffineTransformMakeRotation( M_PI_2 );
            
            break;
            
    }
    
    _borderImageView.frame =  CGRectMake(_left, _top, _width, _height);
    
    
    [_arrowView setTransform:_rotation];
    
}
@end
