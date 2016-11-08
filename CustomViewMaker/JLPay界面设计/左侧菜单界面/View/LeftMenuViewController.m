//
//  LeftMenuViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/10/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "UIColor+ColorWithHex.h"


@interface LeftMenuViewController () <UITableViewDelegate>

@property (nonatomic, strong) CAGradientLayer* gradientColorLayer;


@end

@implementation LeftMenuViewController


# pragma mask 2 UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



# pragma mask 3 布局

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadSubviews];
    [self initialFrame];
}

- (void) loadSubviews {
    [self.view.layer addSublayer:self.gradientColorLayer];
    [self.view addSubview:self.userHeadView];
    [self.view addSubview:self.menuTableView];
    [self.view addSubview:self.logoutBtn];
}

- (void) initialFrame {
    
    CGFloat leftInset = self.view.frame.size.width * 15/320.f;
    
    CGFloat avilableWidth = self.view.frame.size.width * (1 - 0.7 * 0.5) + 30 * 0.8 - leftInset;
    
    CGFloat heightUserHeadView = self.view.frame.size.height * 0.35 * 0.3;
    
    CGFloat heightTBV = self.view.frame.size.height * (1 - (1 - 0.7) * 1.5 );
    
    CGFloat heightLogouBtn = self.view.frame.size.height * 30 / 568.f;
    
    CGFloat widthLogoutBtn = self.view.frame.size.width * 100 / 320.f;
    
    CGRect frame = CGRectMake(leftInset,
                              self.view.frame.size.height * 0.15 - heightUserHeadView * 0.5,
                              avilableWidth,
                              heightUserHeadView);
    self.userHeadView.frame = frame;
    
    frame.origin.y = self.view.frame.size.height * 0.3;
    frame.size.height = heightTBV;
    self.menuTableView.frame = frame;
    
    frame.origin.y = self.view.frame.size.height - leftInset - heightLogouBtn;
    frame.size.width = widthLogoutBtn;
    frame.size.height = heightLogouBtn;
    self.logoutBtn.frame = frame;
    
}


# pragma mask 4 getter

- (CAGradientLayer *)gradientColorLayer {
    if (!_gradientColorLayer) {
        _gradientColorLayer = [CAGradientLayer layer];
        _gradientColorLayer.colors = @[(__bridge id)[UIColor colorWithHex:0x99cccc].CGColor,
                                       (__bridge id)[UIColor colorWithHex:0x27384b].CGColor];
        _gradientColorLayer.locations = @[@0, @0.35];
        _gradientColorLayer.startPoint = CGPointMake(0.5, 0);
        _gradientColorLayer.endPoint = CGPointMake(0.5, 1);
        _gradientColorLayer.frame = self.view.bounds;
    }
    return _gradientColorLayer;
}

- (LMVC_userHeadView *)userHeadView {
    if (!_userHeadView) {
        _userHeadView = [[LMVC_userHeadView alloc] init];
        _userHeadView.busiNameLabel.text = @"捷联测试";
        _userHeadView.busiNumLabel.text = @"886584000000001";
    }
    return _userHeadView;
}

- (LMVC_logoutButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [[LMVC_logoutButton alloc] init];
    }
    return _logoutBtn;
}

- (UITableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.tableFooterView = [UIView new];
        _menuTableView.dataSource = self.modelMenuData;
        _menuTableView.delegate = self;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _menuTableView;
}

- (LMVC_modelMenuData *)modelMenuData {
    if (!_modelMenuData) {
        _modelMenuData = [[LMVC_modelMenuData alloc] init];
    }
    return _modelMenuData;
}

@end
