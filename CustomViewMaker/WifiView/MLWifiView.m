//
//  MLWifiView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/4.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MLWifiView.h"
#import "UIColor+ColorWithHex.h"


@interface MLWifiView()

@property (nonatomic, strong) CAShapeLayer* shapeLayer;


@end


@implementation MLWifiView

- (void)startAnimatingOnCompleted:(void (^)(void))completedBlock {
    
}

- (void)endAnimatingOnCompleted:(void (^)(void))completedBlock {
    
}



# pragma mask 3 initial 

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialDatas];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialDatas];
    }
    return self;
}

/* 初始化数据 */
- (void) initialDatas {
    _tintColor = [UIColor colorWithHex:0x00bb9c alpha:1];
    _backColor = [UIColor colorWithHex:0xe0e0e0 alpha:1];
    _uniteDuration = 1;
    _canAnimation = NO; // yes
    _shapeLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.shapeLayer];
    
    self.backgroundColor = [UIColor clearColor];
}


/* 重载视图 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self resetShapeLayer];
}


/* 重置shapeLayer的状态 */
- (void) resetShapeLayer {
    self.shapeLayer.path = [self newPathAtCurrentState].CGPath;
    self.shapeLayer.fillColor = self.tintColor.CGColor;
    self.shapeLayer.fillMode = kCAFillModeForwards;
}

/* 新建CAShapeLayer的path */
- (UIBezierPath*) newPathAtCurrentState {
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    CGFloat curRadius = [self maxRadiusOfWifi];
    CGFloat inset = curRadius * 0.1;
    CGFloat uniteHeight = (curRadius - inset * 3) / 4;
    
    CGFloat centerX = self.frame.size.width / 2;
    CGFloat centerY = self.frame.size.height - (self.frame.size.height - curRadius)/2;
    
    CGPoint centerP = CGPointMake(centerX, centerY);
    /* 0: 小三角 */
    CGPoint triLeftP = CGPointMake(centerX - uniteHeight * sqrtf(2) / 2,
                                   centerY + uniteHeight * sqrtf(2) / 2);
    CGPoint triRightP = CGPointMake(centerX + uniteHeight * sqrtf(2) / 2,
                                    centerY + uniteHeight * sqrtf(2) / 2);
    [path moveToPoint:centerP];
    [path addLineToPoint:triLeftP];
    [path addArcWithCenter:centerP radius:uniteHeight startAngle:- M_PI_4 endAngle:M_PI_4 clockwise:NO];
    [path addLineToPoint:triRightP];
    [path closePath];

    /* 1: 小环 */
    CGFloat radiusLittleRingIn = uniteHeight + inset;
    CGFloat radiusLittleRingOut = radiusLittleRingIn + uniteHeight;
    
    CGPoint littleRingBottomLeft = CGPointMake(centerX - radiusLittleRingIn * sqrtf(2) / 2,
                                               centerY + radiusLittleRingIn * sqrtf(2) / 2);
    CGPoint littleRingBottomRight = CGPointMake(centerX + radiusLittleRingIn * sqrtf(2) / 2,
                                                centerY + radiusLittleRingIn * sqrtf(2) / 2);
    CGPoint littleRingTopLeft = CGPointMake(centerX - radiusLittleRingOut * sqrtf(2) / 2,
                                            centerY + radiusLittleRingOut * sqrtf(2) / 2);
    CGPoint littleRingTopRight = CGPointMake(centerX + radiusLittleRingOut * sqrtf(2) / 2,
                                             centerY + radiusLittleRingOut * sqrtf(2) / 2);
    [path moveToPoint:littleRingBottomLeft];
    [path addLineToPoint:littleRingTopLeft];
    [path moveToPoint:littleRingBottomRight];
    [path addLineToPoint:littleRingTopRight];
    [path addArcWithCenter:centerP radius:radiusLittleRingIn startAngle:- M_PI_4 endAngle:M_PI_4 clockwise:NO];
    [path addArcWithCenter:centerP radius:radiusLittleRingOut startAngle:- M_PI_4 endAngle:M_PI_4 clockwise:NO];
    [path closePath];

    
    /* 2: 中环 */
    CGFloat radiusMidRingIn = radiusLittleRingOut + inset;
    CGFloat radiusMidRingOut = radiusMidRingIn + uniteHeight;

    CGPoint midRingBottomLeft = CGPointMake(centerX - radiusMidRingIn * sqrtf(2) / 2,
                                            centerY + radiusMidRingIn * sqrtf(2) / 2);;
    CGPoint midRingBottomRight = CGPointMake(centerX + radiusMidRingIn * sqrtf(2) / 2,
                                             centerY + radiusMidRingIn * sqrtf(2) / 2);
    CGPoint midRingTopLeft = CGPointMake(centerX - radiusMidRingOut * sqrtf(2) / 2,
                                         centerY + radiusMidRingOut * sqrtf(2) / 2);;
    CGPoint midRingTopRight = CGPointMake(centerX + radiusMidRingOut * sqrtf(2) / 2,
                                          centerY + radiusMidRingOut * sqrtf(2) / 2);

    /* 3: 大环 */
    CGFloat radiusBigRingIn = radiusMidRingOut + inset;
    CGFloat radiusBigRingOut = radiusBigRingIn + uniteHeight;

    CGPoint bigRingBottomLeft = CGPointMake(centerX - radiusBigRingIn * sqrtf(2) / 2,
                                            centerY + radiusBigRingIn * sqrtf(2) / 2);;
    CGPoint bigRingBottomRight = CGPointMake(centerX + radiusBigRingIn * sqrtf(2) / 2,
                                             centerY + radiusBigRingIn * sqrtf(2) / 2);
    CGPoint bigRingTopLeft = CGPointMake(centerX - radiusBigRingOut * sqrtf(2) / 2,
                                         centerY + radiusBigRingOut * sqrtf(2) / 2);;
    CGPoint bigRingTopRight = CGPointMake(centerX + radiusBigRingOut * sqrtf(2) / 2,
                                          centerY + radiusBigRingOut * sqrtf(2) / 2);

    
    [self.tintColor setFill];
    
    return path;
}


/* 计算当前wifi的最大半径值 */
- (CGFloat) maxRadiusOfWifi {
    CGFloat frameWidth = self.frame.size.width;
    CGFloat frameHeight = self.frame.size.height;
    CGFloat maxRadius;
    if (frameWidth > frameHeight * sqrtf(2)) {
        maxRadius = frameHeight;
    } else {
        maxRadius = frameWidth * sqrtf(2) / 2;
    }
    return maxRadius;
}


@end
