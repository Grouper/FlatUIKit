//
//  FUISegmentedControl.m
//  FlatUIKitExample
//
//  Created by Alex Medearis on 5/17/13.
//
//

#import "FUISegmentedControl.h"
#import "UIImage+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@implementation FUISegmentedControl

+ (void)initialize {
    if (self == [FUISegmentedControl class]) {
        FUISegmentedControl *appearance = [self appearance];
        [appearance setCornerRadius:5.0f];
        [appearance setSelectedColor:[UIColor blueColor]];
        [appearance setDeselectedColor:[UIColor darkGrayColor]];
        [appearance setSelectedFontColor:[UIColor whiteColor]];
        [appearance setDeselectedFontColor:[UIColor whiteColor]];
        [appearance setHighlightedColor:[UIColor grayColor]];
        [appearance setHighlightedFontColor:[UIColor whiteColor]];
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

- (void)setHighlightedColor:(UIColor *)highlightedColor {
    _highlightedColor = highlightedColor;
    [self configureFlatSegmentedControl];
}

- (void)setDisabledColor:(UIColor *)disabledColor {
    _disabledColor = disabledColor;
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

- (void)setDisabledFont:(UIFont *)disabledFont {
    _disabledFont = disabledFont;
    [self setupFonts];
}

- (void)setDisabledFontColor:(UIColor *)disabledFontColor {
    _disabledFontColor = disabledFontColor;
    [self setupFonts];
}

- (void)setHighlightedFont:(UIFont *)highlightedFont {
    _highlightedFont = highlightedFont;
    [self setupFonts];
}

- (void)setHighlightedFontColor:(UIColor *)highlightedFontColor {
    _highlightedFontColor = highlightedFontColor;
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
	// Although iOS 6 supports NSForegroundColorAttributeName,
	// it doesn't seem to apply it to deselected segments but will apply the
	// old UITextAttributeTextColor attribute. We therefore do a runtime version
	// check and use the old attributes when needed

    NSDictionary *selectedAttributesDictionary;
    
	if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
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
    } else {
        // iOS6- methods
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
    }
    
    [self setTitleTextAttributes:selectedAttributesDictionary forState:UIControlStateSelected];
    
    NSDictionary *deselectedAttributesDictionary;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        // iOS7+ methods
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
	} else {
        // iOS6- methods.
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
    }
    [self setTitleTextAttributes:deselectedAttributesDictionary forState:UIControlStateNormal];

    NSDictionary *disabledAttributesDictionary;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        // iOS7+ methods
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowOffset:CGSizeZero];
        [shadow setShadowColor:[UIColor clearColor]];
        disabledAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                self.disabledFontColor,
                NSForegroundColorAttributeName,
                shadow,
                NSShadowAttributeName,
                self.disabledFont,
                NSFontAttributeName,
                nil];
    } else {
        // iOS6- methods
        disabledAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                self.disabledFontColor,
                UITextAttributeTextColor,
                [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0],
                UITextAttributeTextShadowColor,
                [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                UITextAttributeTextShadowOffset,
                self.disabledFont,
                UITextAttributeFont,
                nil];
    }

    [self setTitleTextAttributes:disabledAttributesDictionary forState:UIControlStateDisabled];
    
    
    NSDictionary *highlightedAttributesDictionary;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        // iOS7+ methods
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowOffset:CGSizeZero];
        [shadow setShadowColor:[UIColor clearColor]];
        highlightedAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        self.highlightedFontColor,
                                        NSForegroundColorAttributeName,
                                        shadow,
                                        NSShadowAttributeName,
                                        self.highlightedFont,
                                        NSFontAttributeName,
                                        nil];
    } else {
        // iOS6- methods
        highlightedAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        self.highlightedFontColor,
                                        UITextAttributeTextColor,
                                        [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0],
                                        UITextAttributeTextShadowColor,
                                        [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                        UITextAttributeTextShadowOffset,
                                        self.highlightedFont,
                                        UITextAttributeFont,
                                        nil];
    }
    
    [self setTitleTextAttributes:highlightedAttributesDictionary forState:UIControlStateHighlighted];
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
    UIImage *disabledBackgroundImage = [UIImage buttonImageWithColor:self.disabledColor
                                                          cornerRadius:self.cornerRadius
                                                           shadowColor:[UIColor clearColor]
                                                          shadowInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *highlightedBackgroundImage = [UIImage buttonImageWithColor:self.highlightedColor
                                                        cornerRadius:self.cornerRadius
                                                         shadowColor:[UIColor clearColor]
                                                        shadowInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIColor *selectedColor = (self.dividerColor) ? self.dividerColor : self.selectedColor;
    UIColor *deselectedColor = (self.dividerColor) ? self.dividerColor : self.deselectedColor;
    UIImage *selectedDividerImage = [[UIImage imageWithColor:selectedColor cornerRadius:0] imageWithMinimumSize:CGSizeMake(1, 1)];
    UIImage *deselectedDividerImage = [[UIImage imageWithColor:deselectedColor cornerRadius:0] imageWithMinimumSize:CGSizeMake(1, 1)];
    
    
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:deselectedBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];

    [self setDividerImage:deselectedDividerImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:selectedDividerImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:deselectedDividerImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setDividerImage:selectedDividerImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = self.cornerRadius;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger previousSelectedSegmentIndex = self.selectedSegmentIndex;
    [super touchesBegan:touches withEvent:event];
    [self sendActionsForControlEvents:UIControlEventTouchDown];
    if (!(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)) {
        // before iOS7 the segment is selected in touchesBegan
        if (previousSelectedSegmentIndex == self.selectedSegmentIndex) {
            // if the selectedSegmentIndex before the selection process is equal to the selectedSegmentIndex
            // after the selection process the superclass won't send a UIControlEventValueChanged event.
            // So we have to do this ourselves.
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger previousSelectedSegmentIndex = self.selectedSegmentIndex;
    [super touchesEnded:touches withEvent:event];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        // on iOS7 the segment is selected in touchesEnded
        if (previousSelectedSegmentIndex == self.selectedSegmentIndex) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

@end
