//
//  TestMBProgressHUD.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestMBProgressHUD.h"
#import "Masonry.h"
#import "MBProgressHUD+CustomSate.h"

@interface TestMBProgressHUD()

@property (nonatomic, strong) MBProgressHUD* progressHUD;
@property (nonatomic, strong) UIButton* showSucButton;
@property (nonatomic, strong) UIButton* showFailButton;
@property (nonatomic, strong) UIButton* showWarnButton;


@end

@implementation TestMBProgressHUD

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.progressHUD];
    [self.view addSubview:self.showSucButton];
    [self.view addSubview:self.showFailButton];
    [self.view addSubview:self.showWarnButton];

    [self relayoutSubviews];
}

- (void) relayoutSubviews {
    __weak typeof(self)wself = self;
    [self.showSucButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.equalTo(wself.view.mas_centerX);
        make.centerY.equalTo(wself.view.mas_centerY).offset(-200);
    }];
    [self.showFailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wself.showSucButton);
        make.top.equalTo(wself.showSucButton.mas_bottom);
        make.left.equalTo(wself.showSucButton.mas_left);
    }];
    [self.showWarnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wself.showSucButton);
        make.top.equalTo(wself.showFailButton.mas_bottom);
        make.left.equalTo(wself.showFailButton.mas_left);
    }];
}



- (IBAction) clickToShowSucHUD:(UIButton*)sender {
    __weak typeof(self)wself = self;
    [self.progressHUD showSuccessWithText:@"交易成功!" andDetailText:nil onCompletion:^{
        [wself.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction) clickToShowFailHUD:(UIButton*)sender {
    __weak typeof(self)wself = self;
    [self.progressHUD showFailWithText:@"交易失败" andDetailText:@"网络异常，请检查网络后重试" onCompletion:^{
        [wself.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction) clickToShowWarnHUD:(UIButton*)sender {
    __weak typeof(self)wself = self;
    
    [self.progressHUD showNormalWithText:@"数据加载中..." andDetailText:nil];
    
    [self.progressHUD hideDelay:2.5 onCompletion:^{
        [wself.progressHUD showSuccessWithText:@"交易成功!" andDetailText:nil onCompletion:^{
            NSLog(@"navigation = [%@]",wself.navigationController);
            [wself.navigationController popViewControllerAnimated:YES];
        }];
    }];
}



- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _progressHUD;
}
- (UIButton *)showSucButton {
    if (!_showSucButton) {
        _showSucButton = [UIButton new];
        [_showSucButton setTitle:@"显示成功" forState:UIControlStateNormal];
        [_showSucButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showSucButton addTarget:self action:@selector(clickToShowSucHUD:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showSucButton;
}
- (UIButton *)showFailButton {
    if (!_showFailButton) {
        _showFailButton = [UIButton new];
        [_showFailButton setTitle:@"显示失败" forState:UIControlStateNormal];
        [_showFailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showFailButton addTarget:self action:@selector(clickToShowFailHUD:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showFailButton;

}
- (UIButton *)showWarnButton {
    if (!_showWarnButton) {
        _showWarnButton = [UIButton new];
        [_showWarnButton setTitle:@"显示超时" forState:UIControlStateNormal];
        [_showWarnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showWarnButton addTarget:self action:@selector(clickToShowWarnHUD:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showWarnButton;

}

@end
