//
//  UITableViewCell+FlatUI.m
//  FlatUIKitExample
//
//  Created by Maciej Swic on 2013-05-31.
//
//

#import "UITableViewCell+FlatUI.h"
#import "FUICellBackgroundView.h"
#import <objc/runtime.h>

@implementation UITableViewCell (FlatUI)

@dynamic cornerRadius, separatorHeight;

+ (UITableViewCell*) configureFlatCellWithColor:(UIColor *)color selectedColor:(UIColor *)selectedColor reuseIdentifier:(NSString*)reuseIdentifier inTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    [cell configureFlatCellWithColor:color selectedColor:selectedColor];
    return cell;
}

- (void) configureFlatCellWithColor:(UIColor *)color selectedColor:(UIColor *)selectedColor {
    FUICellBackgroundView* backgroundView = [FUICellBackgroundView new];
    backgroundView.backgroundColor = color;
    self.backgroundView = backgroundView;
    
    FUICellBackgroundView* selectedBackgroundView = [FUICellBackgroundView new];
    selectedBackgroundView.backgroundColor = selectedColor;
    self.selectedBackgroundView = selectedBackgroundView;
    
    //The labels need a clear background color or they will look very funky
    self.textLabel.backgroundColor = [UIColor clearColor];
    if ([self respondsToSelector:@selector(detailTextLabel)])
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    //Guess some good text colors
    self.textLabel.textColor = selectedColor;
    self.textLabel.highlightedTextColor = color;
    if ([self respondsToSelector:@selector(detailTextLabel)]) {
        self.detailTextLabel.textColor = selectedColor;
        self.detailTextLabel.highlightedTextColor = color;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [(FUICellBackgroundView*)self.backgroundView setCornerRadius:cornerRadius];
    [(FUICellBackgroundView*)self.selectedBackgroundView setCornerRadius:cornerRadius];
}

- (void)setSeparatorHeight:(CGFloat)separatorHeight {
    [(FUICellBackgroundView*)self.backgroundView setSeparatorHeight:separatorHeight];
    [(FUICellBackgroundView*)self.selectedBackgroundView setSeparatorHeight:separatorHeight];
}

@end
