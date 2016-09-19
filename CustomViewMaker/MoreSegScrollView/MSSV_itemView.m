//
//  MSSV_itemView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/18.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MSSV_itemView.h"
#import "Masonry.h"
#import "NSString+Custom.h"
#import <ReactiveCocoa.h>


@implementation MSSV_itemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void) loadSubviews {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}


- (void)updateConstraints {
    __weak typeof(self) wself = self;
    
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(wself.mas_height).multipliedBy(0.3);
        make.width.mas_equalTo(wself.imageView.mas_height);
        make.centerY.mas_equalTo(wself.mas_centerY);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.imageView.mas_right).offset(8);
        make.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(wself.imageView);
    }];
    
    
    [super updateConstraints];
}



# pragma mask 4 getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

@end
