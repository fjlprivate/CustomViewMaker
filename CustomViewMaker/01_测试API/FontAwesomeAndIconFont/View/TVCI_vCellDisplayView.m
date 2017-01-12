//
//  TVCI_vCellDisplayView.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/12.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_vCellDisplayView.h"
#import "PublicHeader.h"


@implementation TVCI_vCellDisplayView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.cancelBtn];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    CGFloat inset = ScreenWidth * 15/320.f;
//    CGFloat height = ScreenWidth * 30/320.f;
//    
//    NameWeakSelf(wself);
//    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(inset);
//        make.right.mas_equalTo(-inset);
//        make.width.height.mas_equalTo(height);
//    }];
//    
//}



# pragma mask 4 getter
//- (UIButton *)cancelBtn {
//    if (!_cancelBtn) {
//        _cancelBtn = [UIButton new];
//        [_cancelBtn setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateNormal];
//        _cancelBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:20];
//        [_cancelBtn setTitleColor:[UIColor colorWithHex:0xf4ea2a alpha:1] forState:UIControlStateNormal];
//    }
//    return _cancelBtn;
//}


@end
