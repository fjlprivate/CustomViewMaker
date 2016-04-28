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
}
- (void) layoutSubviews {
    __weak typeof(self) wself = self;
    
    [self.blueToothBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wself.view.mas_centerX);
        make.centerY.equalTo(wself.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        wself.blueToothBackView.layer.cornerRadius = 100;
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
    
    [self.blueToothBackView.layer addSublayer:[self makeBlueToothPathShapeLayerInFrame:self.blueToothBackView.bounds]];
}





# pragma mask 2 private interface

- (CAShapeLayer*) makeBlueToothPathShapeLayerInFrame:(CGRect)frame {
    UIBezierPath* path = [UIBezierPath bezierPath];
    CGFloat unitWidth = frame.size.height / 4;
    if (unitWidth == 0) {
        return nil;
    }
    
    CGFloat centerX = frame.size.width * 0.5;
    CGPoint leftTopP = CGPointMake(centerX - unitWidth, unitWidth);
    CGPoint leftBottomP = CGPointMake(centerX - unitWidth, frame.size.height - unitWidth);
    
    CGPoint midTopP = CGPointMake(centerX, 0);
    CGPoint midBottomP = CGPointMake(centerX, frame.size.height);
    
    CGPoint rightTopP = CGPointMake(centerX + unitWidth, unitWidth);
    CGPoint rightBottomP = CGPointMake(centerX + unitWidth, frame.size.height - unitWidth);
    
    [path moveToPoint:leftTopP];
    [path addLineToPoint:rightBottomP];
    [path addLineToPoint:midBottomP];
    [path addLineToPoint:midTopP];
    [path addLineToPoint:rightTopP];
    [path addLineToPoint:leftBottomP];
    [path closePath];
    
    CAShapeLayer* blueTShapeLayer = [CAShapeLayer layer];
    blueTShapeLayer.path = path.CGPath;
    
    blueTShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    blueTShapeLayer.lineWidth = 2.f;
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

@end
