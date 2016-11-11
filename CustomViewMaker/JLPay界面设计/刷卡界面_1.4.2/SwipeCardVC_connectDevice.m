//
//  SwipeCardVC_connectDevice.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/8.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "SwipeCardVC_connectDevice.h"
#import "MLStepSegmentView.h"
#import "MLWifiView.h"
#import "UIColor+ColorWithHex.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "Masonry.h"
#import "NSString+Custom.h"



@interface SwipeCardVC_connectDevice ()

/* 定时器秒表显示标签 */
@property (nonatomic, strong) UILabel* timeSecondLabel;
/* 状态标签 */
@property (nonatomic, strong) UILabel* stateLabel;
/* 设备sn标签 */
@property (nonatomic, strong) UILabel* deviceSNLabel;
/* 图片icon标签 */
@property (nonatomic, strong) UILabel* deviceIconLabel;
/* wifi视图 */
@property (nonatomic, strong) MLWifiView* wifiView;
/* 手机icon标签 */
@property (nonatomic, strong) UILabel* iphoneIconLabe;;

@end




@implementation SwipeCardVC_connectDevice

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费:￥100.00";
    self.view.backgroundColor = [UIColor colorWithHex:0xffffff alpha:1];
    [self loadSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self relayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.wifiView startAnimatingOnCompleted:^{
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [self.wifiView endAnimatingOnCompleted:^{
        
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void) loadSubviews {
    [self.view addSubview:self.timeSecondLabel];
    [self.view addSubview:self.stateLabel];
    [self.view addSubview:self.deviceSNLabel];
    [self.view addSubview:self.deviceIconLabel];
    [self.view addSubview:self.wifiView];
    [self.view addSubview:self.iphoneIconLabe];
}

- (void) relayoutSubviews {
    __weak typeof(self) wself = self;
    CGFloat screenHeight = self.view.frame.size.height;
    
    CGFloat scaleHeight = 500.f;
    
    CGFloat heightTimeSec = screenHeight * 20/scaleHeight;
    CGFloat heightState = screenHeight * 20/scaleHeight;
    CGFloat heightDeviceSn = screenHeight * 20/scaleHeight;
    CGFloat heightDeviceIcon = screenHeight * 60/scaleHeight;
    CGFloat heightWifi = screenHeight * 24.f * 2 / scaleHeight;
    CGFloat heightIphone = screenHeight * 94.f/scaleHeight;
    
    self.timeSecondLabel.font = [UIFont boldSystemFontOfSize:[@"ss" resizeFontAtHeight:heightTimeSec scale:1.2]];
    self.stateLabel.font = [UIFont boldSystemFontOfSize:[@"ss" resizeFontAtHeight:heightState scale:0.9]];
    self.deviceSNLabel.font = [UIFont boldSystemFontOfSize:[@"ss" resizeFontAtHeight:heightDeviceSn scale:0.6]];
    self.deviceIconLabel.font = [UIFont fontAwesomeFontOfSize:[@"ss" resizeFontAtHeight:heightDeviceIcon scale:0.9]];
    self.iphoneIconLabe.font = [UIFont fontAwesomeFontOfSize:[@"ss" resizeFontAtHeight:heightIphone scale:1.5]];

    
    [self.timeSecondLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(heightTimeSec);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1507 - 1468)/scaleHeight * screenHeight + heightTimeSec * 0.5);
    }];
    
    [self.stateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(heightState);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1553 - 1468)/scaleHeight * screenHeight + heightState * 0.5);
    }];
    
    [self.deviceSNLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(heightDeviceSn);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1627 - 1468)/scaleHeight * screenHeight + heightDeviceSn * 0.5);
    }];
    
    
    [self.deviceIconLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view.mas_centerX);
        make.width.height.mas_equalTo(heightDeviceIcon);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1659 - 1468)/scaleHeight * screenHeight + heightDeviceIcon * 0.5);
    }];
    
    [self.wifiView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view.mas_centerX);
        make.width.height.mas_equalTo(heightWifi);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1741 - 1468)/scaleHeight * screenHeight + heightWifi * 0.5);
    }];
    
    [self.iphoneIconLabe mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view.mas_centerX);
        make.width.height.mas_equalTo(heightIphone);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1816 - 1468)/scaleHeight * screenHeight + heightIphone * 0.5);
    }];
}





# pragma mask 4 getter

- (UILabel *)timeSecondLabel {
    if (!_timeSecondLabel) {
        _timeSecondLabel = [UILabel new];
        _timeSecondLabel.textAlignment = NSTextAlignmentCenter;
        _timeSecondLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        _timeSecondLabel.text = @"29s";
    }
    return _timeSecondLabel;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1];
        _stateLabel.text = @"正在连接设备...";
    }
    return _stateLabel;
}
- (UILabel *)deviceSNLabel {
    if (!_deviceSNLabel) {
        _deviceSNLabel = [UILabel new];
        _deviceSNLabel.textAlignment = NSTextAlignmentCenter;
        _deviceSNLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1];
        _deviceSNLabel.text = @"设备:SMIT001000000234";
    }
    return _deviceSNLabel;
}
- (MLWifiView *)wifiView {
    if (!_wifiView) {
        _wifiView = [[MLWifiView alloc] init];
        _wifiView.tintColor = [UIColor colorWithHex:0x00bb9c alpha:0.6];
        _wifiView.onTint = NO;
    }
    return _wifiView;
}
- (UILabel *)deviceIconLabel {
    if (!_deviceIconLabel) {
        _deviceIconLabel = [UILabel new];
        _deviceIconLabel.textAlignment = NSTextAlignmentCenter;
        _deviceIconLabel.textColor = [UIColor colorWithHex:0x27384b alpha:0.5];
        _deviceIconLabel.text = [NSString fontAwesomeIconStringForEnum:FAcalculator];
    }
    return _deviceIconLabel;
}
- (UILabel *)iphoneIconLabe {
    if (!_iphoneIconLabe) {
        _iphoneIconLabe = [UILabel new];
        _iphoneIconLabe.textAlignment = NSTextAlignmentCenter;
        _iphoneIconLabe.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        _iphoneIconLabe.text = [NSString fontAwesomeIconStringForEnum:FAMobile];
    }
    return _iphoneIconLabe;
}

@end
