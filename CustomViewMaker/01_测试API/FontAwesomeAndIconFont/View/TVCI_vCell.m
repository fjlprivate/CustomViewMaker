//
//  TVCI_vCell.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/5.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_vCell.h"
#import "PublicHeader.h"



@interface TVCI_vCell()


@end



@implementation TVCI_vCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10.f;
        [self loadSubviews];
    }
    return self;
}


- (void) loadSubviews {
    [self.contentView addSubview:self.iconLabel];
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NameWeakSelf(wself);
    CGFloat inset = ScreenWidth * 3/320.f;
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(inset, inset, inset, inset));
    }];
    
    [self.iconLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.contentView.mas_centerX);
        make.centerY.mas_equalTo(wself.contentView.mas_centerY).offset(- inset * 3);
        make.width.height.mas_equalTo(wself.contentView.mas_width).multipliedBy(0.35);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.iconLabel.mas_bottom);
        make.height.mas_equalTo(wself.iconLabel.mas_height).multipliedBy(0.5);
        make.left.right.mas_equalTo(0);
    }];
    
    self.iconLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:self.frame.size.height scale:0.3]];
}


# pragma mask 4 getter

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [UILabel new];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
    }
    return _iconLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel ) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    return _titleLabel;
}


@end
