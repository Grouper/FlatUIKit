//
//  FUITableViewCellTests.m
//  FUIKitTestsTests
//
//  Copyright (c) 2013 Grouper. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "UITableViewCell+FlatUI.h"
#import "FUICellBackgroundView.h"
#import "SenTestCase+FUITestHelpers.h"

#define EXP_SHORTHAND YES
#import <Expecta.h>

@interface FUITableViewCellTests : SenTestCase

@end

@implementation FUITableViewCellTests


- (void)testFlatBackgroundsWithInstanceMethodConfigureFlatCell {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell* tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    [tableViewCell configureFlatCellWithColor:[UIColor whiteColor] selectedColor:[UIColor blackColor]];
    
    expect(tableViewCell.backgroundView).to.beInstanceOf([FUICellBackgroundView class]);
    expect(tableViewCell.selectedBackgroundView).to.beInstanceOf([FUICellBackgroundView class]);
}

- (void)testFlatBackgroundsWithStaticMethodConfigureFlatCell {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell* tableViewCell = [UITableViewCell configureFlatCellWithColor:[UIColor whiteColor] selectedColor:[UIColor blackColor] style:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    expect(tableViewCell.backgroundView).to.beInstanceOf([FUICellBackgroundView class]);
    expect(tableViewCell.selectedBackgroundView).to.beInstanceOf([FUICellBackgroundView class]);
}



@end
