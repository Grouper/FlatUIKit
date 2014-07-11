//
//  ControlsViewController.m
//  FlatUIKitExample
//
//  Created by Kevin A. Hoogheem on 7/11/14.
//
//

#import "ControlsViewController.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "UIStepper+FlatUI.h"
#import "FUISwitch.h"
#import "UIFont+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "FUISegmentedControl.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface ControlsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet FUISwitch *flatSwitch;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UIProgressView *flatProgress;
@property (weak, nonatomic) IBOutlet FUISegmentedControl *flatSegmentedControl;
@property (weak, nonatomic) IBOutlet FUISegmentedControl *flatSegmentedControlBoxed;

@end

@implementation ControlsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @"Controls";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view from its nib.
	if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
	
	self.navigationController.navigationBar.topItem.title = @"Controls";
	
	self.view.backgroundColor = [UIColor cloudsColor];
	
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldFlatFontOfSize:18],
																		NSForegroundColorAttributeName: [UIColor whiteColor]};
    } else {
        // Pre-iOS7 methods
        self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
																		UITextAttributeTextColor: [UIColor whiteColor]};
    }
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
	
	[self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        label.font = [UIFont flatFontOfSize:16];
        label.textColor = [UIColor midnightBlueColor];
    }];

	
	[self.slider configureFlatSliderWithTrackColor:[UIColor silverColor]
                                     progressColor:[UIColor alizarinColor]
                                        thumbColor:[UIColor pomegranateColor]];
    
    [self.stepper configureFlatStepperWithColor:[UIColor wisteriaColor]
                               highlightedColor:[UIColor wisteriaColor]
                                  disabledColor:[UIColor amethystColor]
                                      iconColor:[UIColor cloudsColor]];
    
	[self.stepper setMaximumValue:1.0f];
	[self.stepper setStepValue:0.2f];
	[self.stepper setValue:0.2f];


	[self.flatProgress configureFlatProgressViewWithTrackColor:[UIColor silverColor] progressColor:[UIColor wisteriaColor]];
	[self.flatProgress setProgress:0.2f];
	
	
	self.flatSwitch.onColor = [UIColor turquoiseColor];
    self.flatSwitch.offColor = [UIColor cloudsColor];
    self.flatSwitch.onBackgroundColor = [UIColor midnightBlueColor];
    self.flatSwitch.offBackgroundColor = [UIColor silverColor];
    self.flatSwitch.offLabel.font = [UIFont boldFlatFontOfSize:14];
    self.flatSwitch.onLabel.font = [UIFont boldFlatFontOfSize:14];

	self.flatSegmentedControl.selectedFont = [UIFont boldFlatFontOfSize:16];
    self.flatSegmentedControl.selectedFontColor = [UIColor cloudsColor];
    self.flatSegmentedControl.deselectedFont = [UIFont flatFontOfSize:16];
    self.flatSegmentedControl.deselectedFontColor = [UIColor cloudsColor];
    self.flatSegmentedControl.selectedColor = [UIColor pumpkinColor];
    self.flatSegmentedControl.deselectedColor = [UIColor tangerineColor];
    self.flatSegmentedControl.disabledColor = [UIColor silverColor];
    self.flatSegmentedControl.dividerColor = [UIColor silverColor];
    self.flatSegmentedControl.cornerRadius = 5.0;

	self.flatSegmentedControlBoxed.selectedFont = [UIFont boldFlatFontOfSize:16];
    self.flatSegmentedControlBoxed.selectedFontColor = [UIColor turquoiseColor];
    self.flatSegmentedControlBoxed.selectedColor = [UIColor midnightBlueColor];
    self.flatSegmentedControlBoxed.deselectedColor = [UIColor turquoiseColor];
	self.flatSegmentedControlBoxed.deselectedFont = [UIFont flatFontOfSize:16];
    self.flatSegmentedControlBoxed.deselectedFontColor = [UIColor midnightBlueColor];
    self.flatSegmentedControlBoxed.disabledColor = [UIColor silverColor];
    self.flatSegmentedControlBoxed.dividerColor = [UIColor silverColor];
    self.flatSegmentedControlBoxed.cornerRadius = 0.0;

}

- (IBAction)setpperAction:(id)sender {
	
	UIStepper *stepper = (UIStepper *) sender;
		
	[self.flatProgress setProgress:stepper.value animated:TRUE];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
