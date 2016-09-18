//
//  AppDelegate.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "AppDelegate.h"
#import <UINavigationBar+Awesome.h>
#import "UIColor+ColorWithHex.h"
#import <RESideMenu.h>
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UINavigationBar* navigationBar = [UINavigationBar appearance];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[[UIColor whiteColor], [UIFont boldSystemFontOfSize:15]]
                                                                                     forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]]];
    [navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0xef454b]];
    [navigationBar setBarStyle:UIBarStyleBlack];
    [navigationBar setShadowImage:[UIImage new]];
    
    
    ViewController* mainVC = [[ViewController alloc] init];
    mainVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    UIViewController* leftVC = [[UIViewController alloc] init];
    leftVC.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sideMenuPic"]];
    
    RESideMenu* sideMenuVC = [[RESideMenu alloc] initWithContentViewController:navi leftMenuViewController:leftVC rightMenuViewController:nil];
    sideMenuVC.scaleMenuView = NO;
    
    self.window.rootViewController = sideMenuVC;
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
