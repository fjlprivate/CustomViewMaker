//
//  TestWifiViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/4/28.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestWifiViewController.h"


@implementation TestWifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self layoutSubviews];
}

- (void) addSubviews {
    [self.view addSubview:self.blueToothBackView];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.stopButton];
    [self.view addSubview:self.wifiView];
    [self.view addSubview:self.mlwifiView];
}
- (void) layoutSubviews {
    __weak typeof(self) wself = self;
    
    [self.blueToothBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wself.view.mas_centerX);
        make.centerY.equalTo(wself.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    [self.wifiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200 * 0.8);
        make.height.mas_equalTo(200 * 0.8);
        make.centerX.equalTo(wself.blueToothBackView.mas_centerX);
        make.centerY.equalTo(wself.blueToothBackView.mas_centerY).offset(- 200 * 0.8 * 0.5 * 0.25);
    }];
    [self.mlwifiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.bottom.mas_equalTo(wself.wifiView.mas_top).offset(- 10);
        make.width.mas_equalTo(wself.mlwifiView.mas_height);
    }];

    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.view.mas_left);
        make.right.equalTo(wself.view.mas_centerX);
        make.top.equalTo(wself.blueToothBackView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    
    [self.stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.startButton.mas_right);
        make.right.equalTo(wself.view.mas_right);
        make.top.equalTo(wself.startButton.mas_top);
        make.bottom.equalTo(wself.startButton.mas_bottom);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.blueToothBackView.layer addSublayer:[self makeBlueToothPathShapeLayerInFrame:CGRectMake(0, 0, 200, 200)]];
}





# pragma mask 2 private interface

- (CAShapeLayer*) makeBlueToothPathShapeLayerInFrame:(CGRect)frame {
    UIBezierPath* path = [UIBezierPath bezierPath];
    CGFloat unitWidth = frame.size.height * 0.8 * 0.25;

    if (unitWidth == 0) {
        return nil;
    }
    
    CGFloat centerX = frame.size.width * 0.5;
    CGFloat centerY = frame.size.height * 0.5;
    
    CGPoint leftTopP = CGPointMake(centerX - unitWidth, centerY - unitWidth);
    CGPoint leftBottomP = CGPointMake(centerX - unitWidth, centerY + unitWidth);
    
    CGPoint midTopP = CGPointMake(centerX, centerY - unitWidth * 2);
    CGPoint midBottomP = CGPointMake(centerX, centerY + unitWidth * 2);
    
    CGPoint rightTopP = CGPointMake(centerX + unitWidth, centerY - unitWidth);
    CGPoint rightBottomP = CGPointMake(centerX + unitWidth, centerY + unitWidth);
    
    [path moveToPoint:leftTopP];
    [path addLineToPoint:rightBottomP];
    [path addLineToPoint:midBottomP];
    [path addLineToPoint:midTopP];
    [path addLineToPoint:rightTopP];
    [path addLineToPoint:leftBottomP];
    
    CAShapeLayer* blueTShapeLayer = [CAShapeLayer layer];
    blueTShapeLayer.path = path.CGPath;
    
    blueTShapeLayer.fillColor = [UIColor clearColor].CGColor;
    blueTShapeLayer.strokeColor = [UIColor colorWithWhite:0.6 alpha:0.6].CGColor;
    blueTShapeLayer.lineWidth = 5.f;
    blueTShapeLayer.lineCap = kCALineCapButt;
    
    return blueTShapeLayer;
}



# pragma mask 4 getter

- (UIView *)blueToothBackView {
    if (!_blueToothBackView) {
        _blueToothBackView = [UIView new];
        _blueToothBackView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    }
    return _blueToothBackView;
}
- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton new];
        [_startButton setTitle:@"开始" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor colorWithHex:HexColorTypeDarkCyan alpha:1] forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return _startButton;
}
- (UIButton *)stopButton {
    if (!_stopButton) {
        _stopButton = [UIButton new];
        [_stopButton setTitle:@"停止" forState:UIControlStateNormal];
        [_stopButton setTitleColor:[UIColor colorWithHex:HexColorTypeDarkSlateBlue alpha:1] forState:UIControlStateNormal];
        [_stopButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return _stopButton;
}
- (WifiView *)wifiView {
    if (!_wifiView) {
        _wifiView = [[WifiView alloc] init];
        _wifiView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        _wifiView.animationCount = 3;
        _wifiView.ringCircleLayer.lineWidth = 8.f;
        _wifiView.ringCircleLayer.lineCap = kCALineCapButt;
        _wifiView.ringCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _wifiView.ringCircleLayer.fillColor = [UIColor clearColor].CGColor;
        
        _wifiView.centerCircleLayer.fillColor = [UIColor whiteColor].CGColor;
        _wifiView.centerCircleLayer.strokeColor = [UIColor clearColor].CGColor;
    }
    return _wifiView;
}

- (MLWifiView *)mlwifiView {
    if (!_mlwifiView) {
        _mlwifiView = [[MLWifiView alloc] init];
    }
    return _mlwifiView;
}

@end
