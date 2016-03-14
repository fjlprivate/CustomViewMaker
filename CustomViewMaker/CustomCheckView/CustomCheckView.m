//
//  CustomCheckView.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/9.
//  Copyright © 2016年 冯金龙. All rights reserved.
//

#import "CustomCheckView.h"

@interface CustomCheckView()
@property (nonatomic, strong) CAShapeLayer* rightLayer;
@property (nonatomic, strong) CAShapeLayer* wrongLayer;
@end

@implementation CustomCheckView

- (void)showAnimation {
    [self initialRightPointsInRect:self.bounds];
    [self initialWrongPointsInRect:self.bounds];
    [self initialLinesProperties];

    if ([self rightOrWrong] == CustomCheckViewStyleRight) {
        self.rightLayer.strokeEnd = 1;
        self.wrongLayer.strokeEnd = 0;
    } else {
        self.wrongLayer.strokeEnd = 1;
        self.rightLayer.strokeEnd = 0;
    }
}
- (void)hiddenAnimation {
    self.rightLayer.strokeEnd = 0;
    self.wrongLayer.strokeEnd = 0;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.layer addSublayer:self.rightLayer];
        [self.layer addSublayer:self.wrongLayer];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.layer addSublayer:self.rightLayer];
        [self.layer addSublayer:self.wrongLayer];
    }
    return self;
}


#pragma mask 3 坐标,线条初始化
// -- 初始化'勾'坐标系
- (void) initialRightPointsInRect:(CGRect)rect {
    CGFloat insetHorizontal = rect.size.width * self.innerSizeScale;
    CGFloat unitLength = (rect.size.width - insetHorizontal*2)/3.f;
    CGFloat insetVertical = (rect.size.height - unitLength*2)/2.f;
    CGPoint rightStartPoint = CGPointMake(insetHorizontal, insetVertical + unitLength);
    CGPoint rightMidPoint = CGPointMake(insetHorizontal + unitLength, insetVertical + unitLength*2);
    CGPoint rightEndPoint = CGPointMake(insetHorizontal + unitLength*3, insetVertical);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:rightStartPoint];
    [path addLineToPoint:rightMidPoint];
    [path addLineToPoint:rightEndPoint];
    self.rightLayer.path = path.CGPath;
}
// -- 初始化'叉'坐标系
- (void) initialWrongPointsInRect:(CGRect)rect {
    CGFloat inset = rect.size.width * self.innerSizeScale * (9.f/7.f);
    CGPoint wrongUpStartPoint = CGPointMake(inset, inset);
    CGPoint wrongUpEndPoint = CGPointMake(rect.size.width - inset, rect.size.height - inset);
    CGPoint wrongDownStartPoint = CGPointMake(inset, rect.size.height - inset);
    CGPoint wrongDownEndPoint = CGPointMake(rect.size.width - inset, inset);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:wrongUpStartPoint];
    [path addLineToPoint:wrongUpEndPoint];
    [path moveToPoint:wrongDownStartPoint];
    [path addLineToPoint:wrongDownEndPoint];
    self.wrongLayer.path = path.CGPath;
}
// -- 线条属性初始化
- (void) initialLinesProperties {
    self.rightLayer.lineWidth = self.lineWidth;
    self.wrongLayer.lineWidth = self.lineWidth;
    self.rightLayer.strokeColor = self.lineColor.CGColor;
    self.wrongLayer.strokeColor = self.lineColor.CGColor;
    if ([self lineRoundOrRect] == CustomCheckViewStyleLineRound) {
        self.rightLayer.lineCap = kCALineCapRound;
        self.wrongLayer.lineCap = kCALineCapRound;
    } else {
        self.rightLayer.lineCap = kCALineCapButt;
        self.wrongLayer.lineCap = kCALineCapButt;
    }
}

#pragma mask 3 private interface
// -- '勾'或'叉'
- (CustomCheckViewStyle) rightOrWrong {
    return (self.checkViewStyle & (CustomCheckViewStyleRight|CustomCheckViewStyleWrong));
}
// -- '圆角'或'直角'
- (CustomCheckViewStyle) lineRoundOrRect {
    return (self.checkViewStyle & (CustomCheckViewStyleLineRound|CustomCheckViewStyleLineButt));
}


#pragma mask 4 getter
- (CustomCheckViewStyle)checkViewStyle {
    if (_checkViewStyle == 0) {
        _checkViewStyle = CustomCheckViewStyleRight|CustomCheckViewStyleLineRound;
    }
    return _checkViewStyle;
}
- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [UIColor blackColor];
    }
    return _lineColor;
}
- (CGFloat)innerSizeScale {
    if (_innerSizeScale == 0) {
        _innerSizeScale = 1.f/4.5f;
    }
    return _innerSizeScale;
}
- (CAShapeLayer *)rightLayer {
    if (!_rightLayer) {
        _rightLayer = [CAShapeLayer layer];
        _rightLayer.fillColor = [UIColor clearColor].CGColor;
        _rightLayer.strokeStart = 0;
        _rightLayer.strokeEnd = 0;
    }
    return _rightLayer;
}
- (CAShapeLayer *)wrongLayer {
    if (!_wrongLayer) {
        _wrongLayer = [CAShapeLayer layer];
        _wrongLayer.fillColor = [UIColor clearColor].CGColor;
        _wrongLayer.strokeStart = 0;
        _wrongLayer.strokeEnd = 0;
    }
    return _wrongLayer;
}
@end
