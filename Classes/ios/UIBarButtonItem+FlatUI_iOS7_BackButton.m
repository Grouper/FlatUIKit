//
//  UIBarButtonItem+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/8/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIBarButtonItem+FlatUI_iOS7_BackButton.h"
#import "UIImage+FlatUI.h"

/*** UNEXPECTED ****
 
 - not sure where the maintainer wants this method
 
 *******************/

@interface UIImage (FlatKit_UIBarButtonItem_iOS7_BackButton)

/**
 @return returns an iOS 7 style cheveron back button
 @param aColor the color of the chevron
 @param aMetric the bar metrics
 */
+ (UIImage *) backButtonImageWith_iOS7_style_WithChevronColor:(UIColor *) aColor
                                                   barMetrics:(UIBarMetrics) aMetrics;



@end


@implementation UIImage (FlatKit_UIBarButtonItem_iOS7_BackButton)

+ (UIImage *) backButtonImageWith_iOS7_style_WithChevronColor:(UIColor *) aColor
                                                   barMetrics:(UIBarMetrics) aMetrics {
    CGSize size = aMetrics == UIBarMetricsDefault ? CGSizeMake(50, 30) : CGSizeMake(60, 23);
    
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);
    CGContextSetLineWidth(context, 3.0f);
    
    /*** UNEXPECTED *****
     
     - not tested on portrait rotation (non-default bar metrics)
     
     *******************/
    
    static CGFloat const k_tip_x = 6;
    static CGFloat const k_wing_x = 14;
    static CGFloat const k_wing_y_offset = 6;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGPoint tip = CGPointMake(k_tip_x, CGRectGetMidY(rect));
    CGPoint top = CGPointMake(k_wing_x, CGRectGetMinY(rect) + k_wing_y_offset);
    CGPoint bottom = CGPointMake(k_wing_x, CGRectGetMaxY(rect) - k_wing_y_offset);
    CGContextMoveToPoint(context, top.x, top.y);
    CGContextAddLineToPoint(context, tip.x, tip.y);
    CGContextAddLineToPoint(context, bottom.x, bottom.y);
    CGContextStrokePath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // avoid tiling by stretching from the right-hand side only
    UIEdgeInsets insets = UIEdgeInsetsMake(k_wing_y_offset + 1, k_wing_x + 1,
                                           k_wing_y_offset + 1, 1);
    if ([image respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)]) {
        return [image resizableImageWithCapInsets:insets
                                     resizingMode:UIImageResizingModeStretch];
    } else {
        return [image resizableImageWithCapInsets:insets];
    }
}

@end


@interface UIBarButtonItem (FlatUI_iOS7_BackButton_PRIVATE)

+ (UIColor *) colorFor_iOS7_BackButton;
+ (UIFont *) fontFor_iOS7_BackButton;

+ (void) configure_iOS7_style_BackButtonItemOrProxy:(id)appearance
                                  withCheveronColor:(UIColor *) aCheveronColor;

- (void) setTitleFont_iOS7_BackButton:(UIFont *) aTitleFont;


@end


@implementation UIBarButtonItem (FlatUI_iOS7_BackButton)



#pragma mark - iOS Style Back Button for iOS 5 + 6

+ (UIColor *)  colorFor_iOS7_BackButton {
    static UIColor *ios7_blue_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ios7_blue_singleton = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:245/255.0f alpha:1.0f];
    });
    
    return ios7_blue_singleton;
}

+ (UIFont *) fontFor_iOS7_BackButton {
    // font is not quiet right
    static UIFont *ios7_navbar_font_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        static NSString *const fontName = @"HelveticaNeue";
        ios7_navbar_font_singleton = [UIFont fontWithName:fontName size:17];
    });
    return ios7_navbar_font_singleton;
}

- (void) setTitleFont_iOS7_BackButton:(UIFont *) aTitleFont {
    NSArray *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted)];
    for (NSNumber *state in states) {
        UIControlState controlState = [state unsignedIntegerValue];
        NSMutableDictionary *titleTextAttributes = [[self titleTextAttributesForState:controlState] mutableCopy];
        if (!titleTextAttributes) {
            titleTextAttributes = [NSMutableDictionary dictionary];
        }
        
        /*** UNEXPECTED ***
         UITextAttributeShadowOffset is deprecated in 5.0 - replaced with NSFontAttributeName
         - tried using NSFontAttributeName but the font does not change
         ******************/
        [titleTextAttributes setObject:aTitleFont forKey:UITextAttributeFont];
        [self setTitleTextAttributes:titleTextAttributes forState:controlState];
    }
}

