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
        [appearance setDividerColor:[UIColor grayColor]];
        [appearance setSelectedFont:[UIFont fontWithName:@"Arial" size:15.0]];
        [appearance setDeselectedFont:[UIFont fontWithName:@"Arial" size:15.0]];
        [appearance setSelectedFontColor:[UIColor whiteColor]];
        [appearance setDeselectedFontColor:[UIColor whiteColor]];
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

- (void)setupFonts {
    
    NSDictionary *selectedAttributesDictionary;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        // iOS6 methods
        if (1 == 1) {
            NSShadow *shadow = [[NSShadow alloc] init];
            [shadow setShadowOffset:CGSizeZero];
            [shadow setShadowColor:[UIColor clearColor]];
            selectedAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                            self.selectedFontColor,
                                            NSForegroundColorAttributeName,
                                            shadow,
                                            NSShadowAttributeName,
                                            self.selectedFont,
                                            NSFontAttributeName,
                                            nil];
        }

#else
        // Pre-iOS6 methods
        selectedAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        self.selectedFontColor,
                                        UITextAttributeTextColor,
                                        [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0],
                                        UITextAttributeTextShadowColor,
                                        [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                        UITextAttributeTextShadowOffset,
                                        self.selectedFont,
                                        UITextAttributeFont,
                                        nil];
#endif
    
    [self setTitleTextAttributes:selectedAttributesDictionary forState:UIControlStateSelected];
    
    NSDictionary *deselectedAttributesDictionary;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        // iOS6 methods
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowOffset:CGSizeZero];
        [shadow setShadowColor:[UIColor clearColor]];
        deselectedAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          self.deselectedFontColor,
                                          NSForegroundColorAttributeName,
                                          shadow,
                                          NSShadowAttributeName,
                                          self.deselectedFont,
                                          NSFontAttributeName,
                                          nil];
#else
        // Pre-iOS6 methods
        deselectedAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          self.deselectedFontColor,
                                          UITextAttributeTextColor,
                                          [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0],
                                          UITextAttributeTextShadowColor,
                                          [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                          UITextAttributeTextShadowOffset,
                                          self.deselectedFont,
                                          UITextAttributeFont,
                                          nil];
#endif
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
    
    UIImage *dividerImage = [[UIImage imageWithColor:self.dividerColor cornerRadius:0] imageWithMinimumSize:CGSizeMake(1, 1)];
    
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:deselectedBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:dividerImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:dividerImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:dividerImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setDividerImage:dividerImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

}

@end
