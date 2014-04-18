//
//  UACellBackgroundView.m
//  FlatUI
//
//  Created by Maciej Swic on 2013-05-30.
//  Licensed under the MIT license.

#import "FUICellBackgroundView.h"

@implementation FUICellBackgroundView

+ (void)initialize {
    if (self == [FUICellBackgroundView class]) {
        FUICellBackgroundView *appearance = [self appearance];
        [appearance setCornerRadius:3.0f];
        [appearance setSeparatorHeight:1.0f];
        [appearance setSeparatorColor:[UIColor clearColor]];
    }
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	}
	return self;
}

- (BOOL)isOpaque {
	return NO;
}

- (void)drawRect:(CGRect)aRect {
    
    CGContextRef c = UIGraphicsGetCurrentContext();

	int lineWidth = 1;

	CGContextSetStrokeColorWithColor(c, [[UIColor grayColor] CGColor]);
	CGContextSetLineWidth(c, lineWidth);
	CGContextSetAllowsAntialiasing(c, YES);
	CGContextSetShouldAntialias(c, YES);

    CGSize radii = CGSizeMake(self.cornerRadius, self.cornerRadius);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:self.roundedCorners
                                                           cornerRadii:radii];
    CGPathRef path = bezierPath.CGPath;
    
    CGContextSaveGState(c);
    CGContextAddPath(c, path);
    CGContextClip(c);
    
    CGContextSetFillColorWithColor(c, self.backgroundColor.CGColor);
    CGContextFillRect(c, self.bounds);
    CGContextSetFillColorWithColor(c, self.separatorColor.CGColor);
    CGContextFillRect(c, CGRectMake(0, self.bounds.size.height - self.separatorHeight, self.bounds.size.width, self.bounds.size.height - self.separatorHeight));
    
    CGContextRestoreGState(c);
    
}

@end
