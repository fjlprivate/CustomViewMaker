//
//  FontAwesomeIconFontCell.m
//  CustomViewMaker
//
//  Created by jielian on 16/10/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "FontAwesomeIconFontCell.h"
#import "UIColor+ColorWithHex.h"
#import <UIFont+FontAwesome.h>
#import <NSString+FontAwesome.h>
#import "Masonry.h"



@implementation FontAwesomeIconFontCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.contentView.backgroundColor = [UIColor whiteColor];
    if (self) {
        [self.contentView addSubview:self.iconLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.indexLabel];
        
        CGFloat iconHeight = frame.size.height * 0.7;
        CGFloat titleHeight = frame.size.height * 0.2;
        CGFloat indexHeight = frame.size.height * 0.1;
        
        CGRect newFrame = CGRectMake(0, 0, frame.size.width, iconHeight);
        self.iconLabel.frame = newFrame;
        
        newFrame.origin.y += newFrame.size.height;
        newFrame.size.height = titleHeight;
        self.titleLabel.frame = newFrame;
        
        newFrame.origin.y += newFrame.size.height;
        newFrame.size.height = indexHeight;
        self.indexLabel.frame = newFrame;
        
    }
    return self;
}




# pragma mask 4 getter

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [UILabel new];
        _iconLabel.textColor = [UIColor colorWithHex:0x27384b];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.font = [UIFont fontAwesomeFontOfSize:22];
    }
    return _iconLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.textColor = [UIColor grayColor];
        _indexLabel.font = [UIFont systemFontOfSize:8];
    }
    return _indexLabel;
}


@end
