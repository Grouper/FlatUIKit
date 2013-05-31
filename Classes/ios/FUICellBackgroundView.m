//
//  UACellBackgroundView.m
//  FlatUI
//
//  Created by Maciej Swic on 2013-05-30.
//  Licensed under the MIT license.

#import "FUICellBackgroundView.h"

@implementation FUICellBackgroundView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.cornerRadius = 3.0f;
        self.separatorHeight = 1.0f;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	}

	return self;
}

- (BOOL)isOpaque {
	return NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //Determine position
    UITableView* tableView = (UITableView*)self.superview.superview;
    NSIndexPath* indexPath = [tableView indexPathForCell:(UITableViewCell*)self.superview];
    
    if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
        self.position = FUICellBackgroundViewPositionSingle;
    }
    else if (indexPath.row == 0) {
        self.position = FUICellBackgroundViewPositionTop;
    }
    else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        self.position = FUICellBackgroundViewPositionBottom;
    }
    else {
        self.position = UACellBackgroundViewPositionMiddle;
    }
    
    self.separatorColor = tableView.separatorColor;
}

- (void)drawRect:(CGRect)aRect {
    //Determine tableView style
    UITableView* tableView = (UITableView*)self.superview.superview;
    if (tableView.style != UITableViewStyleGrouped) {
        self.cornerRadius = 0.f;
    }
    
    CGContextRef c = UIGraphicsGetCurrentContext();

	int lineWidth = 1;

	CGRect rect = [self bounds];
	CGFloat minX = CGRectGetMinX(rect), midX = CGRectGetMidX(rect), maxX = CGRectGetMaxX(rect);
	CGFloat minY = CGRectGetMinY(rect), midY = CGRectGetMidY(rect), maxY = CGRectGetMaxY(rect);
	minY -= 1;

	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGContextSetStrokeColorWithColor(c, [[UIColor grayColor] CGColor]);
	CGContextSetLineWidth(c, lineWidth);
	CGContextSetAllowsAntialiasing(c, YES);
	CGContextSetShouldAntialias(c, YES);

	if (self.position == FUICellBackgroundViewPositionTop) {
		minY += 1;
        
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, minX, maxY);
		CGPathAddArcToPoint(path, NULL, minX, minY, midX, minY, self.cornerRadius);
		CGPathAddArcToPoint(path, NULL, maxX, minY, maxX, maxY, self.cornerRadius);
		CGPathAddLineToPoint(path, NULL, maxX, maxY);
		CGPathAddLineToPoint(path, NULL, minX, maxY);
		CGPathCloseSubpath(path);

		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);
        
        CGContextSetFillColorWithColor(c, self.backgroundColor.CGColor);
        CGContextFillRect(c, self.bounds);
        CGContextSetFillColorWithColor(c, self.separatorColor.CGColor);
        CGContextFillRect(c, CGRectMake(0, self.bounds.size.height - self.separatorHeight, self.bounds.size.width, self.bounds.size.height - self.separatorHeight));
        
		CGContextAddPath(c, path);
		CGPathRelease(path);
        CGContextRestoreGState(c);
	} else if (self.position == FUICellBackgroundViewPositionBottom) {
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, minX, minY);
		CGPathAddArcToPoint(path, NULL, minX, maxY, midX, maxY, self.cornerRadius);
		CGPathAddArcToPoint(path, NULL, maxX, maxY, maxX, minY, self.cornerRadius);
		CGPathAddLineToPoint(path, NULL, maxX, minY);
		CGPathAddLineToPoint(path, NULL, minX, minY);
		CGPathCloseSubpath(path);

		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);

		CGContextSetFillColorWithColor(c, self.backgroundColor.CGColor);
        CGContextFillRect(c, self.bounds);
        if (self.cornerRadius == 0.f) {
            CGContextSetFillColorWithColor(c, self.separatorColor.CGColor);
            CGContextFillRect(c, CGRectMake(0, self.bounds.size.height - self.separatorHeight, self.bounds.size.width, self.bounds.size.height - self.separatorHeight));
        }

		CGContextAddPath(c, path);
		CGPathRelease(path);
		CGContextRestoreGState(c);
	} else if (self.position == UACellBackgroundViewPositionMiddle) {
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, minX, minY);
		CGPathAddLineToPoint(path, NULL, maxX, minY);
		CGPathAddLineToPoint(path, NULL, maxX, maxY);
		CGPathAddLineToPoint(path, NULL, minX, maxY);
		CGPathAddLineToPoint(path, NULL, minX, minY);
		CGPathCloseSubpath(path);

		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);

		CGContextSetFillColorWithColor(c, self.backgroundColor.CGColor);
        CGContextFillRect(c, self.bounds);
        CGContextSetFillColorWithColor(c, self.separatorColor.CGColor);
        CGContextFillRect(c, CGRectMake(0, self.bounds.size.height - self.separatorHeight, self.bounds.size.width, self.bounds.size.height - self.separatorHeight));

		CGContextAddPath(c, path);
		CGPathRelease(path);
		CGContextRestoreGState(c);
	} else if (self.position == FUICellBackgroundViewPositionSingle) {
		minY += 1;

		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, minX, midY);
		CGPathAddArcToPoint(path, NULL, minX, minY, midX, minY, self.cornerRadius);
		CGPathAddArcToPoint(path, NULL, maxX, minY, maxX, midY, self.cornerRadius);
		CGPathAddArcToPoint(path, NULL, maxX, maxY, midX, maxY, self.cornerRadius);
		CGPathAddArcToPoint(path, NULL, minX, maxY, minX, midY, self.cornerRadius);
		CGPathCloseSubpath(path);

		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);

		CGContextSetFillColorWithColor(c, self.backgroundColor.CGColor);
        CGContextFillRect(c, self.bounds);

		CGContextAddPath(c, path);
		CGPathRelease(path);
		CGContextRestoreGState(c);
	}

	CGColorSpaceRelease(colorspace);
}

- (void)setPosition:(FUICellBackgroundViewPosition)position {
    _position = position;
    
    [self setNeedsDisplay];
}

@end
