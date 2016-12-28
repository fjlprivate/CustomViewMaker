//
//  TLVC_vHeadView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/26.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TLVC_vHeadView.h"
#import "PublicHeader.h"



@implementation TLVC_vHeadView


# pragma mask 3 布局和初始化

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialDatas];
        [self loadSubviews];
        [self addKVO];
    }
    return self;
}


- (void) addKVO {
    RAC(self.stateLabel.layer, cornerRadius) = [RACObserve(self.stateLabel, bounds) map:^id(id value) {
        return @([value CGRectValue].size.height * 0.5);
    }];
}

- (void) initialDatas {
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void) loadSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.stateLabel];
    [self addSubview:self.spreadBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self makeMasonries];
}

- (void) makeMasonries {
    NameWeakSelf(wself);
    CGFloat insetH = ScreenWidth * 15/320.f;
    CGFloat widthState = ScreenWidth * 40/320.f;
    [self.spreadBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(wself.spreadBtn.mas_height).multipliedBy(0.618);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.spreadBtn.mas_right);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(wself.stateLabel.mas_left);
    }];
    
    [self.stateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- insetH);
        make.width.mas_equalTo(widthState);
        make.centerY.mas_equalTo(wself.mas_centerY);
        make.height.mas_equalTo(wself.mas_height).multipliedBy(0.35);
    }];
    
}




# pragma mask 4 getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithHex:0x00a1dc alpha:1];
    }
    return _titleLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.font = [UIFont boldSystemFontOfSize:10];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.backgroundColor = [UIColor colorWithHex:0x00a1dc alpha:1];
        _stateLabel.textColor = [UIColor colorWithHex:0xffffff alpha:1];
        _stateLabel.layer.masksToBounds = YES;
    }
    return _stateLabel;
}

- (UIButton *)spreadBtn {
    if (!_spreadBtn) {
        _spreadBtn = [UIButton new];
        [_spreadBtn setTitle:[NSString fontAwesomeIconStringForEnum:FACaretDown] forState:UIControlStateNormal];
        _spreadBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:13];
        [_spreadBtn setTitleColor:[UIColor colorWithHex:0x00a1dc alpha:1] forState:UIControlStateNormal];
        [_spreadBtn setTitleColor:[UIColor colorWithHex:0x00a1dc alpha:0.5] forState:UIControlStateHighlighted];
    }
    return _spreadBtn;
}


@end
