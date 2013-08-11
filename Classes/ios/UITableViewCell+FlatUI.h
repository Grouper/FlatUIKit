//
//  UITableViewCell+FlatUI.h
//  FlatUIKitExample
//
//  Created by Maciej Swic on 2013-05-31.
//
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (FlatUI)

@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat separatorHeight;

+ (UITableViewCell*) configureFlatCellWithColor:(UIColor *)color selectedColor:(UIColor *)selectedColor reuseIdentifier:(NSString*)reuseIdentifier inTableView:(UITableView *)tableView;

- (void) configureFlatCellWithColor:(UIColor *)color selectedColor:(UIColor *)selectedColor;

- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setSeparatorHeight:(CGFloat)separatorHeight;

@end
