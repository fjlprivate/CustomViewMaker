//
//  CheckViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "CheckViewController.h"
#import "CustomCheckView.h"
#import "Masonry.h"

#define WeakSelf(wself) __weak typeof(self)wself = self;

@interface CheckViewController()

@property (nonatomic, strong) CustomCheckView* checkView;
@property (nonatomic, strong) UIButton* showAnimation;
@property (nonatomic, strong) UIButton* hiddenAnimation;


@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 0x008b8b
    self.view.backgroundColor = [UIColor colorWithRed:0 green:(8*16+10+1)/255.f blue:(8*16+10+1)/255.f alpha:1.f];
    self.title = @"标记视图'勾'和'叉'";
    
    [self.view addSubview:self.checkView];
    [self.view addSubview:self.showAnimation];
    [self.view addSubview:self.hiddenAnimation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGRect frame = self.view.frame;
    CGFloat width = 100;
    CGFloat height = width;
    
    WeakSelf(wsef);
    [self.checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.centerX.equalTo(wsef.view.mas_centerX);
        make.centerY.equalTo(wsef.view.mas_centerY);
    }];
    [self.showAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.left.equalTo(wsef.view.mas_left).with.offset((frame.size.width - width*2)/2.f);
        make.top.mas_equalTo(64);
    }];
    [self.hiddenAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.left.equalTo(wsef.showAnimation.mas_right);
        make.top.equalTo(wsef.showAnimation.mas_top);
    }];
}


#pragma mask 2 ibaction
- (IBAction) clickToShow:(UIButton*)sender {
    [self.checkView showDuration:0.3 delay:0 completion:^{
        
    }];
}
- (IBAction) clickToHidden:(UIButton*)sender {
    [self.checkView hiddenOnCompletion:^{
        
    }];
}


#pragma mask 4 getter
- (CustomCheckView *)checkView {
    if (!_checkView) {
        _checkView = [[CustomCheckView alloc] init];
        _checkView.lineColor = [UIColor whiteColor];
        _checkView.lineWidth = 5.f;
        _checkView.checkViewStyle = CustomCheckViewStyleRight|CustomCheckViewStyleLineRound;
    }
    return _checkView;
}
- (UIButton *)showAnimation {
    if (!_showAnimation) {
        _showAnimation = [UIButton new];
        [_showAnimation setTitle:@"显示" forState:UIControlStateNormal];
        [_showAnimation setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_showAnimation setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_showAnimation addTarget:self action:@selector(clickToShow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showAnimation;
}
- (UIButton *)hiddenAnimation {
    if (!_hiddenAnimation) {
        _hiddenAnimation = [UIButton new];
        [_hiddenAnimation setTitle:@"隐藏" forState:UIControlStateNormal];
        [_hiddenAnimation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hiddenAnimation setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hiddenAnimation addTarget:self action:@selector(clickToHidden:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenAnimation;
}

@end
