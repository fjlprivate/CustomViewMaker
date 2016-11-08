//
//  TestWifiViewController.h
//  CustomViewMaker
//
//  Created by jielian on 16/4/28.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WifiView.h"
#import "Masonry.h"
#import "UIColor+ColorWithHex.h"
#import "MLWifiView.h"
#import "MBProgressHUD+CustomSate.h"


@interface TestWifiViewController : UIViewController

@property (nonatomic, strong) UIView* blueToothBackView;

@property (nonatomic, strong) WifiView* wifiView;

@property (nonatomic, strong) UIButton* startButton;
@property (nonatomic, strong) UIButton* stopButton;

@property (nonatomic, strong) MLWifiView* mlwifiView;


@property (nonatomic, strong) UILabel* stateLabel;

@property (nonatomic, strong) MBProgressHUD* hud;

@property (nonatomic, strong) UIBarButtonItem* stopBarBtn;

@end
