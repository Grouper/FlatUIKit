//
//  Buttons_Alerts.m
//  FlatUIKitExample
//
//  Created by Kevin A. Hoogheem on 7/11/14.
//
//

#import "Buttons_Alerts.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "FUIButton.h"
#import "UIPopoverController+FlatUI.h"
#import "FUIAlertView.h"


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

@interface Buttons_Alerts () {
	UIPopoverController *_popoverController;
}

@property (weak, nonatomic) IBOutlet FUIButton *alertViewButton;
@property (weak, nonatomic) IBOutlet FUIButton *actionSheetButton;
@property (weak, nonatomic) IBOutlet FUIButton *popoverButton;

@end

@implementation Buttons_Alerts

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self  != nil) {
		self.title = @"Buttons";		

	}
		
    return (self);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
	
	self.navigationController.navigationBar.topItem.title = @"Buttons + Alerts";

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

	self.alertViewButton.buttonColor = [UIColor turquoiseColor];
    self.alertViewButton.shadowColor = [UIColor greenSeaColor];
    self.alertViewButton.shadowHeight = 3.0f;
    self.alertViewButton.cornerRadius = 6.0f;
    self.alertViewButton.titleLabel.font = [UIFont boldFlatFontOfSize:12];
    [self.alertViewButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.alertViewButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
	
	self.actionSheetButton.buttonColor = [UIColor silverColor];
    self.actionSheetButton.shadowColor = [UIColor concreteColor];
    self.actionSheetButton.shadowHeight = 2.0f;
    self.actionSheetButton.cornerRadius = 6.0f;
    self.actionSheetButton.titleLabel.font = [UIFont boldFlatFontOfSize:12];
    [self.actionSheetButton setTitleColor:[UIColor wetAsphaltColor] forState:UIControlStateNormal];
    [self.actionSheetButton setTitleColor:[UIColor wetAsphaltColor] forState:UIControlStateHighlighted];

	self.popoverButton.buttonColor = [UIColor carrotColor];
	self.popoverButton.shadowColor = [UIColor alizarinColor];
	self.popoverButton.shadowHeight = 3.0f;
	self.popoverButton.cornerRadius = 6.0f;
	self.popoverButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
	[self.popoverButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
	[self.popoverButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showAlertView:(id)sender {
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Hello" message:@"This is an alert view" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Do Something", nil];
    alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
    [@[[alertView textFieldAtIndex:0], [alertView textFieldAtIndex:1]] enumerateObjectsUsingBlock:^(FUITextField *textField, NSUInteger idx, BOOL *stop) {
        [textField setTextFieldColor:[UIColor cloudsColor]];
        [textField setBorderColor:[UIColor asbestosColor]];
        [textField setCornerRadius:4];
        [textField setFont:[UIFont flatFontOfSize:14]];
        [textField setTextColor:[UIColor midnightBlueColor]];
    }];
    [[alertView textFieldAtIndex:0] setPlaceholder:@"Text here!"];
    
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

- (IBAction)showActionSheet:(id)sender {
	/*
	 UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"Hello" delegate:nil cancelButtonTitle:@"cancel" destructiveButtonTitle:@"test" otherButtonTitles:@"button one", nil];
	 [actionsheet showInView:self.view];
	 actionsheet.delegate = self;
	 
	 */
	
	FUIActionSheet *actionsheet = [[FUIActionSheet alloc] initWithTitle:@"Action Sheet" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete all pictures" otherButtonTitles:@"Take Picture", @"Send Picture", nil];
	
	actionsheet.delegate = self;
	actionsheet.titleLabel.textColor = [UIColor cloudsColor];
	actionsheet.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    actionsheet.actionContainer.backgroundColor = [UIColor midnightBlueColor];
    actionsheet.defaultButtonColor = [UIColor cloudsColor];
	actionsheet.defaultButtonTitleColor = [UIColor asbestosColor];
    actionsheet.defaultButtonShadowColor = [UIColor asbestosColor];
	
	actionsheet.onDestructiveAction = ^{
		NSLog(@"ActionSheet onDestructiveAction");
	};
	
	actionsheet.onCancelAction = ^{
		NSLog(@"ActionSheet onCancelAction");
	};
	
	actionsheet.onOkAction = ^(NSInteger buttonidx){
		NSLog(@"ActionSheet onOkAction: %d", buttonidx);
	};
	
	actionsheet.onDismissAction = ^(NSInteger buttonidx) {
		
		NSLog(@"ActionSheet onDismissAction: %d", buttonidx);
	};
	
	[actionsheet show];
	
}

- (IBAction)showPopover:(id)sender {
	
	if (IPHONE) {
		FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Problem" message:@"Popovers dont work on iPhone." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
		alertView.alertViewStyle = FUIAlertViewStyleDefault;
		
		alertView.delegate = self;
		alertView.titleLabel.textColor = [UIColor pomegranateColor];
		alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
		alertView.messageLabel.textColor = [UIColor pomegranateColor];
		alertView.messageLabel.font = [UIFont flatFontOfSize:14];
		alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
		alertView.alertContainer.backgroundColor = [UIColor peterRiverColor];
		alertView.defaultButtonColor = [UIColor cloudsColor];
		alertView.defaultButtonShadowColor = [UIColor belizeHoleColor];
		alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
		alertView.defaultButtonTitleColor = [UIColor asbestosColor];
		[alertView show];
		return;
	}
	
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


#pragma mark - UIPopoverControllerDelegate Methods

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    _popoverController = nil;
}


#pragma mark - FUIActionSheetDelegate Methods
- (void)actionSheet:(FUIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"ActionSheet clickedButtonAtIndex: %d", buttonIndex);
}

- (void)actionSheetCancel:(FUIActionSheet *)actionSheet {
	NSLog(@"actionSheetCancel");
}

- (void)willPresentActionSheet:(FUIActionSheet *)actionSheet {
	NSLog(@"Actionsheet Will Present");
}

- (void)didPresentActionSheet:(FUIActionSheet *)actionSheet	{
	NSLog(@"ActionSheet Did Present");
}

- (void)actionSheet:(FUIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSLog(@"ActionSheet willDismissWithButtonIndex: %d", buttonIndex);
}

- (void)actionSheet:(FUIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSLog(@"ActionSheet didDismissWithButtonIndex: %d", buttonIndex);
}


@end
