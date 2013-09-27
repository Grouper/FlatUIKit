//
//  FUISegmentedControl.m
//  FlatUIKitExample
//
//  Created by Alex Medearis on 5/17/13.
//
//

#import "FUISegmentedControl.h"
#import "UIImage+FlatUI.h"

@implementation FUISegmentedControl

+ (void)initialize {
    if (self == [FUISegmentedControl class]) {
        FUISegmentedControl *appearance = [self appearance];
        [appearance setCornerRadius:5.0f];
        [appearance setSelectedColor:[UIColor blueColor]];
        [appearance setDeselectedColor:[UIColor darkGrayColor]];
        [appearance setSelectedFont:[UIFont fontWithName:@"Arial" size:15.0]];
        [appearance setDeselectedFont:[UIFont fontWithName:@"Arial" size:15.0]];
        [appearance setSelectedFontColor:[UIColor whiteColor]];
        [appearance setDeselectedFontColor:[UIColor whiteColor]];
        [appearance setBorderColor:[UIColor blueColor]];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.needsLayoutSubviews) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        
        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone && UIInterfaceOrientationIsLandscape(orientation)) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 22);
        } else {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 30);
        }
    }
}

- (void)setDeselectedColor:(UIColor *)deselectedColor {
    _deselectedColor = deselectedColor;
    [self configureFlatSegmentedControl];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    [self configureFlatSegmentedControl];
}

- (void)setDividerColor:(UIColor *)dividerColor {
    _dividerColor = dividerColor;
    [self configureFlatSegmentedControl];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self configureFlatSegmentedControl];
}

- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
    [self setupFonts];
}

- (void)setSelectedFontColor:(UIColor *)selectedFontColor {
    _selectedFontColor = selectedFontColor;
    [self setupFonts];
}

- (void)setDeselectedFont:(UIFont *)deselectedFont {
    _deselectedFont = deselectedFont;
    [self setupFonts];
}

- (void)setDeselectedFontColor:(UIColor *)deselectedFontColor {
    _deselectedFontColor = deselectedFontColor;
    [self setupFonts];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self configureFlatSegmentedControl];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self configureFlatSegmentedControl];
}

- (void)setupFonts {
    NSDictionary * selectedAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   self.selectedFontColor,
                                                   UITextAttributeTextColor,
                                                   [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0],
                                                   UITextAttributeTextShadowColor,
                                                   [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                   UITextAttributeTextShadowOffset,
                                                   self.selectedFont,
                                                   UITextAttributeFont,
                                                   nil];
    [self setTitleTextAttributes:selectedAttributesDictionary forState:UIControlStateSelected];
    
    
    NSDictionary * deselectedAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     self.deselectedFontColor,
                                                     UITextAttributeTextColor,
                                                     [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0],
                                                     UITextAttributeTextShadowColor,
                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                     UITextAttributeTextShadowOffset,
                                                     self.deselectedFont,
                                                     UITextAttributeFont,
                                                     nil];
    [self setTitleTextAttributes:deselectedAttributesDictionary forState:UIControlStateNormal];
}

- (void)configureFlatSegmentedControl {
    
    UIImage *selectedBackgroundImage = [UIImage buttonImageWithColor:self.selectedColor
                                                        cornerRadius:self.cornerRadius
                                                         shadowColor:[UIColor clearColor]
                                                        shadowInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *deselectedBackgroundImage = [UIImage buttonImageWithColor:self.deselectedColor
                                                          cornerRadius:self.cornerRadius
                                                           shadowColor:[UIColor clearColor]
                                                          shadowInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
    UIColor *selectedColor = (self.dividerColor) ? self.dividerColor : self.selectedColor;
    UIColor *deselectedColor = (self.dividerColor) ? self.dividerColor : self.deselectedColor;
    UIImage *selectedDividerImage = [[UIImage imageWithColor:selectedColor cornerRadius:0] imageWithMinimumSize:CGSizeMake(1, 1)];
    UIImage *deselectedDividerImage = [[UIImage imageWithColor:deselectedColor cornerRadius:0] imageWithMinimumSize:CGSizeMake(1, 1)];
    
    
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:deselectedBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:deselectedDividerImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:selectedDividerImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:deselectedDividerImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setDividerImage:selectedDividerImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = self.cornerRadius;
}

@end