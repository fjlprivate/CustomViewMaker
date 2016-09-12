//
//  TestForCustomAlertView.m
//  CustomViewMaker
//
//  Created by jielian on 16/6/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForCustomAlertView.h"
#import "Masonry.h"

@implementation TestForCustomAlertView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CustomIOSAlertView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.showButton];
    [self.view addSubview:self.closeButton];
    
    [self layoutSubviews];
    
}



- (void) layoutSubviews {
    __weak typeof(self) wself = self;
    
    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wself.view.mas_centerX).multipliedBy(0.5);
        make.centerY.equalTo(wself.view.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wself.view.mas_centerX).multipliedBy(1.5);
        make.centerY.equalTo(wself.view.mas_centerY);
        make.width.and.height.equalTo(wself.showButton);
    }];
    
    
}


# pragma mask 3 IBAction

- (IBAction) showAlert:(id)sender {
    [self.alertView show];
}
- (IBAction) closeAlert:(id)sender {
    [self.alertView close];
}


# pragma mask 4 getter

- (UIButton *)showButton {
    if (!_showButton) {
        _showButton = [UIButton new];
        [_showButton setBackgroundColor:[UIColor cyanColor]];
        [_showButton setTitle:@"show" forState:UIControlStateNormal];
        [_showButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showButton addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showButton;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton new];
        [_closeButton setBackgroundColor:[UIColor orangeColor]];
        [_closeButton setTitle:@"close" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (CustomIOSAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[CustomIOSAlertView alloc] init];
        _alertView.parentView = self.view;
        _alertView.buttonTitles = @[@"title1",@"title2",@"title3",@"title4"];
        _alertView.useMotionEffects = YES;
        _alertView.onButtonTouchUpInside = ^ (CustomIOSAlertView *alertView, int buttonIndex) {
            [alertView close];
        };
    }
    return _alertView;
}

@end
