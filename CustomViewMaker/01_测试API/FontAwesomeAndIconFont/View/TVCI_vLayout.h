//
//  TVCI_vLayout.h
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCI_vLayout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger numberOfColumns;

@property (nonatomic, assign) NSInteger numberOfSections;

@property (nonatomic, copy) NSArray* numbersOfItemsPerSec;

@property (nonatomic, copy) NSArray* heightsOfHeaderViews;

@property (nonatomic, assign) CGSize itemSize;


@property (nonatomic, assign) NSInteger numberOfAllItems;

@end
