//
//  NSString+IconFont.m
//  JLPay
//
//  Created by jielian on 16/6/17.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "NSString+IconFont.h"

@implementation NSString (IconFont)

/* 生成字体库文字 */
+ (NSString*) stringWithIconType:(IFType)icontype {
    return [[self iconfontDictionaryList] objectForKey:@(icontype)];
}

+ (NSDictionary*) iconfontDictionaryList {
    return @{
             /* -- update -- */
             @(IFTypeAlipay)            :@"\ue631",
             @(IFTypeWechatPay)         :@"\ue62a",
             @(IFTypeWechat)            :@"\ue62b",
             @(IFTypeNoData)            :@"\ue91a",
             @(IFTypeKeyboardHidden)    :@"\ue6fb",
             @(IFTypeDownTri)           :@"\ue646",
             @(IFTypeBackspace)         :@"\ue666",
             @(IFTypeExchange)          :@"\ue749",
             @(IFTypeRightLine)         :@"\ue667",
             @(IFTypeRightTri)          :@"\ue9c6",
             @(IFTypeUnlock)            :@"\ue62f",
             @(IFTypeCardBag)           :@"\ue611",
             @(IFTypeChainBreak)        :@"\ue609",
             @(IFTypeShop)              :@"\ue6b4"
             };
}




@end
