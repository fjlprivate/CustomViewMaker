//
//  TVCI_mAwesome.h
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TVCI_mAwesome : NSObject <NSCopying>

/* 初始化
 * @param  name     : font的名字
 * @param  type     : font的类型,决定text的值
 * @param  fontSize : font的字体大小,决定font的值

 */
+ (instancetype) fontWithName:(NSString*)name
                         type:(NSInteger)type
                     fontSize:(CGFloat)fontSize;


@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) UIFont* font;
@property (nonatomic, copy) NSString* name;


@end
