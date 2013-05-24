//
//  ViewController.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "ViewController.h"
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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *alertViewButton;
@property (weak, nonatomic) IBOutlet FUIButton *pushViewControllerButton;
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
    self.title = @"Flat UI";
    self.view.backgroundColor = [UIColor cloudsColor];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Button"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil];
    [self.navigationItem.rightBarButtonItem removeTitleShadow];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Button"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil];
    [self.navigationItem.rightBarButtonItem removeTitleShadow];
    
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
    
    self.pushViewControllerButton.buttonColor = [UIColor peterRiverColor];
    self.pushViewControllerButton.shadowColor = [UIColor belizeHoleColor];
    self.pushViewControllerButton.shadowHeight = 3.0f;
    self.pushViewControllerButton.cornerRadius = 6.0f;
    self.pushViewControllerButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.pushViewControllerButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.pushViewControllerButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    [self.slider configureFlatSliderWithTrackColor:[UIColor silverColor]
                                     progressColor:[UIColor alizarinColor]
                                        thumbColor:[UIColor pomegranateColor]];
    
    [self.stepper configureFlatStepperWithColor:[UIColor wisteriaColor]
                               highlightedColor:[UIColor wisteriaColor]
                                  disabledColor:[UIColor amethystColor]
                                      iconColor:[UIColor cloudsColor]];
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18]};
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
}

- (IBAction)showAlertView:(id)sender {
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Hello" message:@"This is an alert view" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Do Something", nil];
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

- (IBAction)pushViewController:(id)sender {
    UIViewController *viewController = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
