//
//  ZFJF_vmMainVCDatasource.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/2.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZFJF_mMainVCCellItem;
@interface ZFJF_vmMainVCDatasource : NSObject
<UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<ZFJF_mMainVCCellItem*>* items;


@end
