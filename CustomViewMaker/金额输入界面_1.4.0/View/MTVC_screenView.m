//
//  MTVC_screenView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MTVC_screenView.h"
#import "Masonry.h"
#import "NSString+Custom.h"
#import <ReactiveCocoa.h>
#import <UIFont+FontAwesome.h>


@interface MTVC_screenView()

@end

@implementation MTVC_screenView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubviews];
        [self addKVOs];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
        [self addKVOs];
    }
    return self;
}

- (void) loadSubviews {
    [self addSubview:self.moneyLabel];
    [self addSubview:self.settleTypeLabel];
    [self addSubview:self.businessLabel];
    [self addSubview:self.deviceLinkedStateLabel];
    [self addSubview:self.deviceConnectBtn];
}

- (void) addKVOs {
    @weakify(self);
    [RACObserve(self.businessLabel, text) subscribeNext:^(id x) {
        @strongify(self);
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        [self layoutIfNeeded];
    }];
    
    [RACObserve(self, deviceCBtnTitle) subscribeNext:^(id x) {
        @strongify(self);
        [self.deviceConnectBtn setTitle:x forState:UIControlStateNormal];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        [self layoutIfNeeded];
    }];
}


- (void)updateConstraints {
    
    self.moneyLabel.font = [UIFont boldSystemFontOfSize:[@"test" resizeFontAtHeight:40 scale:1]];

    self.settleTypeLabel.layer.masksToBounds = YES;
    self.settleTypeLabel.layer.cornerRadius = 10;
    self.settleTypeLabel.font = [UIFont boldSystemFontOfSize:[@"test" resizeFontAtHeight:20 scale:0.7]];

    self.businessLabel.font = [UIFont boldSystemFontOfSize:[@"test" resizeFontAtHeight:20 scale:0.7]];
    UIFont* maxTextFont = [UIFont boldSystemFontOfSize:[@"test" resizeFontAtHeight:20 scale:1]];

    self.deviceLinkedStateLabel.font = [UIFont fontAwesomeFontOfSize:[@"tet" resizeFontAtHeight:20 scale:1]];
    self.deviceConnectBtn.titleLabel.font = [UIFont boldSystemFontOfSize:[@"test" resizeFontAtHeight:20 scale:0.7]];
    __weak typeof(self) wself = self;
    
    
    [self.moneyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(wself.mas_centerY);
        make.height.mas_equalTo(30);
    }];
    
    [self.settleTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(52);
    }];
    
    [self.businessLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.settleTypeLabel.mas_right).offset(10);
        make.top.bottom.mas_equalTo(wself.settleTypeLabel);
        make.width.mas_equalTo([wself.businessLabel.text sizeWithAttributes:@{NSFontAttributeName:maxTextFont}].width);
    }];
    
    [self.businessSwitchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.businessLabel.mas_right).offset(0);
        make.top.bottom.mas_equalTo(wself.businessLabel);
        make.width.mas_equalTo(wself.businessSwitchBtn.mas_height);
    }];
    
    [self.deviceLinkedStateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(20);
        make.bottom.mas_equalTo(- 15);
    }];
    
    [self.deviceConnectBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.deviceLinkedStateLabel.mas_right).offset(0);
        make.top.bottom.mas_equalTo(wself.deviceLinkedStateLabel);
        make.width.mas_equalTo([wself.deviceCBtnTitle resizeAtHeight:20 scale:0.8].width);
    }];
    
    [super updateConstraints];
}





# pragma mask 4 getter

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}

- (UILabel *)settleTypeLabel {
    if (!_settleTypeLabel) {
        _settleTypeLabel = [UILabel new];
        _settleTypeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _settleTypeLabel;
}

- (UILabel *)businessLabel {
    if (!_businessLabel) {
        _businessLabel = [UILabel new];
    }
    return _businessLabel;
}

- (UILabel *)deviceLinkedStateLabel {
    if (!_deviceLinkedStateLabel) {
        _deviceLinkedStateLabel = [UILabel new];
        _deviceLinkedStateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _deviceLinkedStateLabel;
}

- (UIButton *)deviceConnectBtn {
    if (!_deviceConnectBtn) {
        _deviceConnectBtn = [UIButton new];
        [_deviceConnectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_deviceConnectBtn setTitleColor:[UIColor colorWithWhite:0.2 alpha:0.3] forState:UIControlStateHighlighted];
    }
    return _deviceConnectBtn;
}

@end
