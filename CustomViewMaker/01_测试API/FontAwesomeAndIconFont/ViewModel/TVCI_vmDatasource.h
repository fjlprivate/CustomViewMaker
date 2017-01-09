//
//  TVCI_vmDatasource.h
//  CustomViewMaker
//
//  Created by jielian on 2017/1/5.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TVCI_mDataList.h"


@interface TVCI_vmDatasource : NSObject <UICollectionViewDataSource, UIScrollViewDelegate>


/* 格数: */
@property (nonatomic, assign) NSInteger numberOfSections;

/* 数组: 每格的items个数 */
@property (nonatomic, copy) NSArray* numbersOfItemsPerSec;

/* 数组: 每个头视图的高度 */
@property (nonatomic, copy) NSArray* heightsOfHeaderViews;





@property (nonatomic, assign) NSInteger curFontIndex;

@property (nonatomic, strong) NSArray* fontTypes;






- (NSString*) curFontType;

@end
