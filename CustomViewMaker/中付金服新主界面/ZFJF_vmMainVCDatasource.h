//
//  ZFJF_vmMainVCDatasource.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/2.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZFJF_mMainVCCellItem.h"

@interface ZFJF_vmMainVCDatasource : NSObject
<UICollectionViewDataSource>


+ (instancetype) mainDataSource;

/* 数据源组 */
@property (nonatomic, strong) NSArray<ZFJF_mMainVCCellItem*>* items;

/* 列数 */
@property (nonatomic, assign) NSInteger numberOfColumns;

@end
