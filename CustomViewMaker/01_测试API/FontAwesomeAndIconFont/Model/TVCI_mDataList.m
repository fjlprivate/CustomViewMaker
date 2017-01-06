//
//  TVCI_mDataList.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_mDataList.h"
#import "PublicHeader.h"


@interface TVCI_mDataList()

@property (nonatomic, strong) NSDictionary* iconFontDic;

@property (nonatomic, assign) CGFloat fontSize;

@end



@implementation TVCI_mDataList

- (instancetype)init {
    self = [super init];
    if (self) {
        self.fontSize = 20;
    }
    return self;
}


- (NSArray<TVCI_mNodeItems *> *)listAwesome {
    if (!_listAwesome) {
        _listAwesome = [NSArray array];
    }
    return _listAwesome;
}

- (NSArray<TVCI_mNodeItems *> *)listIconFont {
    if (!_listIconFont) {
        NSMutableArray* iconItems = [NSMutableArray array];
        for (NSString* key in self.iconFontDic.allKeys) {
            [iconItems addObject:[TVCI_mIconFont fontWithName:key
                                                         type:[[self.iconFontDic objectForKey:key] integerValue]
                                                     fontSize:self.fontSize]];
        }
        TVCI_mNodeItems* items1 = [TVCI_mNodeItems nodeItemsWithTitle:@"IconFont"
                                                                items:iconItems];
        _listIconFont = @[items1];
    }
    return _listIconFont;
}

- (NSDictionary *)iconFontDic {
    return @{@"IFTypeKeyboardHidden":@(IFTypeKeyboardHidden),
             @"IFTypeDownTri":@(IFTypeDownTri),
             @"IFTypeBackspace":@(IFTypeBackspace),
             @"IFTypeExchange":@(IFTypeExchange),
             @"IFTypeRightLine":@(IFTypeRightLine),
             @"IFTypeRightTri":@(IFTypeRightTri),
             @"IFTypeUnlock":@(IFTypeUnlock),
             @"IFTypeCardBag":@(IFTypeCardBag),
             @"IFTypeChainBreak":@(IFTypeChainBreak),
             @"IFTypeShop":@(IFTypeShop) };
}


@end
