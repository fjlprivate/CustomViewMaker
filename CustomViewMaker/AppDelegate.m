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
#import "LeftMenuViewController.h"


@interface AppDelegate ()

@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /* 捕获异常错误日志 */
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    
    
    
    /* 设置全局的导航栏背景 */
    UINavigationBar* navigationBar = [UINavigationBar appearance];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[[UIColor whiteColor], [UIFont boldSystemFontOfSize:15]]
                                                                                     forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]]];
    [navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x27384b]];

    [navigationBar setBarStyle:UIBarStyleBlack];
    [navigationBar setShadowImage:[UIImage new]];
    
    
    /* 组装菜单样式app架构 */
    ViewController* mainVC = [[ViewController alloc] init];
    mainVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    LeftMenuViewController* leftVC = [[LeftMenuViewController alloc] init];
    
    RESideMenu* sideMenuVC = [[RESideMenu alloc] initWithContentViewController:navi leftMenuViewController:leftVC rightMenuViewController:nil];
    sideMenuVC.scaleMenuView = NO;
    sideMenuVC.contentViewShadowEnabled = YES;
    sideMenuVC.parallaxEnabled = NO;
    
    self.window.rootViewController = sideMenuVC;
    
    
    
    return YES;
}

# pragma mask ::: 捕获详细的内存崩溃日志
void uncaughtExceptionHandler(NSException* exception){
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@",[exception callStackSymbols]);
}




@end
