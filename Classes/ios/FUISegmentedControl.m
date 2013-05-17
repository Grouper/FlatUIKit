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

@implementation FUISegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self defaultColors];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self defaultColors];
    }
    return self;
}

- (void)defaultColors{
    self.cornerRadius = 5.0;
    self.selectedColor = [UIColor belizeHoleColor];
    self.deselectedColor = [UIColor silverColor];
    self.dividerColor = [UIColor grayColor];
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
