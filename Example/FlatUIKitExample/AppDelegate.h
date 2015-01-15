//
//  AppDelegate.h
//  FlatUIKitExample
//
//  Created by Alejandro Benito Santos on 5/16/13.
//
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UITabBarController *tabbarController;

@end
