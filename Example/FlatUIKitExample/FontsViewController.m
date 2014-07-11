//
//  FontsViewController.m
//  FlatUIKitExample
//
//  Created by Kevin A. Hoogheem on 7/11/14.
//
//

#import "FontsViewController.h"
#import "UIFont+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"


@interface FontsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *flatFontLabel;
@property (strong, nonatomic) IBOutlet UILabel *boldFontLable;
@property (strong, nonatomic) IBOutlet UILabel *italicFontLable;
@property (strong, nonatomic) IBOutlet UILabel *lightFontLable;

@property (strong, nonatomic) IBOutlet UILabel *flatFontLabelTitle;
@property (strong, nonatomic) IBOutlet UILabel *boldFontLableTitle;
@property (strong, nonatomic) IBOutlet UILabel *italicFontLableTitle;
@property (strong, nonatomic) IBOutlet UILabel *lightFontLableTitle;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

@end

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

@implementation FontsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Fonts";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

	self.navigationController.navigationBar.topItem.title = @"UIFont+FlatUI";
	
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

	self.flatFontLabelTitle.font = [UIFont flatFontOfSize:20.0f];
	self.boldFontLableTitle.font = [UIFont boldFlatFontOfSize:20.0f];
	self.italicFontLableTitle.font = [UIFont italicFlatFontOfSize:20.0f];
	self.lightFontLableTitle.font = [UIFont lightFlatFontOfSize:20.0f];

	self.flatFontLabel.font = [UIFont flatFontOfSize:14.0f];
	self.boldFontLable.font = [UIFont boldFlatFontOfSize:14.0f];
	self.italicFontLable.font = [UIFont italicFlatFontOfSize:14.0f];
	self.lightFontLable.font = [UIFont lightFlatFontOfSize:14.0f];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
