//
//  MLWifiView.h
//  CustomViewMaker
//
//  Created by jielian on 2016/11/4.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLWifiView : UIView

/* 渲染色 */
@property (nonatomic, copy) UIColor* tintColor;

/* 背景色 */
@property (nonatomic, copy) UIColor* backColor;

/* 可否动效 */
@property (nonatomic, assign) BOOL canAnimation;

/* 单位动效持续时间 */
@property (nonatomic, assign) CGFloat uniteDuration;




/* 启动动效 */
- (void) startAnimatingOnCompleted:(void (^) (void))completedBlock;

/* 停止动效 */
- (void) endAnimatingOnCompleted:(void (^) (void))completedBlock;


@end
