//
//  TVCI_vCell.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/5.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_vCell.h"
#import "PublicHeader.h"



@interface TVCI_vCell()


@end



@implementation TVCI_vCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHex:0xf4ea2a alpha:1];
        self.contentView.layer.cornerRadius = frame.size.width * 0.1;
        [self loadSubviews];
    }
    return self;
}


- (void) loadSubviews {
    [self.contentView addSubview:self.iconLabel];
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat inset = ScreenWidth * 3/320.f;
    
    CGRect frame = self.frame;
    
    frame.origin.x = inset;
    frame.origin.y = inset * 2;
    frame.size.width -= inset * 2;
    frame.size.height -= inset * 2;
    self.contentView.frame = frame;
    
    CGRect inframe = frame;
    inframe.size.width = frame.size.width * 0.3;
    inframe.size.height = inframe.size.width;
    inframe.origin.x = (frame.size.width - inframe.size.width) / 2;
    inframe.origin.y = (frame.size.height - inframe.size.height) * (1 - 0.618);
    self.iconLabel.frame = inframe;
    self.iconLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:inframe.size.height scale:1]];

    inframe.origin.x = inset * 3;
    inframe.origin.y += inframe.size.height + inset;
    inframe.size.width = frame.size.width - inset * 3 * 2;
    inframe.size.height = frame.size.height - inframe.origin.y - inset;
    self.titleLabel.frame = inframe;
    
}


# pragma mask 4 getter

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [UILabel new];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
    }
    return _iconLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel ) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        _titleLabel.font = [UIFont boldSystemFontOfSize:9];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}


@end
