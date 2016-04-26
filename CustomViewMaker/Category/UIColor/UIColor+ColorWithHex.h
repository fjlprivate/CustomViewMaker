//
//  UIColor+ColorWithHex.h
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/11.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum {
    HexColorTypeLightPink       = 0xffb6c1, // 浅粉
    HexColorTypeIndigo          = 0x4b0082, // 紫兰
    HexColorTypeDarkSlateBlue   = 0x483d8b, // 暗板岩蓝
    HexColorTypeMidnightBlue    = 0x191970, // 午夜蓝
    HexColorTypeLightSlateGray  = 0x778899, // 亮石板灰
    HexColorTypeDarkSlateGray   = 0x2f4f4f, // 暗石板灰
    HexColorTypeDodgerBlue      = 0x1e90ff, // 道奇蓝
    HexColorTypeDeepSkyBlue     = 0x00bfff, // 深天蓝
    HexColorTypeTurquoise       = 0x40e0d0, // 绿宝石
    HexColorTypeDarkCyan        = 0x008b8b, // 暗青色
    HexColorTypeSpringGreen     = 0x00ff7f, // 春绿色
    HexColorTypeDarkGray        = 0xa9a9a9, // 深灰色
}HexColorType;


@interface UIColor (ColorWithHex)

+ (UIColor*) colorWithHex:(NSInteger)hexInt;

@end
