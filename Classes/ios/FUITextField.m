//
//  FUITextField.m
//  FlatUI
//
//  Created by Andrej Mihajlov on 8/25/13.
//  Copyright (c) 2013 Andrej Mihajlov. All rights reserved.
//

#import "FUITextField.h"
#import "UIImage+FlatUI.h"

@implementation FUITextField {
	UIImage* _flatBackgroundImage;
	UIImage* _flatHighlightedBackgroundImage;
}

- (void)setTextFieldColor:(UIColor *)textFieldColor {
	_textFieldColor = textFieldColor;
	[self configureTextField];
}

- (void)setBorderColor:(UIColor *)borderColor {
	_borderColor = borderColor;
	[self configureTextField];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	_borderWidth = borderWidth;
	[self configureTextField];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	_cornerRadius = cornerRadius;
	[self configureTextField];
}

- (void)setTextColor:(UIColor *)textColor {
	[super setTextColor:textColor];
	
	// Setup placeholder color with 60% alpha of original text color
	if([self respondsToSelector:@selector(setAttributedPlaceholder:)] && self.placeholder) {
		self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{ NSForegroundColorAttributeName: [self.textColor colorWithAlphaComponent:.6] }];
	}
}

- (void)configureTextField {
	_flatBackgroundImage = [self textFieldImageWithColor:_textFieldColor borderColor:_borderColor borderWidth:0 cornerRadius:_cornerRadius];
	_flatHighlightedBackgroundImage = [self textFieldImageWithColor:_textFieldColor borderColor:_borderColor borderWidth:_borderWidth cornerRadius:_cornerRadius];
	
	[self setBackground:_flatBackgroundImage];
}

// A helper method to draw a simple rounded rectangle image that can be used as background
- (UIImage*)textFieldImageWithColor:(UIColor*)color borderColor:(UIColor*)borderColor
						borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius {
	CGRect rect = CGRectMake(0, 0, 44, 44);
	UIBezierPath* bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) cornerRadius:cornerRadius];
	
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	[color setFill];
	[borderColor setStroke];
	
	CGContextSetLineWidth(ctx, borderWidth);
	CGContextAddPath(ctx, [bezierPath CGPath]);
	CGContextDrawPath(ctx, kCGPathFillStroke);
	
	UIImage* output = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return [output resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius*2, cornerRadius*2, cornerRadius*2, cornerRadius*2)];
}

// Both methods make some space around text
- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
	bounds.origin.x += self.edgeInsets.left;
	return [super leftViewRectForBounds:bounds];
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
	bounds.origin.x -= self.edgeInsets.right;
	return [super rightViewRectForBounds:bounds];
}

// Switch background image to bordered image
- (BOOL)becomeFirstResponder {
	BOOL flag = [super becomeFirstResponder];
	if(flag) {
		self.background = _flatHighlightedBackgroundImage;
	}
	return flag;
}

// Switch background image to borderless image
- (BOOL)resignFirstResponder {
	BOOL flag = [super resignFirstResponder];
	if(flag) {
		self.background = _flatBackgroundImage;
	}
	return flag;
}

@end
