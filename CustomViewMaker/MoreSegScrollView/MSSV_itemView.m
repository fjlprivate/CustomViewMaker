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

@implementation MSSV_itemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
        
        
//        [self setNeedsUpdateConstraints];
//        [self updateFocusIfNeeded];
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
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(wself.mas_centerY);
        make.height.mas_equalTo(wself.mas_height).multipliedBy(0.45);
        make.width.mas_equalTo(wself.imageView.mas_height);
        make.right.mas_equalTo(wself.titleLabel.mas_centerY).offset(- ([wself.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:wself.titleLabel.font}].width * 0.5 + 4));
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
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
