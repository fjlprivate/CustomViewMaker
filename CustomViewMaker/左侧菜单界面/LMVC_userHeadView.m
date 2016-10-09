//
//  LMVC_userHeadView.m
//  CustomViewMaker
//
//  Created by jielian on 16/10/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "LMVC_userHeadView.h"
#import "UIColor+ColorWithHex.h"
#import "NSString+Custom.h"


@implementation LMVC_userHeadView


# pragma mask 3 初始化和布局

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (void) loadSubviews {
    [self addSubview:self.headImgView];
    [self addSubview:self.busiNameLabel];
    [self addSubview:self.busiNumLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat heightImgView = self.frame.size.height;
    CGFloat hBusiNameLabel = self.frame.size.height * 0.3;
    CGFloat hBusiNumLabel = self.frame.size.height * 0.25;
    
    CGFloat inset = 8;
    CGFloat wLabel = self.frame.size.width - heightImgView - inset;
    
    CGRect frame = CGRectMake(0, 0, heightImgView, heightImgView);
    self.headImgView.frame = frame;
    
    frame.origin.x += frame.size.width + inset;
    frame.origin.y = self.frame.size.height * 0.5 - hBusiNameLabel - inset * 0.25;
    frame.size.width = wLabel;
    frame.size.height = hBusiNameLabel;
    self.busiNameLabel.frame = frame;
    
    frame.origin.y = self.frame.size.height * 0.5 + inset * 0.25;
    frame.size.height = hBusiNumLabel;
    self.busiNumLabel.frame = frame;
    
    self.busiNameLabel.font = [UIFont boldSystemFontOfSize:[@"ss" resizeFontAtHeight:hBusiNameLabel scale:1]];
    self.busiNumLabel.font = [UIFont systemFontOfSize:[@"ss" resizeFontAtHeight:hBusiNumLabel scale:1]];
}




# pragma mask 4 getter

- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userHeadGray"]];
    }
    return _headImgView;
}

- (UILabel *)busiNameLabel {
    if (!_busiNameLabel) {
        _busiNameLabel = [UILabel new];
        _busiNameLabel.textColor = [UIColor colorWithHex:0x27384b];
    }
    return _busiNameLabel;
}

- (UILabel *)busiNumLabel {
    if (!_busiNumLabel) {
        _busiNumLabel = [UILabel new];
        _busiNumLabel.textColor = [UIColor colorWithHex:0xcccccc];
    }
    return _busiNumLabel;
}

@end
