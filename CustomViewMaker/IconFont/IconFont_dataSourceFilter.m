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
#import <ReactiveCocoa.h>



@interface IconFont_dataSourceFilter()

/* 原始的分组 */
@property (nonatomic, strong) NSArray* originIconfontsSeperatedArray;



@end


@implementation IconFont_dataSourceFilter



- (void) addKVO {
    @weakify(self);
    
    /* 监控: 过滤条件 */
    [[RACObserve(self, filterKey) delay:0.3] subscribeNext:^(NSString* key) {
        @strongify(self);
        if (key && key.length > 0) {
            self.iconfontList = [self iconfontListFilteredWithKey:key];
        } else {
            if (self.iconfontList != self.originIconfontsSeperatedArray) {
                self.iconfontList = self.originIconfontsSeperatedArray;
            }
        }
    }];
    
    /* 绑定: 更新了过滤数组，就要更新对应的标题组 */
    RAC(self, keyTitleList) = [RACObserve(self, iconfontList) map:^id(NSArray* iconfontList) {
        
        NSMutableArray* keyList = [NSMutableArray array];
        for (NSArray* nodeList in iconfontList) {
            MFontAwesomeNode* node = [nodeList firstObject];
            NSString* key = [node.name substringWithRange:NSMakeRange(2, 1)];
            char cKey = [key characterAtIndex:0];
            cKey = (cKey >= 'A' && cKey <= 'Z') ? cKey : cKey - 'a' + 'A';
            [keyList addObject:[NSString stringWithFormat:@"%c", cKey]];
        }
        return keyList;
    }];
    
}


/* 根据关键字过滤出匹配的数组 */
- (NSArray* ) iconfontListFilteredWithKey:(NSString*) key {
    NSArray* iconfontNameAndKeyList = [ModelFontAwesomeType fontAwesomeNameAndKeyList];

    NSString* format = [NSString stringWithFormat:@"name CONTAINS[c] '%@'", key];
    
    NSArray* filterArray = [iconfontNameAndKeyList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:format]];

    if (filterArray && filterArray.count > 0) {
        return [self seperatedWithIconfontList:filterArray];
    }
    
    return nil;
}


- (NSArray*) seperatedWithIconfontList:(NSArray*)iconfontList {
    NSMutableArray* seperatedIconfontList = [NSMutableArray array];
    
    for (char c = 'A'; c <= 'Z'; c++) {
        
        NSString* format = [NSString stringWithFormat:@"name BEGINSWITH[c] 'FA%c'", c];
        NSArray* filteredArray = [iconfontList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:format]];
        if (filteredArray && filteredArray.count > 0) {
            [seperatedIconfontList addObject:filteredArray];
        }
    }
    return seperatedIconfontList;
}


# pragma mask 4 初始化

- (instancetype)init {
    self = [super init];
    if (self) {
        [self makeOriginDatas];
        [self addKVO];
    }
    return self;
}


- (void) makeOriginDatas {
    _originIconfontsSeperatedArray = [self seperatedWithIconfontList:[ModelFontAwesomeType fontAwesomeNameAndKeyList]];
}


@end
