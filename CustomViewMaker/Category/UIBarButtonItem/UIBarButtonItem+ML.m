//
//  UIBarButtonItem+ML.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/12.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "UIBarButtonItem+ML.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "NSString+Custom.h"


@implementation UIBarButtonItem (ML)

+ (instancetype)backItemWithVC:(UIViewController *)curVC color:(UIColor *)color {
    CGFloat height = 22;
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAChevronLeft] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:height scale:1]];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:curVC.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)homeItemWithVC:(UIViewController *)curVC color:(UIColor *)color {
    CGFloat height = 22;
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAHome] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:height scale:1]];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:curVC action:@selector(dismissViewControllerAnimated:completion:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
