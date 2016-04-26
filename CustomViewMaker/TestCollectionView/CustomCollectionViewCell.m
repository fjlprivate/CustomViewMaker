//
//  CustomCollectionViewCell.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "CustomCollectionViewCell.h"


@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    
    self.label.frame = frame;
}

#pragma mask 4 getter
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}

@end
