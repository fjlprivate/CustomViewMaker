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
#import <MBProgressHUD.h>

#define WeakSelf(wself) __weak typeof(self)wself = self;

@interface CheckViewController()

@property (nonatomic, strong) CustomCheckView* checkView;
@property (nonatomic, strong) UIButton* showAnimation;
@property (nonatomic, strong) UIButton* hiddenAnimation;
@property (nonatomic, strong) UIButton* rightButton;
@property (nonatomic, strong) UIButton* wrongButton;
@property (nonatomic, strong) MBProgressHUD* hud;

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
    [self.view addSubview:self.rightButton];
    [self.view addSubview:self.wrongButton];
    [self.view addSubview:self.hud];
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
    self.checkView.layer.cornerRadius = width/2.f;
    [self.showAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height/2.5));
        make.left.equalTo(wsef.view.mas_left).with.offset((frame.size.width - width*2)/2.f);
        make.top.mas_equalTo(64);
    }];
    [self.hiddenAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wsef.showAnimation);
        make.left.equalTo(wsef.showAnimation.mas_right);
        make.top.equalTo(wsef.showAnimation.mas_top);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wsef.hiddenAnimation);
        make.left.equalTo(wsef.showAnimation.mas_left);
        make.top.equalTo(wsef.showAnimation.mas_bottom);
    }];
    [self.wrongButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wsef.hiddenAnimation);
        make.left.equalTo(wsef.hiddenAnimation.mas_left);
        make.top.equalTo(wsef.hiddenAnimation.mas_bottom);
    }];

}


#pragma mask 2 ibaction
- (IBAction) clickToShow:(UIButton*)sender {
    [self.checkView showAnimation];
}
- (IBAction) clickToHidden:(UIButton*)sender {
    [self.checkView hiddenAnimation];
}
- (IBAction) clickToChangeRight:(UIButton*)sender {
    WeakSelf(wself);
    self.hud.labelText = @"加载中...";
    [self.hud show:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 创建 自定义'勾','叉' 子视图
        CGFloat width = 37;
        CustomCheckView* check = [[CustomCheckView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        check.layer.borderColor = [UIColor whiteColor].CGColor;
        check.layer.borderWidth = 3.f;
        check.layer.cornerRadius = width/2.f;
        check.checkViewStyle = CustomCheckViewStyleWrong|CustomCheckViewStyleLineRound;
        check.lineColor = [UIColor whiteColor];
        check.lineWidth = 3.f;
        
        // 修改 hud 的属性然后显示
        wself.hud.customView = check;
        wself.hud.mode = MBProgressHUDModeCustomView;
        wself.hud.animationType = MBProgressHUDAnimationZoomIn;
        wself.hud.labelText = @"测试自定义checkView";
        [wself.hud show:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [check showAnimation];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            wself.hud.animationType = MBProgressHUDAnimationZoomOut;
            [wself.hud hide:YES];
        });
    });
    
    
}
- (IBAction) clickToChangeWrong:(UIButton*)sender {
    [self.hud hide:YES];
}



#pragma mask 4 getter
- (CustomCheckView *)checkView {
    if (!_checkView) {
        _checkView = [[CustomCheckView alloc] init];
//        _checkView.layer.borderColor = [UIColor whiteColor].CGColor;
//        _checkView.layer.borderWidth = 4.f;
//        _checkView.backgroundColor = [UIColor orangeColor];
        _checkView.lineColor = [UIColor whiteColor];
        _checkView.lineWidth = 5.f;
        _checkView.checkViewStyle = CustomCheckViewStyleWrong|CustomCheckViewStyleLineRound;
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
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton new];
        [_rightButton setTitle:@"显示HUD" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(clickToChangeRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (UIButton *)wrongButton {
    if (!_wrongButton) {
        _wrongButton = [UIButton new];
        [_wrongButton setTitle:@"隐藏HUD" forState:UIControlStateNormal];
        [_wrongButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_wrongButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_wrongButton addTarget:self action:@selector(clickToChangeWrong:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wrongButton;
}
- (MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hud;
}

@end
