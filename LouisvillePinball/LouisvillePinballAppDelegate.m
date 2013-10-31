//
//  LouisvillePinballAppDelegate.m
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 4/28/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import "LouisvillePinballAppDelegate.h"
#import "MachineTableViewController.h"
#import "LouisvilleMapViewController.h"
#import "MachineViewController.h"

@implementation LouisvillePinballAppDelegate


@synthesize window=_window;

@synthesize tabBarController=_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    LouisvilleMapViewController *mapViewController = [[LouisvilleMapViewController alloc] init];
    UINavigationController *navMapViewController = [[[UINavigationController alloc] initWithRootViewController:mapViewController] autorelease];
    [mapViewController view];
    navMapViewController.tabBarItem.image = [UIImage imageNamed:@"73-radar.png"];
    navMapViewController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    navMapViewController.title = @"Louisville Pinball";
    [mapViewController release];
    
    MachineTableViewController *machineTableViewController = [[MachineTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navMachineCommentController = [[[UINavigationController alloc] initWithRootViewController:machineTableViewController] autorelease];
    [machineTableViewController view];
    navMachineCommentController.tabBarItem.image = [UIImage imageNamed:@"08-chat.png"];
    navMachineCommentController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    navMachineCommentController.title = @"Comments";
    [machineTableViewController release];
    
    MachineViewController *machineViewController = [[MachineViewController alloc] init];
    UINavigationController *navMachineViewController = [[[UINavigationController alloc] initWithRootViewController:machineViewController] autorelease];
    navMachineViewController.tabBarItem.image = [UIImage imageNamed:@"72-pin.png"];
    navMachineViewController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    navMachineViewController.title = @"Add Machine";
    [machineViewController release];
    
    //Add Navigation Controllers to Tab Bar Controller
    [self.tabBarController setViewControllers:[NSArray arrayWithObjects: navMapViewController, navMachineCommentController, navMachineViewController, nil]];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
