//
//  NSString+Custom.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/12.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "NSString+Custom.h"

@implementation NSString (Custom)

// -- 重新计算字体大小:指定高度
- (CGFloat) resizeFontAtHeight:(CGFloat)height scale:(CGFloat)scale{
    CGFloat testFontSize = 20.f;
    CGSize oldTextSize = [self sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:testFontSize] forKey:NSFontAttributeName]];
    return (height/oldTextSize.height) * testFontSize * scale;
}

+ (CGFloat) resizeFontAtHeight:(CGFloat)height scale:(CGFloat)scale {
    CGFloat testFontSize = 20.f;
    CGSize oldTextSize = [@"sdsdf" sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:testFontSize] forKey:NSFontAttributeName]];
    return (height/oldTextSize.height) * testFontSize * scale;
}


- (CGSize) resizeAtHeight:(CGFloat)height scale:(CGFloat)scale{
    CGFloat newFontSize = [self resizeFontAtHeight:height scale:scale];
    CGSize size = [self sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:newFontSize] forKey:NSFontAttributeName]];
    size.height = height;
    return size;
}


#pragma mask : 编码相关
// -- ASC
- (NSString*) ASCIIString {
    NSMutableString* ascString = [NSMutableString string];
    NSData* ascData = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSString* mask = @"0123456789ABCDEF";
    Byte* ascBytes = (Byte*)[ascData bytes];
    for (int i = 0; i < [ascData length]; i++) {
        [ascString appendFormat:@"%c", (char)[mask characterAtIndex:(ascBytes[i] & 0xf0 >> 4)]];
        [ascString appendFormat:@"%c", (char)[mask characterAtIndex:(ascBytes[i] & 0x0f >> 0)]];
    }
    return ascString;
}


@end
