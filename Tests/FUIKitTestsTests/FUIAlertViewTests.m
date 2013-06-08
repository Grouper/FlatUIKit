//
//  FUIKitTestsTests.m
//  FUIKitTestsTests
//
//  Copyright (c) 2013 Grouper. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "FUIAlertView.h"

#define EXP_SHORTHAND YES
#import <Expecta.h>

@interface FUIAlertViewTests : SenTestCase
@property (strong, nonatomic) FUIAlertView *alertView;
@end

@implementation FUIAlertViewTests

- (void)setUp {
    [super setUp];
    self.alertView = [[FUIAlertView alloc] initWithTitle:@"Test Title" message:@"Test message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
}

- (void)testAlertViewInitializesWithTitle {
    expect(self.alertView.title).to.equal(@"Test Title");
    expect(self.alertView.titleLabel.text).to.equal(@"Test Title");
}

- (void)testAlertViewInitializesWithMessage {
    expect(self.alertView.message).to.equal(@"Test message");
    expect(self.alertView.messageLabel.text).to.equal(@"Test message");
}

- (void)testAlertViewInitializesWithOnlyCancelButton {
    expect(self.alertView.buttons.count).to.equal(1);
}

- (void)testAlertViewSetsCorrectCancelButtonTitle {
    UIButton *cancelButton = [self.alertView.buttons objectAtIndex:[self.alertView cancelButtonIndex]];
    expect(cancelButton.titleLabel.text).to.equal(@"Cancel");
}

- (void)testAlertViewCanInitializeWithMultipleButtons {
    FUIAlertView *multiButtonAlert = [[FUIAlertView alloc] initWithTitle:@"Test title" message:@"Test Message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", @"Maybe", nil];
    expect(multiButtonAlert.buttons.count).to.equal(3);
}

- (void)testAlertViewSetsCorrectOtherButtonTitles {
    FUIAlertView *multiButtonAlert = [[FUIAlertView alloc] initWithTitle:@"Test title" message:@"Test message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Title1", @"Title2", nil];
    UIButton *otherButton1 = [multiButtonAlert.buttons objectAtIndex:0];
    UIButton *otherButton2 = [multiButtonAlert.buttons objectAtIndex:1];
    expect(otherButton1.titleLabel.text).to.equal(@"Title1");
    expect(otherButton2.titleLabel.text).to.equal(@"Title2");
}

- (void)testAddButtonWithTitleReturnsCorrectIndex {
    NSInteger buttonIndex = [self.alertView addButtonWithTitle:@"New button"];
    expect(buttonIndex).to.equal(1);
    expect([self.alertView buttonTitleAtIndex:buttonIndex]).to.equal(@"New button");
}

- (void)testAddButtonWithTitleAddsNewButton {
    [self.alertView addButtonWithTitle:@"New button"];
    expect(self.alertView.buttons.count).to.equal(2);
}

//TODO:
//Add tests for delegate methods
//Add tests to check alert view is visible after being shown

@end
