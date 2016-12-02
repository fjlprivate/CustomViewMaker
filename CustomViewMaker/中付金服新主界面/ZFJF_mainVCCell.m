//
//  ZFJF_mainVCCell.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/1.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_mainVCCell.h"
#import "UIColor+ColorWithHex.h"
#import "Masonry.h"
#import "PublicHeader.h"

@implementation ZFJF_mainVCCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.iconLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat centerYOffset = self.frame.size.height * (1 - 0.618);
    NameWeakSelf(wself);
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.contentView.mas_centerX);
        make.centerY.mas_equalTo(wself.contentView.mas_top).offset(centerYOffset);
        make.width.mas_equalTo(wself.contentView.mas_width).multipliedBy(0.25);
        make.height.mas_equalTo(wself.contentView.mas_height).multipliedBy(0.25);
    }];
    
    [self.iconLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(wself.iconImageView.mas_bottom);
        make.bottom.mas_equalTo(wself.contentView.mas_bottom);
    }];
    
}


# pragma mask 4 getter

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [UILabel new];
        _iconLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    return _iconLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

@end
