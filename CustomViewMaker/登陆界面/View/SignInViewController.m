//
//  SignInViewController.m
//  NewJLPayViewDesign
//
//  Created by 冯金龙 on 16/3/12.
//  Copyright © 2016年 冯金龙. All rights reserved.
//

#import "SignInViewController.h"
#import "Masonry.h"
#import "NSString+Custom.h"
#import "SignInInputView.h"

@interface SignInViewController()

@property (nonatomic ,strong) UIImageView* backImage;
@property (nonatomic, strong) UIVisualEffectView* effectView;
@property (nonatomic, strong) UIImageView* logoImage;
@property (nonatomic, strong) UILabel* logoNameLabel;
@property (nonatomic, strong) UILabel* companyUrlLabel;

@property (nonatomic, strong) SignInInputView* userTextField;
@property (nonatomic, strong) SignInInputView* pwdTextField;

@property (nonatomic, strong) UIButton* signinButton;
@property (nonatomic, strong) UIButton* forgetPwdButton;
@property (nonatomic, strong) UIButton* signupButton;

@end


@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self loadSubviews];
    [self relayoutSubviews];
}
- (void) loadSubviews {
    [self.view addSubview:self.backImage];
    [self.view addSubview:self.effectView];
    [self.view addSubview:self.logoImage];
    [self.view addSubview:self.logoNameLabel];
    [self.view addSubview:self.companyUrlLabel];
    [self.view addSubview:self.userTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.signinButton];
    [self.view addSubview:self.forgetPwdButton];
    [self.view addSubview:self.signupButton];
}
- (void) relayoutSubviews {
    __weak typeof(self) wself = self;
    CGRect frame = self.view.frame;    
    CGFloat heightRate = frame.size.height / 667.f;
    CGFloat widthRate = frame.size.width / 375.f;
    
    CGFloat widthLogoImage = 90.f * heightRate;
    CGFloat widthTextField = 300.f * widthRate;
    CGFloat heightBig = 50.f * heightRate;
    CGFloat heightLittle = 20.f * heightRate;
    CGFloat heightMin = 20.f * heightRate;
    CGFloat insetUserToComp = (frame.size.height/2.f - widthLogoImage - heightBig - heightMin * 1.4 ) * 3.f/7.f;
    [self.effectView setFrame:frame];
    [self.backImage setFrame:frame];
    
    // 用户名
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(widthTextField, heightBig));
        make.top.equalTo(wself.view.mas_centerY);
        make.left.equalTo(wself.view.mas_left).offset((frame.size.width - widthTextField)/2.f);
    }];
    // 密码
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wself.userTextField);
        make.left.equalTo(wself.userTextField.mas_left);
        make.top.equalTo(wself.userTextField.mas_bottom).offset(1.5);
    }];
    // 登陆
    [self.signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wself.userTextField);
        make.left.equalTo(wself.userTextField);
        make.top.equalTo(wself.pwdTextField.mas_bottom).offset(heightMin);
    }];
    // 忘记密码
    NSString* title = [self.forgetPwdButton titleForState:UIControlStateNormal];
    CGSize size = [title resizeAtHeight:heightLittle scale:1];
    self.forgetPwdButton.titleLabel.font = [UIFont systemFontOfSize:[title resizeFontAtHeight:heightLittle scale:1]];
    [self.forgetPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(heightLittle);
        make.width.mas_equalTo(size.width + 4);
        make.left.equalTo(wself.signinButton);
        make.top.equalTo(wself.signinButton.mas_bottom).offset(heightMin);
    }];
    // 用户注册
    self.signupButton.titleLabel.font = [UIFont systemFontOfSize:[title resizeFontAtHeight:heightLittle scale:1]];
    [self.signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(wself.forgetPwdButton);
        make.right.equalTo(wself.signinButton.mas_right);
        make.top.equalTo(wself.forgetPwdButton);
    }];
    // 公司域名
    [self.companyUrlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([wself.companyUrlLabel.text resizeAtHeight:heightMin scale:1]);
        make.centerX.equalTo(wself.view.mas_centerX);
        make.bottom.equalTo(wself.userTextField.mas_top).offset(-insetUserToComp);
    }];
    self.companyUrlLabel.font = [UIFont systemFontOfSize:[self.companyUrlLabel.text resizeFontAtHeight:heightMin scale:0.95]];
    // app名
    [self.logoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([wself.logoNameLabel.text resizeAtHeight:heightBig scale:0.9]);
        make.centerX.equalTo(wself.view.mas_centerX);
        make.bottom.equalTo(wself.companyUrlLabel.mas_top);
    }];
    self.logoNameLabel.font = [UIFont systemFontOfSize:[self.logoNameLabel.text resizeFontAtHeight:heightBig scale:0.8]];
    // logo
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(widthLogoImage, widthLogoImage));
        make.centerX.equalTo(wself.logoNameLabel);
        make.bottom.equalTo(wself.logoNameLabel.mas_top).offset(-heightMin * 0.4);
    }];
    self.logoImage.layer.cornerRadius = widthLogoImage/2.f;
}



