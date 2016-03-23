//
//  TestJLAlertView.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/21.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestJLAlertView.h"
#import <JCAlertView.h>
#import "Masonry.h"

@interface TestJLAlertView()

@property (nonatomic, strong) UIButton* normalShow;
@property (nonatomic, strong) UIButton* customShow;


@property (nonatomic, strong) JCAlertView* alertView;

@end

@implementation TestJLAlertView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self relayoutSubviews];
}

- (void) addSubviews {
    [self.view addSubview:self.normalShow];
    [self.view addSubview:self.customShow];
}
- (void) relayoutSubviews {
    CGFloat widthButton = 180;
    CGFloat heigthButton = 35;
    CGFloat inset = 13;
    
    __weak typeof(self)wself = self;
    [self.normalShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(widthButton, heigthButton));
        make.centerX.equalTo(wself.view.mas_centerX);
        make.centerY.equalTo(wself.view.mas_centerY);
    }];
    
    [self.customShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wself.normalShow);
        make.centerX.equalTo(wself.normalShow);
        make.centerY.equalTo(wself.normalShow).offset(- heigthButton/2.f - inset - heigthButton);
    }];
}


#pragma mask 1 IBActions
- (IBAction) clickToShowNormalAlert:(UIButton*)sender {
//    [JCAlertView showTwoButtonsWithTitle:@"JCAlertView"
//                                 Message:@"默认的提示窗口...2个按钮"
//                              ButtonType:JCAlertViewButtonTypeCancel
//                             ButtonTitle:@"取消"
//                                   Click:^{
//                                       NSLog(@"点击了取消");
//                                   }
//                              ButtonType:JCAlertViewButtonTypeDefault
//                             ButtonTitle:@"确定"
//                                   Click:^{
//                                       NSLog(@"点击了确定");
//        
//    }];
    [JCAlertView showMultipleButtonsWithTitle:@"结算方式" Message:nil Click:^(NSInteger index) {
        NSLog(@"点击了第%d个",index);
    } Buttons: @{@(JCAlertViewButtonTypeDefault) : @"T+1"},
               @{@(JCAlertViewButtonTypeDefault) : @"T+0"},
                @{@(JCAlertViewButtonTypeDefault) : @"T+6"},
     @{@(JCAlertViewButtonTypeWarn) : @"取消"},nil ];
    
}
- (IBAction) clickToShowCustomAlert:(UIButton*)sender {
    [self.alertView show];
}


#pragma mask 4 getter 
- (JCAlertView *)alertView {
    if (!_alertView) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
        view.backgroundColor = [UIColor orangeColor];
        _alertView = [[JCAlertView alloc] initWithCustomView:view dismissWhenTouchedBackground:YES];
        
        
    }
    return _alertView;
}
- (UIButton *)normalShow {
    if (!_normalShow) {
        _normalShow = [[UIButton alloc] initWithFrame:CGRectZero];
        [_normalShow setTitle:@"默认" forState:UIControlStateNormal];
        [_normalShow setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_normalShow setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_normalShow addTarget:self action:@selector(clickToShowNormalAlert:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _normalShow;
}
- (UIButton *)customShow {
    if (!_customShow) {
        _customShow = [[UIButton alloc] initWithFrame:CGRectZero];
        [_customShow setTitle:@"自定义" forState:UIControlStateNormal];
        [_customShow setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_customShow setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_customShow addTarget:self action:@selector(clickToShowCustomAlert:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customShow;
}

@end
