//
//  TVCI_vLayout.h
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCI_vLayout : UICollectionViewLayout

/* 列数: items */
@property (nonatomic, assign) NSInteger numberOfColumns;

/* 格数: */
@property (nonatomic, assign) NSInteger numberOfSections;

/* 数组: 每格的items个数 */
@property (nonatomic, copy) NSArray* numbersOfItemsPerSec;

/* 数组: 每个头视图的高度 */
@property (nonatomic, copy) NSArray* heightsOfHeaderViews;

/* 单元格大小 */
@property (nonatomic, assign) CGSize itemSize;

@end
