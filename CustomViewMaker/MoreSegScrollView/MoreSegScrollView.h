//
//  MoreSegScrollView.h
//  CustomViewMaker
//
//  Created by jielian on 16/9/18.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreSegScrollView : UIView


/* 序号 */
@property (nonatomic, assign) NSInteger curSegIndex;


/*
 NSDictionary<
 imgName: <NSString> 图片名
 title: <NSString> 标题
 titleColor: <UIColor>  标题色
 backColor: <UIColor>  背景色
 >
 */
@property (nonatomic, copy) NSArray<NSDictionary*>* segInfos;


- (instancetype) initWithSegInfos:(NSArray*)segInfos;




/* 最小缩放比例 */
@property (nonatomic, assign) CGFloat minScale;

/* 可显示的item个数 */
//@property (nonatomic, assign) NSInteger

@end
