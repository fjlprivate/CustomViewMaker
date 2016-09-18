//
//  TriSegView_cell.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/13.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TriSegView_cell.h"
#import "NSString+Custom.h"
#import "Masonry.h"



@implementation TriSegView_cell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"-------------cell 的初始化: initWithFrame");
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.titleLabel];

        [self makeConstraints];
//        [self setNeedsUpdateConstraints];
//        [self updateConstraintsIfNeeded];

    }
    return self;
}




- (void)layoutSubviews {
    [super layoutSubviews];
}

//- (void)updateConstraints {
//    NSLog(@"----------- 开始更新[%@]约束:, frame[%@]",self, NSStringFromCGRect(self.contentView.bounds));
//    
//    __weak typeof(self) wself = self;
//    
//    [self.iconImgView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(wself.contentView.mas_centerX).multipliedBy(1.f/3.f);
//        make.centerY.mas_equalTo(wself.contentView.mas_centerY);
//        make.height.mas_equalTo(wself.contentView.mas_height).multipliedBy(0.45);
//        make.width.mas_equalTo(wself.iconImgView.mas_height);
//        
//    }];
//    
//    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(wself.iconImgView.mas_right).offset(5);
//        make.top.bottom.mas_equalTo(wself.iconImgView);
//        make.right.mas_equalTo(0);
//    }];
//    
//    [super updateConstraints];
//}


- (void) makeConstraints {
    __weak typeof(self) wself = self;
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.contentView.mas_centerX).multipliedBy(1.f/3.f);
        make.centerY.mas_equalTo(wself.contentView.mas_centerY);
        make.height.mas_equalTo(wself.contentView.mas_height).multipliedBy(0.35);
        make.width.mas_equalTo(wself.iconImgView.mas_height);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.iconImgView.mas_right).offset(5);
        make.top.bottom.mas_equalTo(wself.iconImgView);
        make.right.mas_equalTo(0);
    }];
}



# pragma mask 4 getter

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _iconImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}



@end
