//
//  ViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主界面";
    [self.view addSubview:self.hud];
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];

    __weak typeof(self)wself = self;
    CGRect frame = self.view.frame;
    CGFloat width = frame.size.width/3.f;
    CGFloat height = 50;
    
    for (int i = 0; i < self.btnTitles.count; i++) {
        NSString* btnTitle = [self.btnTitles objectAtIndex:i];
        UIButton* button = [self buttonWithTitle:btnTitle];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wself.view.mas_left).offset(i%3 * width);
            make.top.equalTo(wself.view.mas_top).offset(64 + i/3 * height);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        
    }
    
}


#pragma mask 2 添加子按钮
- (UIButton*) buttonWithTitle:(NSString*)title {
    UIButton* button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(pushToVCName:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (IBAction) pushToVCName:(UIButton*)button {
    NSString* vcName = [self.dicVCNameAndTitles objectForKey:[button titleForState:UIControlStateNormal]];
    Class vcClass = NSClassFromString(vcName);
    UIViewController* viewC = (UIViewController*)[[vcClass alloc] init];
    [self.navigationController pushViewController:viewC animated:YES];
}

#pragma mask 4 getter 
- (MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hud;
}

- (NSMutableArray *)btnTitles {
    if (!_btnTitles) {
        _btnTitles = [NSMutableArray array];
        [_btnTitles addObject: @"标记勾叉"];
        [_btnTitles addObject: @"shapeLayer"];
        [_btnTitles addObject: @"环形标记"];
        [_btnTitles addObject: @"下拉列表"];
        [_btnTitles addObject: @"RACCommand"];
        [_btnTitles addObject: @"JCAlert"];
        [_btnTitles addObject: @"MBHUD"];
        [_btnTitles addObject: @"Collection"];
        [_btnTitles addObject: @"登陆界面"];
        [_btnTitles addObject: @"Wifi"];
        [_btnTitles addObject: @"SignIn"];
        [_btnTitles addObject: @"IconFont"];
    }
    return _btnTitles;
}

- (NSMutableDictionary *)dicVCNameAndTitles {
    if (!_dicVCNameAndTitles) {
        _dicVCNameAndTitles = [NSMutableDictionary dictionary];
        [_dicVCNameAndTitles setObject:@"CheckViewController" forKey: @"标记勾叉"];
        [_dicVCNameAndTitles setObject:@"TestCAShapeLayerViewController" forKey: @"shapeLayer"];
        [_dicVCNameAndTitles setObject:@"TestCheckViewController" forKey: @"环形标记"];
        [_dicVCNameAndTitles setObject:@"TextPullListViewController" forKey: @"下拉列表"];
        [_dicVCNameAndTitles setObject:@"TestRACCommand" forKey: @"RACCommand"];
        [_dicVCNameAndTitles setObject:@"TestJLAlertView" forKey: @"JCAlert"];
        [_dicVCNameAndTitles setObject:@"TestMBProgressHUD" forKey: @"MBHUD"];
        [_dicVCNameAndTitles setObject:@"TestCollectionView" forKey: @"Collection"];
        [_dicVCNameAndTitles setObject:@"SignInViewController" forKey: @"登陆界面"];
        [_dicVCNameAndTitles setObject:@"TestWifiViewController" forKey: @"Wifi"];
        [_dicVCNameAndTitles setObject:@"JLSignInViewController" forKey: @"SignIn"];
        [_dicVCNameAndTitles setObject:@"TestForIconFont" forKey: @"IconFont"];
    }
    return _dicVCNameAndTitles;
}

@end
