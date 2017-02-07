//
//  MLPullMenu.h
//  CustomViewMaker
//
//  Created by jielian on 2017/2/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>



/* 展开方向 */
typedef NS_ENUM(NSInteger, MLPullMenuDirection) {
    MLPullMenuDirectionDown,        // 向下
    MLPullMenuDirectionUp,          // 向上
    MLPullMenuDirectionRight,       // 向右
    MLPullMenuDirectionLeft         // 向左
};



@interface MLPullMenu : UIView


/*
 * [显示下拉菜单界面]
 * @param items: 菜单选项的标题;
 * @param startPoint: 展开三角形顶点在superView的坐标;
 * @param direction: 展开方向;
 * @param clickedBlock: 选择了指定标题序号的回调;
 */
- (void) showWithItems:(NSArray<NSString*>*)items
          onStartPoint:(CGPoint)startPoint
          andDirection:(MLPullMenuDirection)direction
             onClicked:(void (^) (NSInteger index))clickedBlock;


/* [隐藏下拉菜单界面] */
- (void) hide;



/* 是否展开 */
@property (nonatomic, assign) BOOL isPulled;

/* 行高, 默认: 35 */
@property (nonatomic, assign) CGFloat rowHeight;
/* 行宽, 根据items的最长值计算 */
@property (nonatomic, assign) CGFloat rowWidth;


/* 主题色, 默认: 0x27384b */
@property (nonatomic, copy) UIColor* tintColor;

/* 点击色, 默认: 0x666666 */
@property (nonatomic, copy) UIColor* selectedColor;

/* 文本色, 默认: 0xffffff */
@property (nonatomic, copy) UIColor* textColor;

/* 是否显示阴影, 默认: YES */
@property (nonatomic, assign) BOOL enableShadow;



@end
