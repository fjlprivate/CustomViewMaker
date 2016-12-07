//
//  CustomFlowLayout.h
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFlowLayout : UICollectionViewLayout

- (instancetype) initWithColumnCount:(NSInteger)columnCount
                       allItemsCount:(NSInteger)itemsCount;


@end
