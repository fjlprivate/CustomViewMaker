//
//  IconFontHeaderView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/10/25.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "IconFontHeaderView.h"
#import "UIColor+ColorWithHex.h"


@implementation IconFontHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 0, self.frame.size.width - 15, self.frame.size.height);
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLabel;
}


@end
