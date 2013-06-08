//
//  FUIKitTestsTests.m
//  FUIKitTestsTests
//
//  Copyright (c) 2013 Grouper. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "FUIAlertView.h"
#import "SenTestCase+FUITestHelpers.h"

#define EXP_SHORTHAND YES
#import <Expecta.h>

@interface FUIAlertViewTests : SenTestCase <FUIAlertViewDelegate>
@property (strong, nonatomic) FUIAlertView *alertView;

//Delegate method flags
@property (nonatomic)  BOOL willPresent;
@property (nonatomic)  BOOL didPresent;
@property (nonatomic)  BOOL clickedButton;
@property (nonatomic)  BOOL willDismissWithIndex;
@property (nonatomic)  BOOL didDismissWithIndex;
@property (nonatomic) NSInteger delegateButtonIndex;
@end

@implementation FUIAlertViewTests

- (void)setUp {
    [super setUp];
    self.alertView = [[FUIAlertView alloc] initWithTitle:@"Test Title" message:@"Test message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [self.alertView setAnimationDuration:0];
    [self.alertView setDelegate:self];
    [self setDelegateButtonIndex:1];
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

- (void)testWillPresentAlertView {
    [self.alertView show];
    expect(self.willPresent).to.beTruthy();
}

- (void)testDidPresentAlertView {
    [self.alertView show];
    [self waitForAnimations];
    expect(self.didPresent).to.beTruthy();
}

- (void)testAlertViewWillDissmissWithButtonIndex {
    [self.alertView show];
    [self.alertView clickButtonAtIndex:0];
    expect(self.willDismissWithIndex).to.beTruthy();
    expect(self.delegateButtonIndex).to.equal(0);
}

- (void)testAlertViewDidDissmissWithButtonIndex {
    [self.alertView show];
    [self.alertView clickButtonAtIndex:0];
    [self waitForAnimations];
    expect(self.didDismissWithIndex).to.beTruthy();
    expect(self.delegateButtonIndex).to.equal(0);
}

- (void)testAlertViewClickedButtonAtIndex{
    [self.alertView show];
    [self.alertView clickButtonAtIndex:0];
    expect(self.clickedButton).to.beTruthy();
    expect(self.delegateButtonIndex).to.equal(0);
}

// Delegate methods

- (void)willPresentAlertView:(FUIAlertView *)alertView {
    [self setWillPresent:YES];
}

- (void)didPresentAlertView:(FUIAlertView *)alertView {
    [self setDidPresent:YES];
}

- (void)alertView:(FUIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self setWillDismissWithIndex:YES];
    [self setDelegateButtonIndex:buttonIndex];
}

- (void)alertView:(FUIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self setDidDismissWithIndex:YES];
    [self setDelegateButtonIndex:buttonIndex];
}

- (void)alertView:(FUIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self setClickedButton:YES];
    [self setDelegateButtonIndex:buttonIndex];
}

@end
