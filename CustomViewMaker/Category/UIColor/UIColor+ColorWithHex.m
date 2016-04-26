//
//  UIColor+ColorWithHex.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/11.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "UIColor+ColorWithHex.h"

@implementation UIColor (ColorWithHex)

+ (UIColor*) colorWithHex:(NSInteger)hexInt {
    NSInteger red = (hexInt & 0xff0000) >> 16;
    NSInteger green = (hexInt & 0x00ff00) >> 8;
    NSInteger blue = hexInt & 0x0000ff;
    NSLog(@"red[%ld],green[%ld],blue[%ld]",red,green,blue);
    return [UIColor colorWithRed:(CGFloat)red/(CGFloat)0xff green:(CGFloat)green/(CGFloat)0xff blue:(CGFloat)blue/(CGFloat)0xff alpha:1];
}

@end
