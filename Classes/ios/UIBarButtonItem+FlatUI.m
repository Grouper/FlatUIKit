//
//  UIBarButtonItem+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/8/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIBarButtonItem+FlatUI.h"
#import "UIImage+FlatUI.h"

/**** DEBUG *****
 
 i did not want to expose the
 
 backButtonImageWith_iOS7_style_WithColor: barMetrics: 
 
 in the UIImage category, but needed this to demonstrate the clipping problem
 with an opaque fill
 ****************/
 
@interface UIImage (FlatKit)

// suppresses compiler warnings
+ (UIBezierPath *) bezierPathForBackButtonInRect:(CGRect)rect cornerRadius:(CGFloat)radius;

@end
 
/*********************/
@interface UIImage (FlatKit_UIBarButtonItem_iOS7)

/**
 @return returns an iOS 7 style cheveron back button
 @param aColor the color of the chevron
 @param aMetric the bar metrics
 */
+ (UIImage *) backButtonImageWith_iOS7_style_WithChevronColor:(UIColor *) aColor
                                            barMetrics:(UIBarMetrics) aMetrics;



@end


@implementation UIImage (FlatKit_UIBarButtonItem_iOS7)

+ (UIImage *) backButtonImageWith_iOS7_style_WithChevronColor:(UIColor *) aColor
                                                   barMetrics:(UIBarMetrics) aMetrics {
    // changing the width does not help with the clipping problem
    CGSize size = aMetrics == UIBarMetricsDefault ? CGSizeMake(50, 30) : CGSizeMake(60, 23);
    
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);
    CGContextSetLineWidth(context, 2.5f);
    
    /*** UNEXPECTED *****
     
     - not tested on portrait rotation (non-default bar metrics)
     
     - the constants are heuristics - if you think you can improve on them, go for it
     
     *******************/
    static CGFloat const k_tip_x = 8;
    static CGFloat const k_wing_x = 16;
    static CGFloat const k_wing_y_offset = 6;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGPoint tip = CGPointMake(k_tip_x, CGRectGetMidY(rect));
    CGPoint top = CGPointMake(k_wing_x, CGRectGetMinY(rect) + k_wing_y_offset);
    CGPoint bottom = CGPointMake(k_wing_x, CGRectGetMaxY(rect) - k_wing_y_offset);
    CGContextMoveToPoint(context, top.x, top.y);
    CGContextAddLineToPoint(context, tip.x, tip.y);
    CGContextAddLineToPoint(context, bottom.x, bottom.y);
    CGContextStrokePath(context);
 
    /**** DEBUG *****/
    // uncomment to see the clipping
    /*
    UIBezierPath *path = [self bezierPathForBackButtonInRect:CGRectMake(0, 0, size.width, size.height)
                                                    cornerRadius:0.0];

    [[UIColor lightGrayColor] setFill];
    [path addClip];
    [path fill];
     */
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // can something be done with the edge insets
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                                 resizingMode:UIImageResizingModeStretch];
}

@end


// private
@interface UIBarButtonItem (FlatKit)

+ (UIColor *) iOS7_blueColor;
+ (UIFont *) iOS7_navbarFont;

+ (void) configure_iOS7_style_BackButtonItemOrProxy:(id)appearance
                                  withCheveronColor:(UIColor *) aCheveronColor;

- (void) setTitleFont:(UIFont *) aTitleFont;


@end


@implementation UIBarButtonItem (FlatUI)

- (void) configureFlatButtonWithColor:(UIColor *)color
                     highlightedColor:(UIColor *)highlightedColor
                         cornerRadius:(CGFloat) cornerRadius {
  
  [UIBarButtonItem configureItemOrProxy:self forFlatButtonWithColor:color highlightedColor:highlightedColor cornerRadius:cornerRadius];
  
}

+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius {
  
  [self configureFlatButtonsWithColor:color highlightedColor:highlightedColor cornerRadius:cornerRadius whenContainedIn:[UINavigationBar class], [UINavigationController class], [UIToolbar class], nil];
}

