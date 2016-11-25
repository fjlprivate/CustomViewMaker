//
//  TestForKeywindowVC.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/14.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForKeywindowVC.h"
#import "PublicHeader.h"

@interface TestForKeywindowVC ()

@property (nonatomic, strong) UIButton* showBtn;

@property (nonatomic, strong) UIWindow* newsKeyWindow;

@property (nonatomic, strong) UIButton* hiddenBtn;

@property (nonatomic, weak) UIWindow* lastKeyWindow;

@end

@implementation TestForKeywindowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test key window";
    self.view.backgroundColor = [UIColor colorWithHex:0x00bb9c alpha:1];
    NameWeakSelf(wself);
    self.lastKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    [self.view addSubview:self.showBtn];
    [self.showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(wself.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    self.showBtn.layer.cornerRadius = 25;
    
    [self.newsKeyWindow addSubview:self.hiddenBtn];
    [self.hiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.newsKeyWindow);
        make.centerY.mas_equalTo(wself.newsKeyWindow.mas_centerY).offset(25 + 20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    self.hiddenBtn.layer.cornerRadius = 25;
    
}


# pragma mask 2 IBAction

- (IBAction) clickedShowBtn:(UIButton*)sender {
    [self.newsKeyWindow makeKeyAndVisible];
}


- (IBAction) clickedHiddenBtn:(id)sender {
    [self.lastKeyWindow makeKeyAndVisible];
}


# pragma mask 4 getter

- (UIButton *)showBtn {
    if (!_showBtn) {
        _showBtn = [UIButton new];
        _showBtn.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        [_showBtn setTitle:@"\"show keyWindow\"" forState:UIControlStateNormal];
        _showBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_showBtn setTitleColor:[UIColor colorWithHex:0xffffff alpha:1] forState:UIControlStateNormal];
        [_showBtn setTitleColor:[UIColor colorWithHex:0xffffff alpha:0.3] forState:UIControlStateHighlighted];
        [_showBtn addTarget:self action:@selector(clickedShowBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}

- (UIButton *)hiddenBtn {
    if (!_hiddenBtn) {
        _hiddenBtn = [UIButton new];
        _hiddenBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        [_hiddenBtn setTitle:@"\"hide keyWindow\"" forState:UIControlStateNormal];
        _hiddenBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_hiddenBtn setTitleColor:[UIColor colorWithHex:0x27384b alpha:1] forState:UIControlStateNormal];
        [_hiddenBtn setTitleColor:[UIColor colorWithHex:0x27384b alpha:0.3] forState:UIControlStateHighlighted];
        [_hiddenBtn addTarget:self action:@selector(clickedHiddenBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenBtn;
}

- (UIWindow *)newsKeyWindow {
    if (!_newsKeyWindow) {
        _newsKeyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _newsKeyWindow.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.4];
    }
    return _newsKeyWindow;
}

@end
