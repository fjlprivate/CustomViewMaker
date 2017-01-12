//
//  PublicHeader.h
//  CustomViewMaker
//
//  Created by jielian on 2016/11/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//


#ifndef PublicHeader_h
#define PublicHeader_h


#import "Masonry.h"
#import "UIColor+ColorWithHex.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "NSString+Custom.h"
#import "NSString+IconFont.h"
#import <UINavigationBar+Awesome.h>

#import <ReactiveCocoa.h>


// 定义弱自引用
#define NameWeakSelf(weakself)         __weak typeof(self) weakself = self;

#define ScreenWidth                 [UIScreen mainScreen].bounds.size.width
#define ScreenHeight                [UIScreen mainScreen].bounds.size.height


#endif /* PublicHeader_h */
