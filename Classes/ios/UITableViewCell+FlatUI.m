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

+ (UITableViewCell*) configureFlatCellWithColor:(UIColor *)color selectedColor:(UIColor *)selectedColor style:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    FUICellBackgroundView* backgroundView = [FUICellBackgroundView new];
    backgroundView.backgroundColor = color;
    cell.backgroundView = backgroundView;
    
    FUICellBackgroundView* selectedBackgroundView = [FUICellBackgroundView new];
    selectedBackgroundView.backgroundColor = selectedColor;
    cell.selectedBackgroundView = selectedBackgroundView;
    
    //The labels need a clear background color or they will look very funky
    cell.textLabel.backgroundColor = [UIColor clearColor];
    if ([cell respondsToSelector:@selector(detailTextLabel)])
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    //Guess some good text colors
    cell.textLabel.textColor = selectedColor;
    cell.textLabel.highlightedTextColor = color;
    if ([cell respondsToSelector:@selector(detailTextLabel)]) {
        cell.detailTextLabel.textColor = selectedColor;
        cell.detailTextLabel.highlightedTextColor = color;
    }
    
    return cell;
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
