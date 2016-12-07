//
//  TCV_vmDataSource.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/7.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TCV_mItem.h"


@interface TCV_vmDataSource : NSObject
<UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<TCV_mItem*>* items;

@end
