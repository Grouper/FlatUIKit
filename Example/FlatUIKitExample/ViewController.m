//
//  ViewController.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "UIColor+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "UIStepper+FlatUI.h"
#import "UITabBar+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "FUIButton.h"
#import "FUISwitch.h"
#import "UIFont+FlatUI.h"
#import "FUIAlertView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIPopoverController+FlatUI.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface ViewController () {
    UIPopoverController *_popoverController;
}
@property (weak, nonatomic) IBOutlet FUIButton *alertViewButton;
@property (weak, nonatomic) IBOutlet FUIButton *popoverButton;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet FUISwitch *flatSwitch;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UIProgressView *flatProgress;
@property (weak, nonatomic) IBOutlet FUISegmentedControl *flatSegmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"Flat UI";
    self.view.backgroundColor = [UIColor cloudsColor];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Plain Table"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showPlainTableView:)];
    [self.navigationItem.rightBarButtonItem removeTitleShadow];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Grouped Table"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                            action:@selector(showTableView:)];
    [self.navigationItem.leftBarButtonItem removeTitleShadow];
    
    [self.navigationItem.leftBarButtonItem configureFlatButtonWithColor:[UIColor alizarinColor]
                                                       highlightedColor:[UIColor pomegranateColor]
                                                           cornerRadius:3];
    
    self.alertViewButton.buttonColor = [UIColor turquoiseColor];
    self.alertViewButton.shadowColor = [UIColor greenSeaColor];
    self.alertViewButton.shadowHeight = 3.0f;
    self.alertViewButton.cornerRadius = 6.0f;
    self.alertViewButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.alertViewButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.alertViewButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    [self.slider configureFlatSliderWithTrackColor:[UIColor silverColor]
                                     progressColor:[UIColor alizarinColor]
                                        thumbColor:[UIColor pomegranateColor]];
    
    [self.stepper configureFlatStepperWithColor:[UIColor wisteriaColor]
                               highlightedColor:[UIColor wisteriaColor]
                                  disabledColor:[UIColor amethystColor]
                                      iconColor:[UIColor cloudsColor]];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldFlatFontOfSize:18],
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor]};
    } else {
        // Pre-iOS7 methods
        self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    }
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    
    self.flatSwitch.onColor = [UIColor turquoiseColor];
    self.flatSwitch.offColor = [UIColor cloudsColor];
    self.flatSwitch.onBackgroundColor = [UIColor midnightBlueColor];
    self.flatSwitch.offBackgroundColor = [UIColor silverColor];
    self.flatSwitch.offLabel.font = [UIFont boldFlatFontOfSize:14];
    self.flatSwitch.onLabel.font = [UIFont boldFlatFontOfSize:14];
    
    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        label.font = [UIFont flatFontOfSize:16];
        label.textColor = [UIColor midnightBlueColor];
    }];
    
    [self.flatProgress configureFlatProgressViewWithTrackColor:[UIColor silverColor] progressColor:[UIColor wisteriaColor]];
    
    self.flatSegmentedControl.selectedFont = [UIFont boldFlatFontOfSize:16];
    self.flatSegmentedControl.selectedFontColor = [UIColor cloudsColor];
    self.flatSegmentedControl.deselectedFont = [UIFont flatFontOfSize:16];
    self.flatSegmentedControl.deselectedFontColor = [UIColor cloudsColor];
    self.flatSegmentedControl.selectedColor = [UIColor amethystColor];
    self.flatSegmentedControl.deselectedColor = [UIColor silverColor];
    self.flatSegmentedControl.dividerColor = [UIColor midnightBlueColor];
    self.flatSegmentedControl.cornerRadius = 5.0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.popoverButton.buttonColor = [UIColor carrotColor];
        self.popoverButton.shadowColor = [UIColor alizarinColor];
        self.popoverButton.shadowHeight = 3.0f;
        self.popoverButton.cornerRadius = 6.0f;
        self.popoverButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.popoverButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.popoverButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    }
}

- (IBAction)showAlertView:(id)sender {
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Hello" message:@"This is an alert view" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Do Something", nil];
    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];
}

- (IBAction)showPopover:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"FUIPopoverController";
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        vc.preferredContentSize = CGSizeMake(320, 480);
        self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldFlatFontOfSize:18],
                                                                        NSForegroundColorAttributeName: [UIColor whiteColor]};
    } else {
        // Pre-iOS7 methods
        vc.contentSizeForViewInPopover = CGSizeMake(320, 480);
        vc.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                  UITextAttributeTextColor: [UIColor whiteColor]};
    }
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    _popoverController = [[UIPopoverController alloc] initWithContentViewController:nc];
    [_popoverController configureFlatPopoverWithBackgroundColor:[UIColor turquoiseColor] cornerRadius:9.0];
    _popoverController.delegate = self;
    
    [_popoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)showTableView:(id)sender {
    TableViewController* tableViewController = [[TableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:tableViewController animated:YES];
}

- (void)showPlainTableView:(id)sender {
    TableViewController* tableViewController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:tableViewController animated:YES];
}


#pragma mark - UIPopoverControllerDelegate Methods

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    _popoverController = nil;
}

@end
