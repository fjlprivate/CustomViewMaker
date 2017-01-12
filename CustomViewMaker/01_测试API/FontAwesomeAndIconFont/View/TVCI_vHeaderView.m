//
//  TVCI_vHeaderView.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_vHeaderView.h"
#import "PublicHeader.h"

@implementation TVCI_vHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleBtn];
        CGRect inframe = frame;
        inframe.size.height = 35;
        inframe.size.width = frame.size.width * 0.45;
        inframe.origin.y = (frame.size.height - inframe.size.height) * 0.5;
        inframe.origin.x = (frame.size.width - inframe.size.width) * 0.5;
        self.titleBtn.frame = inframe;
        self.titleBtn.layer.cornerRadius = inframe.size.height * 0.5;
        self.backgroundColor = [UIColor colorWithHex:0x27384b alpha:1];
    }
    return self;
}



# pragma mask 4 getter

- (MLIconButtonR *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [MLIconButtonR new];
        [_titleBtn setTitleColor:[UIColor colorWithHex:0xf4ea2a alpha:1] forState:UIControlStateNormal];
        [_titleBtn setTitleColor:[UIColor colorWithHex:0xf4ea2a alpha:0.5] forState:UIControlStateHighlighted];
        _titleBtn.rightIconLabel.textColor = [UIColor colorWithHex:0xf4ea2a alpha:1];
        _titleBtn.backgroundColor = [UIColor colorWithHex:0xf4ea2a alpha:0];
        _titleBtn.rightIconLabel.text = [NSString fontAwesomeIconStringForEnum:FACaretDown];
        _titleBtn.rightIconLabel.font = [UIFont fontAwesomeFontOfSize:14];
        _titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    return _titleBtn;
}

@end
