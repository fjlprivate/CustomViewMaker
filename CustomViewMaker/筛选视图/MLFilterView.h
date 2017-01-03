//
//  MLFilterView.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/8.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLFV_item : NSObject

- initWithTitle:(NSString*) title andSubTitleItems:(NSArray*)subItems;

@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSArray* subItems;

@end





@interface MLFilterView : UIView

/* 初始化: 自动添加和卸载筛选器到指定视图控制器,默认是有导航器的;
 * @param superVC:              * 加载本筛选器的视图控制器
 */
- (instancetype) initWithSuperVC:(UIViewController*)superVC;


# pragma mask : 定义区

/* 分部 */
@property (nonatomic, assign) NSInteger section;

/* 特征色(已选择色)    * default: 0x00a1dc */
@property (nonatomic, copy) UIColor* tintColor;

/* 默认色(未选择色)    * default: 0x999999 */
@property (nonatomic, copy) UIColor* normalColor;

/* 展开属性           * default: NO */
@property (nonatomic, assign) BOOL spreaded;

/* 自动隐藏,选择完毕后  * default: NO */
@property (nonatomic, assign) BOOL hideAfterFiltered;


# pragma mask : 功能区

/* 显示筛选器
 * @param datas:              * 数据源,多维数组(2维以上的维数取决于它的上一维对应个数);
 * @param finishedBlock:      * 选择完毕,多维数组,维数同datas,但是item是BOOL型,分别表示已选和未选;
 * @param cancelBlock:        * 取消筛选器;
 */
- (void) showWithDatas:(NSArray*)datas
            onFinished:(void (^) (NSArray* selectedIndexes)) finishedBlock
            onCanceled:(void (^) (void)) cancelBlock;



/* 隐藏筛选器;
 * @param hideCompletion:     * 回调:完成了动画
 */
- (void) hideOnCompletion:(void (^) (void))hideCompletion;



/* 重置筛选器状态 */
- (void) resetData;


@end
