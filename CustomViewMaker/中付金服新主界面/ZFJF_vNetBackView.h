//
//  ZFJF_vNetBackView.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/5.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFJF_vNetBackView : UICollectionReusableView



/* 网格背景视图的初始化
 * @param vCount:       纵方向格个数;
 * @param hCount:       横方向格个数;
 * @param hasBorder:    是否有边界;
 */
- (instancetype) initWithVCount:(NSInteger)vCount
                         hCount:(NSInteger)hCount
                      hasBorder:(BOOL)hasBorder;


/* 网格线条色  default: 0xeeeeee */
@property (nonatomic, copy) UIColor* borderLineColor;


/* 网格线条宽度 default: 0.8f */
@property (nonatomic, assign) CGFloat borderLineWidth;


@end
