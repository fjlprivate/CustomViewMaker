//
//  JLSignInViewController.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/5/31.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "JLSignInViewController.h"

@implementation JLSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.seenVisible = NO;
    self.savedEnable = YES;
    
    
    [self.navigationController setNavigationBarHidden:YES];
    [self loadSubviews];
    [self layoutSubviews];
    [self manageOnKVOs];
}



- (void) manageOnKVOs {
    
    @weakify(self);
    [[RACObserve(self, savedEnable) deliverOnMainThread] subscribeNext:^(NSNumber* enable) {
        @strongify(self);
        if (enable.boolValue) {
            [self.pwdSavingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self.pwdSavingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }];
    
    [[RACObserve(self, seenVisible) deliverOnMainThread] subscribeNext:^(NSNumber* visible) {
        @strongify(self);
        if (visible.boolValue) {
            [self.visiblePwdSeenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.visiblePwdSeenBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAEye] forState:UIControlStateNormal];
        } else {
            [self.visiblePwdSeenBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.visiblePwdSeenBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAEyeSlash] forState:UIControlStateNormal];
        }
    }];
    
    RAC(self.pwdTextField, secureTextEntry) = [[RACObserve(self, seenVisible) deliverOnMainThread] map:^NSNumber*(NSNumber* visible) {
        return @(!visible.boolValue);
    }];
    
}


# pragma mask 2 IBAction

- (IBAction) clickedSavingPwdBtn:(id)sender {
    self.savedEnable = !self.savedEnable;
}
- (IBAction) clickedPwdSeenBtn:(id)sender {
    self.seenVisible = !self.seenVisible;
}

# pragma mask 3 UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 处理遮挡
    CGFloat textFieldBottom = textField.frame.origin.y + textField.frame.size.height;
    CGFloat offset = ((self.view.frame.size.height - textFieldBottom) < (216 + 35 + 20))?(216 + 35 + 20 - self.view.frame.size.height + textFieldBottom):(0);
    
    [self pullViewUpFrontKeyBordByOffset:offset];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // 处理取消键盘和回档
    [self pullViewUpFrontKeyBordByOffset:0];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self pullViewUpFrontKeyBordByOffset:0];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"---原有的text[%@],新输入的[%@]",textField.text, string);
    if (textField.tag == 18) { // 密码限制输入8位
        if (textField.text.length < 8) {
            return YES;
        }
        else {
            if (string.length == 0) { /* 退格键 */
                return YES;
            } else {
                return NO;
            }
        }
    }
    else {
        return YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self pullViewUpFrontKeyBordByOffset:0];
    for (UIView* subView in self.view.subviews) {
        if ([subView class] == [UITextField class]) {
            [subView resignFirstResponder];
        }
    }
}

- (void) pullViewUpFrontKeyBordByOffset:(CGFloat)offset {
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        wself.view.transform = CGAffineTransformMakeTranslation(0, - offset);
    } completion:^(BOOL finished) {
        
    }];
    
}

# pragma mask 4 布局

- (void) loadSubviews {
    
    [self.view addSubview:self.backgroundImgView];
    
    [self.view addSubview:self.logoImgView];
    
    [self.view addSubview:self.userTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.headLabel];
    [self.view addSubview:self.lockLabel];
    
    [self.view addSubview:self.visiblePwdSeenBtn];
    [self.view addSubview:self.pwdSavingBtn];
    [self.view addSubview:self.pwdSavingLabel];
    [self.view addSubview:self.pwdForgottenBtn];
    
    [self.view addSubview:self.signUpBtn];
    [self.view addSubview:self.signInBtn];
    
}

