//
//  NSString+Custom.h
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/12.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Custom)


// -- 重新计算字体大小:指定高度
- (CGFloat) resizeFontAtHeight:(CGFloat)height scale:(CGFloat)scale;

- (CGSize) resizeAtHeight:(CGFloat)height scale:(CGFloat)scale;


#pragma mask : 编码相关
// -- ASC
- (NSString*) ASCIIString;

@end
