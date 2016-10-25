//
//  IconFont_dataSourceFilter.h
//  CustomViewMaker
//
//  Created by jielian on 2016/10/25.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconFont_dataSourceFilter : NSObject



@property (nonatomic, strong) NSArray* keyTitleList;

@property (nonatomic, strong) NSArray* iconfontList;



/* 分组字头组 */
+ (NSArray*) keySingleWordList;

/* 分组组数 */
+ (NSInteger) numberOfSeperatedArray;

/* 分组二维数组 */
+ (NSArray<NSArray*>*) twoDimentionalArrayOfIconTypeList;

@end
