//
//  ZFJF_vHeaderView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/6.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_vHeaderView.h"
#import "PublicHeader.h"





@implementation ZFJF_vHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0x12c4a3 alpha:1];
        [self loadSubviews];
    }
    return  self;
}


- (void) loadSubviews {
    [self addSubview:self.btnBitCode];
    [self addSubview:self.btnPayCode];
    [self addSubview:self.btnQRCode];
    [self addSubview:self.noteLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NameWeakSelf(wself);
    [self.btnBitCode mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(wself.btnPayCode.mas_width);
    }];
    
    [self.btnPayCode mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.btnBitCode.mas_right);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(wself.btnQRCode.mas_width);
    }];
    
    [self.btnQRCode mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.btnPayCode.mas_right);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [self.noteLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(ScreenWidth * 24 / 320.f);
    }];

}




# pragma mask 4 getter

- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [UILabel new];
        _noteLabel.textColor = [UIColor whiteColor];
        _noteLabel.text = @"支持T+1余额查询与T+0余额查询!";
        _noteLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        _noteLabel.font = [UIFont systemFontOfSize:13];
    }
    return _noteLabel;
}


- (ZFJF_vBtnItem *)btnBitCode {
    if (!_btnBitCode) {
        _btnBitCode = [[ZFJF_vBtnItem alloc] init];
        _btnBitCode.iconImgView.image = [UIImage imageNamed:@"bitcode_white"];
        _btnBitCode.iconTitleLabel.text = @"扫一扫";
    }
    return _btnBitCode;
}

- (ZFJF_vBtnItem *)btnPayCode {
    if (!_btnPayCode) {
        _btnPayCode = [[ZFJF_vBtnItem alloc] init];
        _btnPayCode.iconImgView.image = [UIImage imageNamed:@"pay_white"];
        _btnPayCode.iconTitleLabel.text = @"付款";
    }
    return _btnPayCode;
}

- (ZFJF_vBtnItem *)btnQRCode {
    if (!_btnQRCode) {
        _btnQRCode = [[ZFJF_vBtnItem alloc] init];
        _btnQRCode.iconImgView.image = [UIImage imageNamed:@"QRCode_white"];
        _btnQRCode.iconTitleLabel.text = @"二维码";
    }
    return _btnQRCode;
}


@end
