//
//  WifiView.h
//  CustomViewMaker
//
//  Created by jielian on 16/4/28.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WifiView : UIView


// 颜色、粗细、端口圆润、等属性需要自定义
@property (nonatomic, strong) CAShapeLayer* centerCircleLayer;
@property (nonatomic, strong) CAShapeLayer* ringCircleLayer;         // 加载自画的 wifi path

@property (nonatomic, assign) BOOL hiddenWhenAnimationEnd;      // default YES;

@property (nonatomic, assign) NSInteger animationCount;         // 动画线条计数:0-3

- (void) startAnimationOnFinished:(void (^) (void))finishedBlock;
- (void) stopAnimationOnFinished:(void (^) (void))finishedBlock;


@end
