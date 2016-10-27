//
//  IconFont_dataSourceFilter.h
//  CustomViewMaker
//
//  Created by jielian on 2016/10/25.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconFont_dataSourceFilter : NSObject


/* 过滤的关键字 */
@property (nonatomic, copy) NSString* filterKey;

/* 数据源组 */
@property (nonatomic, strong) NSArray<NSArray*>* iconfontList;

/* 标题组 */
@property (nonatomic, strong) NSArray* keyTitleList;



@end