+ (void) configure_iOS7_style_BackButtonItemOrProxy:(id)appearance
                                  withCheveronColor:(UIColor *) aCheveronColor {
    
    // normal and highlighted are the same
    UIImage *metricsDefaultImage = [UIImage backButtonImageWith_iOS7_style_WithChevronColor:aCheveronColor
                                                                                 barMetrics:UIBarMetricsDefault];
    UIImage *metricsLandscapeImage =  [UIImage backButtonImageWith_iOS7_style_WithChevronColor:aCheveronColor
                                                                                    barMetrics:UIBarMetricsLandscapePhone];
    
    
    [appearance setBackButtonBackgroundImage:metricsDefaultImage
                                    forState:UIControlStateNormal
                                  barMetrics:UIBarMetricsDefault];
    [appearance setBackButtonBackgroundImage:metricsLandscapeImage
                                    forState:UIControlStateNormal
                                  barMetrics:UIBarMetricsLandscapePhone];
    [appearance setBackButtonBackgroundImage:metricsDefaultImage
                                    forState:UIControlStateHighlighted
                                  barMetrics:UIBarMetricsDefault];
    [appearance setBackButtonBackgroundImage:metricsLandscapeImage
                                    forState:UIControlStateHighlighted
                                  barMetrics:UIBarMetricsLandscapePhone];
    
    [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(6.0f, -3.0f) forBarMetrics:UIBarMetricsDefault];
    [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(6.0f, -3.0f) forBarMetrics:UIBarMetricsLandscapePhone];
    
}

+ (UIBarButtonItem *) barButtonItem_iOS7_styleWithChevronColor:(UIColor *) aChevronColorOrNil {
    UIBarButtonItem *back = [[UIBarButtonItem alloc]
                             // will be hidden
                             initWithTitle:@"back"
                             // plain or bordered does not matter
                             style:UIBarButtonItemStylePlain
                             target:nil
                             action:nil];
    
    
    
    UIColor *color = aChevronColorOrNil ? aChevronColorOrNil : [UIBarButtonItem colorFor_iOS7_BackButton];
    
    [UIBarButtonItem configure_iOS7_style_BackButtonItemOrProxy:back withCheveronColor:color];
    
    // hide the text
    // maybe we should pass the navbar color?
    UIColor *clear = [UIColor clearColor];
    [back setTitleColor:clear highlighted:clear removeShadow:YES];
    
    
    return back;
}


+ (UIBarButtonItem *) barButtonItem_iOS7_styleWithTitle:(NSString *) aTitleOrNil
                                           chevronColor:(UIColor *) aChevronColorOrNil
                                             titleColor:(UIColor *) aTitleColorOrNil
                                       highlightedColor:(UIColor *) aHighlightedColorOrNil {
    
    // we need a non-zero length title or the button will not appear (iirc)
    // in iOS 7 the default title is "Back" (i think.)
    NSString *title = aTitleOrNil;
    if (title == nil || [title length] == 0) {
        title = NSLocalizedString(@"Back", @"bar button title: touching brings you back to where you where");
    }
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]
                             // will be hidden
                             initWithTitle:title
                             // plain or bordered does not matter
                             style:UIBarButtonItemStylePlain
                             target:nil
                             action:nil];
    
    
    UIColor *ios7_blue = [UIBarButtonItem colorFor_iOS7_BackButton];
    UIColor *chevronColor = aChevronColorOrNil ? aChevronColorOrNil : ios7_blue;
    
    [UIBarButtonItem configure_iOS7_style_BackButtonItemOrProxy:back withCheveronColor:chevronColor];
    
    // on iOS 7 it looks like the highlight color is a transparency of the title color
    UIColor *titleColor = aTitleColorOrNil ? aTitleColorOrNil : ios7_blue;
    UIColor *highlightColor = aHighlightedColorOrNil ? aHighlightedColorOrNil : [titleColor colorWithAlphaComponent:0.5f];
    
    
    [back setTitleColor:titleColor highlighted:highlightColor removeShadow:YES];
    [back setTitleFont_iOS7_BackButton:[UIBarButtonItem fontFor_iOS7_BackButton]];
    
    return back;
}


@end
