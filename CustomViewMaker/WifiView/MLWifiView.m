//
//  MLWifiView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/4.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MLWifiView.h"
#import "UIColor+ColorWithHex.h"
#import <ReactiveCocoa.h>


@interface MLWifiView()

@property (nonatomic, strong) CAShapeLayer* triLitShape;
@property (nonatomic, strong) CAShapeLayer* circleShape1;
@property (nonatomic, strong) CAShapeLayer* circleShape2;
@property (nonatomic, strong) CAShapeLayer* circleShape3;

@property (nonatomic, assign) NSInteger step;

@property (nonatomic, strong) NSTimer* animationTimer;

@end


@implementation MLWifiView

- (void)startAnimatingOnCompleted:(void (^)(void))completedBlock {
    [self addTimer];
    if (completedBlock) {
        completedBlock();
    }
}

- (void)endAnimatingOnCompleted:(void (^)(void))completedBlock {
    [self removeTimer];
    if (completedBlock) {
        completedBlock();
    }
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
    self.backgroundColor = [UIColor clearColor];
    _tintColor = [UIColor colorWithHex:0x00bb9c alpha:1];
    _backColor = [UIColor colorWithHex:0xeeeeee alpha:0.8];
    _uniteDuration = 1;
    self.onTint = YES; // yes
    _step = -1; // 未启动的样子
    
    [self.layer addSublayer:self.triLitShape];
    [self.layer addSublayer:self.circleShape3];
    [self.layer addSublayer:self.circleShape2];
    [self.layer addSublayer:self.circleShape1];

    // add KVO
    @weakify(self);
    [[RACObserve(self, step) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        [self resetShapeLayer];
    }];
    
    [RACObserve(self, onTint) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            self.step = 100; // 防止超限
        } else {
            self.step = -1;
        }
    }];
}


/* 重载视图 */
- (void)layoutSubviews {
    [super layoutSubviews];
    [self resetShapeLayer];
}


/* 重置shapeLayer的状态 */
- (void) resetShapeLayer {
    
    CGFloat maxRadius = [self maxRadiusOfWifi];
    CGFloat inset = maxRadius * 1.f/(3 + 4 * 2.5/* inset * x = uniteRadius */);
    CGFloat uniteRadius = (maxRadius - inset * 3.f) / 4.f;
    
    CGPoint centerP = CGPointMake(self.bounds.size.width * 0.5,
                                  self.bounds.size.height * 0.5 + maxRadius * 0.5 );
    
    CGFloat radiusTri = uniteRadius * 0.5;
    CGFloat radiusCir1 = radiusTri + uniteRadius + inset;
    CGFloat radiusCir2 = radiusCir1 + uniteRadius + inset;
    CGFloat radiusCir3 = radiusCir2 + uniteRadius + inset;

    UIBezierPath* pathTri = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerP.x - radiusTri,
                                                                              centerP.y - radiusTri,
                                                                              radiusTri * 2,
                                                                              radiusTri * 2)];
    UIBezierPath* pathCir1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerP.x - radiusCir1,
                                                                               centerP.y - radiusCir1,
                                                                               radiusCir1 * 2,
                                                                               radiusCir1 * 2)];
    UIBezierPath* pathCir2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerP.x - radiusCir2,
                                                                               centerP.y - radiusCir2,
                                                                               radiusCir2 * 2,
                                                                               radiusCir2 * 2)];
    UIBezierPath* pathCir3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerP.x - radiusCir3,
                                                                               centerP.y - radiusCir3,
                                                                               radiusCir3 * 2,
                                                                               radiusCir3 * 2)];
    
    self.triLitShape.path = pathTri.CGPath;
    self.circleShape1.path = pathCir1.CGPath;
    self.circleShape2.path = pathCir2.CGPath;
    self.circleShape3.path = pathCir3.CGPath;
    
    self.triLitShape.lineWidth = uniteRadius;
    self.circleShape1.lineWidth = uniteRadius;
    self.circleShape2.lineWidth = uniteRadius;
    self.circleShape3.lineWidth = uniteRadius;
    
    self.triLitShape.strokeColor = self.step >= 0 ? self.tintColor.CGColor : self.backColor.CGColor;
    self.circleShape1.strokeColor = self.step >= 1 ? self.tintColor.CGColor : self.backColor.CGColor;
    self.circleShape2.strokeColor = self.step >= 2 ? self.tintColor.CGColor : self.backColor.CGColor;
    self.circleShape3.strokeColor = self.step >= 3 ? self.tintColor.CGColor : self.backColor.CGColor;
}


- (void) addTimer {
    __weak typeof(self) wself = self;
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.uniteDuration/5.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (wself.step >= 4) {
            wself.step = -2;
        } else {
            wself.step ++;
        }
    }];
}

- (void) removeTimer {
    if ([self.animationTimer isValid]) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
    self.step = -1;
}



/* 计算当前wifi的最大半径值 */
- (CGFloat) maxRadiusOfWifi {
    CGFloat frameWidth = self.frame.size.width;
    CGFloat frameHeight = self.frame.size.height;
    CGFloat maxRadius;
    if (frameWidth >= frameHeight * sqrtf(2)) {
        maxRadius = frameHeight;
    } else {
        maxRadius = frameWidth * sqrtf(2) / 2;
    }
    return maxRadius;
}


# pragma mask 4 getter

- (CAShapeLayer *)triLitShape {
    if (!_triLitShape) {
        _triLitShape = [CAShapeLayer layer];
        _triLitShape.fillColor = [UIColor clearColor].CGColor;
        _triLitShape.strokeStart = 5.f/8.f;
        _triLitShape.strokeEnd = 7.f/8.f;
    }
    return _triLitShape;
}

- (CAShapeLayer *)circleShape1 {
    if (!_circleShape1) {
        _circleShape1 = [CAShapeLayer layer];
        _circleShape1.fillColor = [UIColor clearColor].CGColor;
        _circleShape1.strokeStart = 5.f/8.f;
        _circleShape1.strokeEnd = 7.f/8.f;
    }
    return _circleShape1;
}
- (CAShapeLayer *)circleShape2 {
    if (!_circleShape2) {
        _circleShape2 = [CAShapeLayer layer];
        _circleShape2.fillColor = [UIColor clearColor].CGColor;
        _circleShape2.strokeStart = 5.f/8.f;
        _circleShape2.strokeEnd = 7.f/8.f;
    }
    return _circleShape2;
}
- (CAShapeLayer *)circleShape3 {
    if (!_circleShape3) {
        _circleShape3 = [CAShapeLayer layer];
        _circleShape3.fillColor = [UIColor clearColor].CGColor;
        _circleShape3.strokeStart = 5.f/8.f;
        _circleShape3.strokeEnd = 7.f/8.f;
    }
    return _circleShape3;
}

@end
