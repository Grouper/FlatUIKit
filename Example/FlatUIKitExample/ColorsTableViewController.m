//
//  ColorsTableViewController.m
//  FlatUIKitExample
//
//  Created by Kevin A. Hoogheem on 7/11/14.
//
//

#import "ColorsTableViewController.h"
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UINavigationBar+FlatUI.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";

@interface ColorsTableViewController () {
	NSArray *names;
	NSArray *colors;
}

@end

@implementation ColorsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		self.title = @"Colors";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationController.navigationBar.topItem.title = @"UIColor+FlatUI";

    //Set the background color
    self.tableView.backgroundColor = [UIColor cloudsColor];
    self.tableView.backgroundView = nil;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FUITableViewControllerCellReuseIdentifier];
    
	if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
		[self.tableView setSeparatorInset:UIEdgeInsetsZero];
	}
	
	//if you dont' want seperators...
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	

	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldFlatFontOfSize:18],
																		NSForegroundColorAttributeName: [UIColor whiteColor]};
    } else {
        // Pre-iOS7 methods
        self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
																		UITextAttributeTextColor: [UIColor whiteColor]};
    }
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];

	names = [[NSArray alloc] init];
	names = @[@"turquoiseColor", @"greenSeaColor", @"emerlandColor", @"nephritisColor" , @"peterRiverColor", @"belizeHoleColor", @"amethystColor", @"wisteriaColor", @"wetAsphaltColor", @"midnightBlueColor", @"sunflowerColor", @"tangerineColor", @"carrotColor", @"pumpkinColor", @"alizarinColor", @"pomegranateColor", @"cloudsColor", @"silverColor", @"concreteColor", @"asbestosColor"];
	
	colors = [[NSArray alloc] init];
	colors = @[[UIColor turquoiseColor], [UIColor greenSeaColor], [UIColor emerlandColor], [UIColor nephritisColor], [UIColor peterRiverColor], [UIColor belizeHoleColor], [UIColor amethystColor], [UIColor wisteriaColor], [UIColor wetAsphaltColor], [UIColor midnightBlueColor], [UIColor sunflowerColor], [UIColor tangerineColor], [UIColor carrotColor], [UIColor pumpkinColor], [UIColor alizarinColor], [UIColor pomegranateColor], [UIColor cloudsColor], [UIColor silverColor], [UIColor concreteColor], [UIColor asbestosColor]];
			 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:FUITableViewControllerCellReuseIdentifier];
    
    // Configure the cell...
	UIColor *cellcolor = [colors objectAtIndex:indexPath.row];
	UIColor *textcolor = [UIColor cloudsColor];
	
	if (cellcolor == textcolor) {
		textcolor = [UIColor silverColor];
	}
	
    [cell configureFlatCellWithColor:cellcolor selectedColor:textcolor];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [names objectAtIndex:indexPath.row]];

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
