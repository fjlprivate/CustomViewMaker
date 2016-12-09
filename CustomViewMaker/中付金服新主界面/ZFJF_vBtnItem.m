//
//  ZFJF_vBtnItem.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_vBtnItem.h"
#import "PublicHeader.h"


@implementation ZFJF_vBtnItem


- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubviews];
    }
    return self;
}


- (void) loadSubviews {
    [self addSubview:self.iconImgView];
    [self addSubview:self.iconTitleLabel];
}

- (void)updateConstraints {
    
    NameWeakSelf(wself);
    [self.iconImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.mas_centerX);
        make.centerY.mas_equalTo(wself.mas_centerY).offset(- ScreenWidth * 20 / 320.f);
        make.width.height.mas_equalTo(wself.mas_width).multipliedBy(0.45);
    }];
    
    [self.iconTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(wself.iconImgView.mas_bottom).offset(5);
        make.height.mas_equalTo(ScreenWidth * 24 / 320.f);
    }];
    
    [super updateConstraints];
}

# pragma mask 4 getter

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
    }
    return _iconImgView;
}

- (UILabel *)iconTitleLabel {
    if (!_iconTitleLabel) {
        _iconTitleLabel = [UILabel new];
        _iconTitleLabel.textColor = [UIColor whiteColor];
        _iconTitleLabel.textAlignment = NSTextAlignmentCenter;
        _iconTitleLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    return _iconTitleLabel;
}


@end
