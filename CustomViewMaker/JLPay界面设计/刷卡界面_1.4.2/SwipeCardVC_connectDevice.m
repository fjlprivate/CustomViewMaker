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

/* 流程步骤视图 */
@property (nonatomic, strong) MLStepSegmentView* stepView;
/* 定时器秒表显示标签 */
@property (nonatomic, strong) UILabel* timeSecondLabel;
/* 状态标签 */
@property (nonatomic, strong) UILabel* stateLabel;
/* 设备sn标签 */
@property (nonatomic, strong) UILabel* deviceSNLabel;
/* mpos标签 */
@property (nonatomic, strong) UILabel* deviceNameLabel;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    [self relayoutSubviews];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.wifiView startAnimatingOnCompleted:^{
        
    }];
}

- (void) loadSubviews {
    [self.view addSubview:self.stepView];
    [self.view addSubview:self.timeSecondLabel];
    [self.view addSubview:self.stateLabel];
    [self.view addSubview:self.deviceSNLabel];
    [self.view addSubview:self.deviceNameLabel];
    [self.view addSubview:self.deviceIconLabel];
    [self.view addSubview:self.wifiView];
    [self.view addSubview:self.iphoneIconLabe];
    
//    self.timeSecondLabel.backgroundColor = [UIColor colorWithHex:0xe0e0e0 alpha:0.5];
//    self.stateLabel.backgroundColor = [UIColor colorWithHex:0xe0e0e0 alpha:0.5];
//    self.deviceSNLabel.backgroundColor = [UIColor colorWithHex:0xe0e0e0 alpha:0.5];
//    self.deviceNameLabel.backgroundColor = [UIColor colorWithHex:0xe0e0e0 alpha:0.5];
//    self.deviceIconLabel.backgroundColor = [UIColor colorWithHex:0xe0e0e0 alpha:0.5];
//    self.iphoneIconLabe.backgroundColor = [UIColor colorWithHex:0xe0e0e0 alpha:0.5];

}

- (void) relayoutSubviews {
    __weak typeof(self) wself = self;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    CGFloat heightStep = screenHeight * 40.f/612.f;
    CGFloat heightTimeSec = screenHeight * 20/612.f;
    CGFloat heightState = screenHeight * 20/612.f;
    CGFloat heightDeviceSn = screenHeight * 20/612.f;
    CGFloat heightDeviceName = screenHeight * 20/612.f;
    CGFloat heightDeviceIcon = screenHeight * 60/612.f;
    CGFloat heightWifi = screenHeight * 24.f * 2 / 612.f;
    CGFloat heightIphone = screenHeight * 94.f/612.f;
    
    self.timeSecondLabel.font = [UIFont boldSystemFontOfSize:[@"ss" resizeFontAtHeight:heightTimeSec scale:1.2]];
    self.stateLabel.font = [UIFont boldSystemFontOfSize:[@"ss" resizeFontAtHeight:heightState scale:0.9]];
    self.deviceSNLabel.font = [UIFont boldSystemFontOfSize:[@"ss" resizeFontAtHeight:heightDeviceSn scale:0.8]];
    self.deviceNameLabel.font = [UIFont boldSystemFontOfSize:[@"ss" resizeFontAtHeight:heightDeviceName scale:0.6]];
    self.deviceIconLabel.font = [UIFont fontAwesomeFontOfSize:[@"ss" resizeFontAtHeight:heightDeviceIcon scale:0.9]];
    self.iphoneIconLabe.font = [UIFont fontAwesomeFontOfSize:[@"ss" resizeFontAtHeight:heightIphone scale:1.5]];

    
    [self.stepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(screenWidth * 40.f/334.f);
        make.right.mas_equalTo(- screenWidth * 40.f/334.f);
        make.height.mas_equalTo(heightStep);
        make.centerY.mas_equalTo(wself.view.mas_top).offset( 64 + 5 + heightStep * 0.5);
    }];
    
    [self.timeSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(heightTimeSec);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1507 - 1356)/612.f * screenHeight + heightTimeSec * 0.5);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(heightState);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1540 - 1356)/612.f * screenHeight + heightState * 0.5);
    }];
    
    [self.deviceSNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(heightDeviceSn);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1597 - 1356)/612.f * screenHeight + heightDeviceSn * 0.5);
    }];
    
    [self.deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(heightDeviceName);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1639 - 1356)/612.f * screenHeight + heightDeviceName * 0.5);
    }];
    
    
    [self.deviceIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view.mas_centerX);
        make.width.height.mas_equalTo(heightDeviceIcon);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1659 - 1356)/612.f * screenHeight + heightDeviceIcon * 0.5);
    }];
    
    [self.wifiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view.mas_centerX);
        make.width.height.mas_equalTo(heightWifi);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1739 - 1356)/612.f * screenHeight + heightWifi * 0.5);
    }];
    
    [self.iphoneIconLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view.mas_centerX);
        make.width.height.mas_equalTo(heightIphone);
        make.centerY.mas_equalTo(wself.view.mas_top).offset((1816 - 1356)/612.f * screenHeight + heightIphone * 0.5);
    }];
}





# pragma mask 4 getter

- (MLStepSegmentView *)stepView {
    if (!_stepView) {
        _stepView = [[MLStepSegmentView alloc] initWithTitles:@[@"连接设备", @"刷卡", @"发起交易"]];
        _stepView.tintColor = [UIColor colorWithHex:0x00bb9c alpha:1];
        _stepView.itemSelected = 0;
    }
    return _stepView;
}
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
- (UILabel *)deviceNameLabel {
    if (!_deviceNameLabel) {
        _deviceNameLabel = [UILabel new];
        _deviceNameLabel.textAlignment = NSTextAlignmentCenter;
        _deviceNameLabel.textColor = [UIColor colorWithHex:0x999999 alpha:0.9];
        _deviceNameLabel.text = @"蓝牙设备";
    }
    return _deviceNameLabel;
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
