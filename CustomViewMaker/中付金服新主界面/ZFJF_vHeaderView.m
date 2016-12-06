//
//  ZFJF_vHeaderView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/6.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_vHeaderView.h"
#import "UIColor+ColorWithHex.h"

@implementation ZFJF_vHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0x12c4a3 alpha:1];
    }
    return  self;
}


@end
