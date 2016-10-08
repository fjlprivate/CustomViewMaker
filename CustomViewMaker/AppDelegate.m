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
    [navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x27384b]];
   // [navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0xef454b]];

    [navigationBar setBarStyle:UIBarStyleBlack];
    [navigationBar setShadowImage:[UIImage new]];
    
    ViewController* mainVC = [[ViewController alloc] init];
    mainVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    UIViewController* leftVC = [[UIViewController alloc] init];
    //leftVC.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sideMenuPic"]];
    leftVC.view.backgroundColor = [UIColor colorWithHex:0x27384b];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UILabel* leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, screenWidth - (screenWidth * 0.5 * (1 - 0.7)) - 30, 40)];
    leftLabel.text = @"leftView";
    leftLabel.font = [UIFont boldSystemFontOfSize:20];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [leftVC.view addSubview:leftLabel];
    leftLabel.backgroundColor = [UIColor orangeColor];
    leftLabel.layer.masksToBounds = YES;
    leftLabel.layer.cornerRadius = 20;
    
    UIButton* testBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 40)];
    [testBtn setTitle:@"testBtn" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
    testBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    testBtn.backgroundColor = [UIColor colorWithHex:0xef454b];
    [leftVC.view addSubview:testBtn];
    
    
    RESideMenu* sideMenuVC = [[RESideMenu alloc] initWithContentViewController:navi leftMenuViewController:leftVC rightMenuViewController:nil];
    sideMenuVC.scaleMenuView = NO;
    sideMenuVC.contentViewShadowEnabled = YES;
    sideMenuVC.parallaxEnabled = NO;
    
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
