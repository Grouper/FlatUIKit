//
//  TableViewController.m
//  FlatUIKitExample
//
//  Created by Maciej Swic on 2013-05-31.
//
//

#import "TableViewController.h"

#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"

static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Table View";
    
    //Set the separator color
    self.tableView.separatorColor = [UIColor cloudsColor];
    
    //Set the background color
    self.tableView.backgroundColor = [UIColor cloudsColor];
    self.tableView.backgroundView = nil;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FUITableViewControllerCellReuseIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section % 2)
        return 3;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIRectCorner corners = 0;
    if (tableView.style == UITableViewStyleGrouped) {
        if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
            corners = UIRectCornerAllCorners;
        } else if (indexPath.row == 0) {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
    }
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:FUITableViewControllerCellReuseIdentifier];
    [cell configureFlatCellWithColor:[UIColor greenSeaColor]
                       selectedColor:[UIColor cloudsColor]
                     roundingCorners:corners];
    
    cell.cornerRadius = 5.f; //Optional
    if (self.tableView.style == UITableViewStyleGrouped) {
        cell.separatorHeight = 2.f; //Optional
    } else {
        cell.separatorHeight = 0.;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Section %ld Row %ld", (long)indexPath.section, (long)indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
