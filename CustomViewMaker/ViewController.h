//
//  ViewController.h
//  CustomViewMaker
//
//  Created by jielian on 16/3/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import <MBProgressHUD.h>
#import "CheckViewController.h"
#import "TestCAShapeLayerViewController.h"
#import "TestCheckViewController.h"
#import "TestRACCommand.h"
#import "TextPullListViewController.h"
#import "TestJLAlertView.h"
#import "TestMBProgressHUD.h"
#import "TestCollectionView/TestCollectionView.h"
#import "SignInViewController.h"
#import "TestWifiViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD* hud;


@property (nonatomic, strong) NSMutableArray* btnTitles;
@property (nonatomic, strong) NSMutableDictionary* dicVCNameAndTitles;


@end

