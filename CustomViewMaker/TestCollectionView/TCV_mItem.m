//
//  TCV_mItem.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/7.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TCV_mItem.h"

@implementation TCV_mItem

- (instancetype)initWithBackColor:(UIColor *)backColor text:(NSString *)text textColor:(UIColor *)textColor
{
    self = [super init];
    if (self) {
        self.backColor = backColor;
        self.textColor = textColor;
        self.text = text;
    }
    return self;
}


@end
