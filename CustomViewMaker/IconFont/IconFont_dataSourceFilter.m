//
//  IconFont_dataSourceFilter.m
//  CustomViewMaker
//
//  Created by jielian on 2016/10/25.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "IconFont_dataSourceFilter.h"
#import "ModelFontAwesomeType.h"
#import "MFontAwesomeNode.h"


@implementation IconFont_dataSourceFilter


# pragma  mask getter

- (NSArray *)keyTitleList {
    if (!_keyTitleList) {
        _keyTitleList = [IconFont_dataSourceFilter keySingleWordList];
    }
    return _keyTitleList;
}

- (NSArray *)iconfontList {
    if (!_iconfontList) {
        _iconfontList = [IconFont_dataSourceFilter twoDimentionalArrayOfIconTypeList];
    }
    return _iconfontList;
}



/* 分组字头组 */
+ (NSArray*) keySingleWordList {
    
    
    NSArray* originIconTypes = [NSArray arrayWithArray:[ModelFontAwesomeType fontAwesomeNameAndKeyList]];
    NSMutableArray* keyStrings = [NSMutableArray array];
    for (char c = 'A'; c <= 'Z'; c++) {
        NSString* format = [NSString stringWithFormat:@"name LIKE[c] 'FA%c*'", c];
        NSPredicate* predFilter = [NSPredicate predicateWithFormat:format];
        NSArray* subArrayFilteredByChar = [originIconTypes filteredArrayUsingPredicate:predFilter];
        //NSLog(@"---过滤[%c]组的结果[%@]", c, subArrayFilteredByChar);
        if (subArrayFilteredByChar && subArrayFilteredByChar.count > 0) {
            [keyStrings addObject:[NSString stringWithFormat:@"%c", c]];
        }
    }
    
    return keyStrings;
}

/* 分组组数 */
+ (NSInteger) numberOfSeperatedArray {
    return [[self keySingleWordList] count];
}

/* 分组二维数组 */
+ (NSArray<NSArray*>*) twoDimentionalArrayOfIconTypeList {
    NSArray* originIconTypes = [ModelFontAwesomeType fontAwesomeNameAndKeyList];
    NSMutableArray* allIconTypeList = [NSMutableArray array];
    for (NSString* key in [self keySingleWordList]) {
        NSString* format = [NSString stringWithFormat:@"name LIKE[c] 'FA%@*'", key];
        NSPredicate* predFilter = [NSPredicate predicateWithFormat:format];
        NSArray* subArrayFilteredByChar = [originIconTypes filteredArrayUsingPredicate:predFilter];
        if (subArrayFilteredByChar && subArrayFilteredByChar.count > 0) {
            [allIconTypeList addObject:subArrayFilteredByChar];
        }
    }
    return allIconTypeList;
}



@end