#pragma mask 4 getter
- (UIImageView *)backImage {
    if (!_backImage) {
        _backImage = [[UIImageView alloc] init];
        _backImage.image = [UIImage imageNamed:@"backView0"];
    }
    return _backImage;
}
- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    }
    return _effectView;
}
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] init];
        _logoImage.image = [UIImage imageNamed:@"JLPayLogo"];
    }
    return _logoImage;
}
- (UILabel *)logoNameLabel {
    if (!_logoNameLabel) {
        _logoNameLabel = [[UILabel alloc] init];
        _logoNameLabel.text = @"捷联通";
        _logoNameLabel.textAlignment = NSTextAlignmentCenter;
        _logoNameLabel.textColor = [UIColor whiteColor];
    }
    return _logoNameLabel;
}
- (UILabel *)companyUrlLabel {
    if (!_companyUrlLabel) {
        _companyUrlLabel = [[UILabel alloc] init];
        _companyUrlLabel.textColor = [UIColor whiteColor];
        _companyUrlLabel.text = @"CCCPAY.CN";
        _companyUrlLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _companyUrlLabel;
}
- (SignInInputView *)userTextField {
    if (!_userTextField) {
        _userTextField = [[SignInInputView alloc] init];
        _userTextField.placeHold = @"请输入登陆用户名";
        _userTextField.cornerRadius = 6.f;
        _userTextField.direction = SignInInputViewDirecitionUp;
        _userTextField.leftImageView.image = [UIImage imageNamed:@"头像"];
    }
    return _userTextField;
}
- (SignInInputView *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [[SignInInputView alloc] init];
        _pwdTextField.placeHold = @"请输入登陆密码";
        _pwdTextField.cornerRadius = 6.f;
        _pwdTextField.direction = SignInInputViewDirecitionDown;
    }
    return _pwdTextField;
}
- (UIButton *)signinButton {
    if (!_signinButton) {
        _signinButton = [[UIButton alloc] init];
        _signinButton.backgroundColor = [UIColor redColor];
        [_signinButton setTitle:@"登录" forState:UIControlStateNormal];
        [_signinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signinButton setTitleColor:[UIColor colorWithWhite:0.8 alpha:0.7] forState:UIControlStateHighlighted];
        _signinButton.layer.cornerRadius = 6.f;
    }
    return _signinButton;
}
- (UIButton *)forgetPwdButton {
    if (!_forgetPwdButton) {
        _forgetPwdButton = [[UIButton alloc] init];
        [_forgetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPwdButton setTitleColor:[UIColor colorWithWhite:0.8 alpha:0.9] forState:UIControlStateNormal];
        [_forgetPwdButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return _forgetPwdButton;
}
- (UIButton *)signupButton {
    if (!_signupButton) {
        _signupButton = [[UIButton alloc] init];
        [_signupButton setTitle:@"用户注册" forState:UIControlStateNormal];
        [_signupButton setTitleColor:[UIColor colorWithWhite:0.8 alpha:0.9] forState:UIControlStateNormal];
        [_signupButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return _signupButton;
}

@end
