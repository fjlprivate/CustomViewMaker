//
//  LMVC_logoutButton.m
//  CustomViewMaker
//
//  Created by jielian on 16/10/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "LMVC_logoutButton.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "NSString+Custom.h"


@implementation LMVC_logoutButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (void) loadSubviews {
    [self addSubview:self.iconLabel];
    [self addSubview:self.logoutBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    self.iconLabel.frame = frame;
    self.iconLabel.transform = CGAffineTransformMakeRotation(M_PI);
    
    frame.origin.x += frame.size.width;
    frame.size.width = self.frame.size.width - frame.size.width;
    self.logoutBtn.frame = frame;
}


# pragma mask 4 getter

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [UILabel new];
        _iconLabel.textColor = [UIColor whiteColor];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.text = [NSString fontAwesomeIconStringForEnum:FASignOut];
        _iconLabel.font = [UIFont fontAwesomeFontOfSize:17];
    }
    return _iconLabel;
}

- (UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [[UIButton alloc] init];
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        _logoutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _logoutBtn;
}


@end
