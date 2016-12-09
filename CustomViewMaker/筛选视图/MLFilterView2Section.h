//
//  MLFilterView2Section.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/8.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLFilterView2Section : UIView

/* 特征色 */
@property (nonatomic, copy) UIColor* tintColor;

/* 默认色 */
@property (nonatomic, copy) UIColor* mainNormalColor;
@property (nonatomic, copy) UIColor* subNormalColor;


/* 是否展开 */
@property (nonatomic, assign) BOOL isSpread;

/* 初始化: 自动添加和卸载筛选器到指定视图控制器,默认是有导航器的;
 * @param superVC:              * 加载本筛选器的视图控制器
 */
- (instancetype) initWithSuperVC:(UIViewController*)superVC;


/* 显示筛选器: 带2个输入和3个响应回调;
 * @param mainItems:            * 主选项数据
 * @param subItems:             * 副选项数据(二维数组)
 * @param completionBlock:      * 回调:选定了数据(回调的是序号对应的BOOL值)
 * @param cancelBlock:          - 回调:取消
 */
- (void) showWithMainItems:(NSArray*) mainItems
                  subItems:(NSArray<NSArray*>*) subItems
              onCompletion:(void (^) (NSArray<NSArray<NSNumber*>*>* subSelectedArray)) completionBlock
                  onCancel:(void (^) (void)) cancelBlock;


/* 隐藏筛选器;
 * @param hideCompletion:       - 回调:完成了动画
 */
- (void) hideOnCompletion:(void (^) (void))hideCompletion;


/* 重置筛选器 */
- (void) resetData;

@end
