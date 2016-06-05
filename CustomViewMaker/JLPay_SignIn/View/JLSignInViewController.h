//
//  JLSignInViewController.h
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/5/31.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "NSString+Custom.h"
#import "UIColor+ColorWithHex.h"
#import "Masonry.h"

@interface JLSignInViewController : UIViewController

@property (nonatomic, strong) UIButton* backVCBarBtn;           // 仅用于测试

@property (nonatomic, strong) UIImageView* backgroundImgView;   // 背景

@property (nonatomic, strong) UIImageView* logoImgView;         // logo

@property (nonatomic, strong) UILabel* headLabel;               // 头像
@property (nonatomic, strong) UILabel* lockLabel;               // 密码锁
@property (nonatomic, strong) UITextField* userTextField;       // 用户名
@property (nonatomic, strong) UITextField* pwdTextField;        // 密码

@property (nonatomic, strong) UIButton* pwdForgottenBtn;        // 忘记密码
@property (nonatomic, strong) UIButton* pwdSavingBtn;           // 保存密码-按钮
@property (nonatomic, strong) UILabel* pwdSavingLabel;          // 保存密码-标签

@property (nonatomic, strong) UIButton* visiblePwdSeenBtn;      // 密码可见

@property (nonatomic, strong) UIButton* signInBtn;              // 登录
@property (nonatomic, strong) UIButton* signUpBtn;              // 注册

@property (nonatomic, strong) UIView* separateViewLeft;         // 分割线-left
@property (nonatomic, strong) UIView* separateViewRight;        // 分割线-right

@end
