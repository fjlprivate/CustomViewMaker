//
//  ZFJF_mMainVCCellItem.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/2.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_mMainVCCellItem.h"

@implementation ZFJF_mMainVCCellItem

- (instancetype)initWithImgName:(NSString *)imgName title:(NSString *)title {
    self = [super init];
    if (self) {
        self.imageName = imgName;
        self.itemTitle = title;
    }
    return self;
}


@end