+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius
                       whenContainedIn:(Class <UIAppearanceContainer>)containerClass, ... {
  va_list vl;
  va_start(vl, containerClass);
  id appearance = [UIBarButtonItem appearanceWhenContainedIn:containerClass, nil];
  va_end(vl);
  [UIBarButtonItem configureItemOrProxy:appearance forFlatButtonWithColor:color highlightedColor:highlightedColor cornerRadius:cornerRadius];
}


- (void) removeTitleShadow {
  NSArray *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted)];
  
  for (NSNumber *state in states) {
    UIControlState controlState = [state unsignedIntegerValue];
    NSMutableDictionary *titleTextAttributes = [[self titleTextAttributesForState:controlState] mutableCopy];
    if (!titleTextAttributes) {
      titleTextAttributes = [NSMutableDictionary dictionary];
    }

    /*** UNEXPECTED ***
     UITextAttributeShadowOffset is deprecated in 5.0 - replaced with NSShadow
     - tried using NSShadow, but the shadow on the title remained
     - shadowOffset <== {0,0}, shadowColor <== nil (shadow not drawn according to docs)
     ******************/
    [titleTextAttributes setValue:[NSValue valueWithUIOffset:UIOffsetZero] forKey:UITextAttributeTextShadowOffset];
    [titleTextAttributes setObject:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
    [self setTitleTextAttributes:titleTextAttributes forState:controlState];
  }
}

- (void) setTitleColor:(UIColor *) aColor
           highlighted:(UIColor *) aHighlightedColor
          removeShadow:(BOOL) aRemoveShadow {
    NSArray *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted)];
    for (NSNumber *state in states) {
        UIControlState controlState = [state unsignedIntegerValue];
        
        NSMutableDictionary *titleTextAttributes = [[self titleTextAttributesForState:controlState] mutableCopy];
        if (!titleTextAttributes) { titleTextAttributes = [NSMutableDictionary dictionary]; }
        
        UIColor *color = controlState == UIControlStateNormal ? aColor : aHighlightedColor;
        [titleTextAttributes setObject:color forKey:UITextAttributeTextColor];
        [self setTitleTextAttributes:titleTextAttributes forState:controlState];
    }
    if (aRemoveShadow == YES) { [self removeTitleShadow]; }
}


//helper method, basically a wrapper to allow creating a custom UIAppearance method that doesn't conform to the usual naming style
+ (void) configureItemOrProxy:(id)appearance
       forFlatButtonWithColor:(UIColor *)color
             highlightedColor:(UIColor *)highlightedColor
                 cornerRadius:(CGFloat) cornerRadius {
  UIImage *backButtonPortraitImage = [UIImage backButtonImageWithColor:color
                                                            barMetrics:UIBarMetricsDefault
                                                          cornerRadius:cornerRadius];
  UIImage *highlightedBackButtonPortraitImage = [UIImage backButtonImageWithColor:highlightedColor
                                                                       barMetrics:UIBarMetricsDefault
                                                                     cornerRadius:cornerRadius];
  UIImage *backButtonLandscapeImage = [UIImage backButtonImageWithColor:color
                                                             barMetrics:UIBarMetricsLandscapePhone
                                                           cornerRadius:2];
  UIImage *highlightedBackButtonLandscapeImage = [UIImage backButtonImageWithColor:highlightedColor
                                                                        barMetrics:UIBarMetricsLandscapePhone
                                                                      cornerRadius:2];
  
  [appearance setBackButtonBackgroundImage:backButtonPortraitImage
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
  [appearance setBackButtonBackgroundImage:backButtonLandscapeImage
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsLandscapePhone];
  [appearance setBackButtonBackgroundImage:highlightedBackButtonPortraitImage
                                  forState:UIControlStateHighlighted
                                barMetrics:UIBarMetricsDefault];
  [appearance setBackButtonBackgroundImage:highlightedBackButtonLandscapeImage
                                  forState:UIControlStateHighlighted
                                barMetrics:UIBarMetricsLandscapePhone];
  
  [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(1.0f, 1.0f) forBarMetrics:UIBarMetricsDefault];
  [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(1.0f, 1.0f) forBarMetrics:UIBarMetricsLandscapePhone];
  
  UIImage *buttonImageNormal       = [UIImage imageWithColor:color cornerRadius:cornerRadius];
  UIImage *buttonImageHightlighted = [UIImage imageWithColor:highlightedColor cornerRadius:cornerRadius];
  [appearance setBackgroundImage:buttonImageNormal forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  [appearance setBackgroundImage:buttonImageHightlighted forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}


#pragma mark - iOS Style Back Button for iOS 5 + 6

+ (UIColor *) iOS7_blueColor {
    static UIColor *ios7_blue_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ios7_blue_singleton = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:245/255.0f alpha:1.0f];
    });

    return ios7_blue_singleton;
}