- (void) layoutSubviews {
    __weak typeof(self) wself = self;
    
    CGFloat inset = 15;
    
    CGFloat widthLogoImg = self.view.frame.size.width * 0.5;
    CGFloat heightLogoImg = widthLogoImg * self.logoImgView.image.size.height/self.logoImgView.image.size.width;
    
    CGFloat heightTxtField = self.view.frame.size.height * 1/13;
    CGFloat heightBtn = self.view.frame.size.height * 1/13;
    
    CGFloat widthPwdForgotBtn = 100;
    
    self.userTextField.layer.cornerRadius = heightTxtField * 0.5;
    self.pwdTextField.layer.cornerRadius = heightTxtField * 0.5;
    self.signInBtn.layer.cornerRadius = heightBtn * 0.5;
    
    self.userTextField.font = [UIFont systemFontOfSize:[@"xx" resizeFontAtHeight:heightTxtField scale:0.4]];
    self.pwdTextField.font = [UIFont systemFontOfSize:[@"xx" resizeFontAtHeight:heightTxtField scale:0.4]];
    self.signInBtn.titleLabel.font = [UIFont systemFontOfSize:[@"xx" resizeFontAtHeight:heightBtn scale:0.38]];
    self.signUpBtn.titleLabel.font = [UIFont systemFontOfSize:[@"xx" resizeFontAtHeight:heightBtn scale:0.38]];
    self.pwdSavingLabel.font = [UIFont systemFontOfSize:[@"xx" resizeFontAtHeight:heightTxtField scale:0.38]];
    self.pwdForgottenBtn.titleLabel.font = [UIFont systemFontOfSize:[@"xx" resizeFontAtHeight:heightTxtField scale:0.38]];
    self.pwdSavingBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[@"xx" resizeFontAtHeight:heightTxtField scale:0.5]];
    self.headLabel.font = [UIFont fontAwesomeFontOfSize:[@"xx" resizeFontAtHeight:heightTxtField scale:0.5]];
    self.lockLabel.font = [UIFont fontAwesomeFontOfSize:[@"xx" resizeFontAtHeight:heightTxtField scale:0.5]];
    self.visiblePwdSeenBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[@"xx" resizeFontAtHeight:heightTxtField scale:0.5]];

    
    [self.backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.view.mas_left);
        make.right.equalTo(wself.view.mas_right);
        make.top.equalTo(wself.view.mas_top);
        make.bottom.equalTo(wself.view.mas_bottom);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wself.view.mas_centerX);
        make.bottom.equalTo(wself.view.mas_top).offset(wself.view.frame.size.height * 0.25);
        make.size.mas_equalTo(CGSizeMake(widthLogoImg, heightLogoImg));
    }];
    
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wself.view.mas_centerY).offset(- 3);
        make.left.equalTo(wself.view.mas_left).offset(inset);
        make.right.equalTo(wself.view.mas_right).offset(-inset);
        make.height.mas_equalTo(heightTxtField);
    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.userTextField.mas_bottom).offset(6);
        make.left.equalTo(wself.view.mas_left).offset(inset);
        make.right.equalTo(wself.view.mas_right).offset(-inset);
        make.height.mas_equalTo(heightTxtField);
    }];
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.userTextField.mas_left).offset(heightTxtField * 0);
        make.top.equalTo(wself.userTextField.mas_top);
        make.bottom.equalTo(wself.userTextField.mas_bottom);
        make.width.mas_equalTo(heightTxtField * 1.5);
    }];
    
    [self.lockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.pwdTextField.mas_left).offset(heightTxtField * 0);
        make.top.equalTo(wself.pwdTextField.mas_top);
        make.bottom.equalTo(wself.pwdTextField.mas_bottom);
        make.width.mas_equalTo(heightTxtField * 1.5);
    }];
    
    [self.visiblePwdSeenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wself.pwdTextField.mas_right).offset(- heightTxtField * 0.5);
        make.centerY.equalTo(wself.pwdTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(heightTxtField, heightTxtField));
    }];
    
    [self.pwdSavingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.pwdTextField.mas_bottom).offset(0);
        make.left.equalTo(wself.pwdTextField.mas_left).offset(0);
        make.width.mas_equalTo(heightTxtField);
        make.height.mas_equalTo(heightTxtField);
    }];
    
    [self.pwdSavingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.pwdTextField.mas_bottom).offset(0);
        make.left.equalTo(wself.pwdSavingBtn.mas_right).offset(0);
        make.right.equalTo(wself.view.mas_centerX);
        make.height.mas_equalTo(heightTxtField);
    }];
    
    [self.pwdForgottenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.pwdSavingLabel.mas_top);
        make.right.equalTo(wself.pwdTextField.mas_right);
        make.width.mas_equalTo(widthPwdForgotBtn);
        make.height.mas_equalTo(heightTxtField);
    }];
    
    [self.signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wself.view.mas_bottom).offset(0);
        make.left.equalTo(wself.view.mas_left).offset(inset);
        make.right.equalTo(wself.view.mas_right).offset(-inset);
        make.height.mas_equalTo(heightBtn);
    }];
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wself.view.mas_bottom).offset(- heightBtn);
        make.left.equalTo(wself.view.mas_left).offset(inset);
        make.right.equalTo(wself.view.mas_right).offset(-inset);
        make.height.mas_equalTo(heightBtn);
    }];
    
}






