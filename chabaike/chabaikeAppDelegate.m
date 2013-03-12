//
//  chabaikeAppDelegate.m
//  chabaike
//
//  Created by Mac on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "chabaikeAppDelegate.h"
#import "ViewController.h"
#import "SlideViewController.h"
@implementation chabaikeAppDelegate
@synthesize appEngine;
@synthesize snViewController;
@synthesize sinaweibo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"222");
    self.appEngine = [[MKNetworkEngine alloc]initWithHostName:API_HOSTNAME customHeaderFields:nil];
    [self.appEngine useCache];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"systemVersion%@",[defaults objectForKey:@"systemVersion"]);
    if([[defaults objectForKey:@"systemVersion"] isEqualToString:SYS_VERSION])
    {
        NSLog(@"不是第一次启动");
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]];
        self.window.rootViewController = navController;
        [navController setNavigationBarHidden:YES];
    }else{
        NSLog(@"是第一次启动");
        [defaults setObject:SYS_VERSION forKey:@"systemVersion"];
        [defaults synchronize];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[SlideViewController alloc] initWithNibName:@"SlideViewController" bundle:nil]];
        self.window.rootViewController = navController;
        [navController setNavigationBarHidden:YES];
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

