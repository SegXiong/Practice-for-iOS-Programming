//
//  AppDelegate.m
//  Homepwner
//
//  Created by More Xiong on 2016/11/5.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (!self.window.rootViewController) {
        BNRItemsViewController *itemsViewController = [[BNRItemsViewController alloc] init];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
        
        navController.restorationIdentifier = NSStringFromClass([navController class]);
        
        self.window.rootViewController = navController;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    BOOL success = [[BNRItemStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the BNRItems");
    } else {
        NSLog(@"Could not save any of the BNRItems");
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    UIViewController *vc = [[UINavigationController alloc] init];
    vc.restorationIdentifier = [identifierComponents lastObject];
    if ([identifierComponents count] == 1) {
        self.window.rootViewController = vc;
    }
    return vc;
}

@end