+ (UIFont *) iOS7_navbarFont {
    static UIFont *ios7_navbar_font_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        static NSString *const fontName = @"HelveticaNeue-Light";
        ios7_navbar_font_singleton = [UIFont fontWithName:fontName size:17];
    });
    return ios7_navbar_font_singleton;
}

- (void) setTitleFont:(UIFont *) aTitleFont {
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
    
    [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(12.0f, -2.0f) forBarMetrics:UIBarMetricsDefault];
    [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(12.0f, -2.0f) forBarMetrics:UIBarMetricsLandscapePhone];

    /*
     unnecessary ?
    UIImage *buttonImageNormal       = [UIImage imageWithColor:aCheveronColor cornerRadius:cornerRadius];
    UIImage *buttonImageHightlighted = [UIImage imageWithColor:highlightedColor cornerRadius:cornerRadius];
    [appearance setBackgroundImage:buttonImageNormal forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [appearance setBackgroundImage:buttonImageHightlighted forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
     */

}


+ (UIBarButtonItem *) barButtonItem_iOS7_styleWithChevronColor:(UIColor *) aChevronColorOrNil {
    UIBarButtonItem *back = [[UIBarButtonItem alloc]
                             // will be hidden
                             initWithTitle:@"back"
                             // plain or bordered does not matter
                             style:UIBarButtonItemStylePlain
                             target:nil
                             action:nil];
    
    
    
    UIColor *color = aChevronColorOrNil ? aChevronColorOrNil : [UIBarButtonItem iOS7_blueColor];
        
    [UIBarButtonItem configure_iOS7_style_BackButtonItemOrProxy:back withCheveronColor:color];
    
    // hide the text
    // maybe we should pass the navbar color?
    UIColor *clear = [UIColor clearColor];
    [back setTitleColor:clear  highlighted:clear removeShadow:YES];

    
    return back;
}


+ (UIBarButtonItem *) barButtonItem_iOS7_styleWithTitle:(NSString *) aTitleOrNil
                                           chevronColor:(UIColor *) aChevronColorOrNil
                                             titleColor:(UIColor *) aTitleColorOrNil
                                       highlightedColor:(UIColor *) aHighlightedColorOrNil {
    
    // we need a non-zero length title or the button will not appear
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

    
    UIColor *ios7_blue = [UIBarButtonItem iOS7_blueColor];
    UIColor *chevronColor = aChevronColorOrNil ? aChevronColorOrNil : ios7_blue;

    [UIBarButtonItem configure_iOS7_style_BackButtonItemOrProxy:back withCheveronColor:chevronColor];
    
    // on iOS 7 it looks like the highlight color is a transparency of the title color
    UIColor *titleColor = aTitleColorOrNil ? aTitleColorOrNil : ios7_blue;
    UIColor *highlightColor = aHighlightedColorOrNil ? aHighlightedColorOrNil : [titleColor colorWithAlphaComponent:0.5f];
    

    [back setTitleColor:titleColor highlighted:highlightColor removeShadow:YES];
    [back setTitleFont:[UIBarButtonItem iOS7_navbarFont]];

    return back;
}


@end
