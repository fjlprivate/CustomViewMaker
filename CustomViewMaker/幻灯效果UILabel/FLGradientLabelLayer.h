//
//  FLGradientLabelLayer.h
//  CustomViewMaker
//
//  Created by jielian on 2016/10/27.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


/* 动画方向 */
typedef NS_ENUM(NSUInteger, FLGradientDirection) {
    /* 从左到右 */
    FLGradientDirectionFromLeftToRight,
    /* 从右到左 */
    FLGradientDirectionFromRightToLeft,
    /* 从上到下 */
    FLGradientDirectionFromTopToBottom,
    /* 从下到上 */
    FLGradientDirectionFromBottomToTop
};


@class UIColor;
@class UIFont;

@interface FLGradientLabelLayer : CAGradientLayer

/* text */
@property (nonatomic, copy) NSString* text;

/* font */
@property (nonatomic, copy) UIFont* textFont;


# pragma mask : 以下属性都有默认值

/* tintColor, detault:whiteColor */
@property (nonatomic, copy) UIColor* tintColor;

/* backColor, detault: 0x27384b */
@property (nonatomic, copy) UIColor* backColor;

/* 动画方向 */
@property (nonatomic, assign) FLGradientDirection direction;

/* 幻灯最小区间, detault: 0.4 */
@property (nonatomic, assign) CGFloat minGradientSection;

/* 动画时间, detault: 1.5 */
@property (nonatomic, assign) CGFloat gradientDuration;

/* text alpha, default: 0.9 */
@property (nonatomic, assign) CGFloat textAlpha;


@end