# pragma mask 5 getter

- (UIImageView *)backgroundImgView {
    if (!_backgroundImgView) {
        _backgroundImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGroundImg"]];
    }
    return _backgroundImgView;
}
- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppLogoImage"]];
    }
    return _logoImgView;
}

- (UILabel *)headLabel {
    if (!_headLabel) {
        _headLabel = [UILabel new];
        _headLabel.text = [NSString fontAwesomeIconStringForEnum:FAUser];
        _headLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
        _headLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _headLabel;
}
- (UILabel *)lockLabel {
    if (!_lockLabel) {
        _lockLabel = [UILabel new];
        _lockLabel.text = [NSString fontAwesomeIconStringForEnum:FALock];
        _lockLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
        _lockLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lockLabel;
}

- (UITextField *)userTextField {
    if (!_userTextField) {
        _userTextField = [UITextField new];
        _userTextField.placeholder = @"请输入用户名";
        _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userTextField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
        _userTextField.layer.borderWidth = 1.f;
        _userTextField.textAlignment = NSTextAlignmentCenter;
        _userTextField.textColor = [UIColor whiteColor];
        _userTextField.delegate = self;
    }
    return _userTextField;
}
- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [UITextField new];
        _pwdTextField.placeholder = @"请输入8位密码";
        _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdTextField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
        _pwdTextField.layer.borderWidth = 1.f;
        _pwdTextField.textAlignment = NSTextAlignmentCenter;
        _pwdTextField.textColor = [UIColor whiteColor];
        _pwdTextField.keyboardType = UIKeyboardTypeAlphabet;
        _pwdTextField.delegate = self;
        _pwdTextField.tag = 18;
    }
    return _pwdTextField;
}

- (UIButton *)signInBtn {
    if (!_signInBtn) {
        _signInBtn = [UIButton new];
        _signInBtn.backgroundColor = [UIColor colorWithHex:0xef454b];
        [_signInBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signInBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        [_signInBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateDisabled];
    }
    return _signInBtn;
}
- (UIButton *)signUpBtn {
    if (!_signUpBtn) {
        _signUpBtn = [UIButton new];
        [_signUpBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_signUpBtn setTitleColor:[UIColor colorWithHex:HexColorTypeLightSlateGray] forState:UIControlStateNormal];
        [_signUpBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        [_signUpBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateDisabled];
    }
    return _signUpBtn;
}

- (UIButton *)pwdForgottenBtn {
    if (!_pwdForgottenBtn) {
        _pwdForgottenBtn = [UIButton new];
        [_pwdForgottenBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_pwdForgottenBtn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
        [_pwdForgottenBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        [_pwdForgottenBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateDisabled];
    }
    return _pwdForgottenBtn;
}

- (UIButton *)pwdSavingBtn {
    if (!_pwdSavingBtn) {
        _pwdSavingBtn = [UIButton new];
        [_pwdSavingBtn setTitle:[NSString fontAwesomeIconStringForEnum:FACheckCircle] forState:UIControlStateNormal];
        [_pwdSavingBtn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
        [_pwdSavingBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        [_pwdSavingBtn addTarget:self action:@selector(clickedSavingPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdSavingBtn;
}

- (UILabel *)pwdSavingLabel {
    if (!_pwdSavingLabel) {
        _pwdSavingLabel = [UILabel new];
        _pwdSavingLabel.text = @"保存密码";
        _pwdSavingLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
        _pwdSavingLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _pwdSavingLabel;
}

- (UIButton *)visiblePwdSeenBtn {
    if (!_visiblePwdSeenBtn) {
        _visiblePwdSeenBtn = [UIButton new];
        [_visiblePwdSeenBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAEye] forState:UIControlStateNormal];
        [_visiblePwdSeenBtn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
        [_visiblePwdSeenBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        [_visiblePwdSeenBtn addTarget:self action:@selector(clickedPwdSeenBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _visiblePwdSeenBtn;
}

@end
