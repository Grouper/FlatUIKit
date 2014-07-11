//
//  AppDelegate.m
//  FlatUIKitExample
//
//  Created by Alejandro Benito Santos on 5/16/13.
//
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UITabBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "Buttons_Alerts.h"
#import "ColorsTableViewController.h"
#import "FontsViewController.h"
#import "ControlsViewController.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define USE_Tab 1

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    
	if (USE_Tab) {
		UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:[[ColorsTableViewController alloc] initWithStyle:UITableViewStylePlain]];

		UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:[[Buttons_Alerts alloc] initWithNibName:@"Buttons_Alerts" bundle:nil]];
		
		UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:[[FontsViewController alloc] initWithNibName:@"FontsViewController" bundle:nil]];
		
		UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:[[ControlsViewController alloc] initWithNibName:@"ControlsViewController" bundle:nil]];
		

		
		self.tabbarController = [[UITabBarController alloc] init];
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
			self.tabbarController.tabBar.selectedImageTintColor = [UIColor turquoiseColor];
			self.tabbarController.tabBar.barTintColor = [UIColor midnightBlueColor];
		}else{
			[self.tabbarController.tabBar configureFlatTabBarWithColor:[UIColor midnightBlueColor] selectedColor:[UIColor turquoiseColor]];
		}
		

		[self.tabbarController setViewControllers:@[nv1, nv2, nv3, nv4]];
		self.window.rootViewController = self.tabbarController;

	}else{
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
		self.window.rootViewController = navController;

	}
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
