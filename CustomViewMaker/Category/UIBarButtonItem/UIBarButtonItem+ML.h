//
//  UIBarButtonItem+ML.h
//  CustomViewMaker
//
//  Created by jielian on 2017/1/12.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ML)

+ (instancetype) backItemWithVC:(UIViewController*)curVC color:(UIColor*)color;

+ (instancetype) homeItemWithVC:(UIViewController*)curVC color:(UIColor*)color;

@end
