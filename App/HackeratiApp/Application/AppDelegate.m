//
//  AppDelegate.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/23/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "AppDelegate.h"
#import "HARootViewController.h"
#import "HACoreDataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    HARootViewController *rootVC = [[HARootViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[HACoreDataManager sharedManager] saveContext];
}

@end
