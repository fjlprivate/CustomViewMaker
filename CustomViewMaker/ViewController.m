//
//  ViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ViewController.h"
#import <UINavigationBar+Awesome.h>
#import "NSString+Custom.h"
#import "UIColor+ColorWithHex.h"
#import <RESideMenu.h>



@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主界面";
    [self.view addSubview:self.hud];
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    [self.view addSubview:self.tableView];
    CGRect frame = self.view.frame;
    frame.origin.y += 64;
    frame.size.height -= 64;
    self.tableView.frame  = frame;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 菜单按钮
    UIBarButtonItem* leftBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(presentSideMenu:)];
    [self.navigationItem setLeftBarButtonItem:leftBarBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction) presentSideMenu:(id)sender {
    UIViewController* parentVC = [self parentViewController];
    if ([parentVC isKindOfClass:[RESideMenu class]]) {
        RESideMenu* sideMenu = (RESideMenu*)parentVC;
        [sideMenu presentLeftMenuViewController];
    }
    else if ([[parentVC parentViewController] isKindOfClass:[RESideMenu class]]) {
        RESideMenu* sideMenu = (RESideMenu*)[parentVC parentViewController];
        [sideMenu presentLeftMenuViewController];
    }
}



# pragma mask 1 UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.btnTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellidentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellidentifier"];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.contentView.layer.masksToBounds = YES;
        cell.contentView.layer.cornerRadius = 3.f;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor brownColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self.btnTitles objectAtIndex:indexPath.row];
    return cell;
}

# pragma mask 1 UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CGRect frame = cell.contentView.frame;
    frame.origin.y -= 1;
    frame.size.height -= 1;
    cell.contentView.frame = frame;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString* title  = [self.btnTitles objectAtIndex:indexPath.row];
    Class vcClass = NSClassFromString([self.dicVCNameAndTitles objectForKey:title]);
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
        [_btnTitles addObject:@"AwesomeIcon"];
        [_btnTitles addObject:@"幻灯效果label"];
        [_btnTitles addObject:@"测试webView"];
        [_btnTitles addObject:@"CoreAnimation动画"];
        [_btnTitles addObject:@"阻尼动画pageContr"];
        [_btnTitles addObject:@"金额输入界面"];
        [_btnTitles addObject:@"more滚动子切换"];
        [_btnTitles addObject:@"3个滚动子切换"];
        [_btnTitles addObject:@"LabelAutoresize"];
        [_btnTitles addObject:@"StepSegmentView"];
        [_btnTitles addObject:@"CustomAlertView"];
        [_btnTitles addObject: @"IconFont"];
        [_btnTitles addObject: @"SignIn"];
        [_btnTitles addObject: @"Wifi"];
        [_btnTitles addObject: @"登陆界面"];
        [_btnTitles addObject: @"Collection"];
        [_btnTitles addObject: @"MBHUD"];
        [_btnTitles addObject: @"JCAlert"];
        [_btnTitles addObject: @"RACCommand"];
        [_btnTitles addObject: @"下拉列表"];
        [_btnTitles addObject: @"环形标记"];
        [_btnTitles addObject: @"shapeLayer"];
        [_btnTitles addObject: @"标记勾叉"]; // -- 1
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
        [_dicVCNameAndTitles setObject:@"TestForCustomAlertView" forKey: @"CustomAlertView"];
        [_dicVCNameAndTitles setObject:@"TestForStepSegmentView" forKey: @"StepSegmentView"];
        [_dicVCNameAndTitles setObject:@"LabelAutoresize" forKey:@"LabelAutoresize"];
        [_dicVCNameAndTitles setObject:@"TestForTriScrollSegVC" forKey:@"3个滚动子切换"];
        [_dicVCNameAndTitles setObject:@"TestForMoreSegScrollView" forKey:@"more滚动子切换"];
        [_dicVCNameAndTitles setObject:@"MainTransViewController" forKey:@"金额输入界面"];
        [_dicVCNameAndTitles setObject:@"TestForKYAnimationPageViewController" forKey:@"阻尼动画pageContr"];
        [_dicVCNameAndTitles setObject:@"TestForCAViewController" forKey:@"CoreAnimation动画"];
        [_dicVCNameAndTitles setObject:@"TestForWebViewController" forKey:@"测试webView"];
        [_dicVCNameAndTitles setObject:@"TestForGradientLabel" forKey:@"幻灯效果label"];
        [_dicVCNameAndTitles setObject:@"TestForIconfontVC" forKey:@"AwesomeIcon"];
    }
    return _dicVCNameAndTitles;
}





- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    }
    return _tableView;
}

@end
