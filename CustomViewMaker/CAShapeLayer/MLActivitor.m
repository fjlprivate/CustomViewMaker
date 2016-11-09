//
//  MLActivitor.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MLActivitor.h"
#import "UIColor+ColorWithHex.h"


@interface MLActivitor()

@property (nonatomic, strong) NSArray* activityItems;

@property (nonatomic, assign) CGFloat maxScaleRate;

@property (nonatomic, assign) BOOL canAnimating;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer* timer;

@end




@implementation MLActivitor


- (void)show {
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/8.f target:self selector:@selector(timerFuncGlobal) userInfo:nil repeats:YES];
    
}

- (void)hide {
    
}

# pragma mask 1 定时器z

- (void) timerFuncGlobal {
    if (self.index == 8 - 1 ) {
        self.index = 0;
    } else {
        self.index ++;
    }
    [self animatingForShapeLayerItem];
}

- (void) animatingForShapeLayerItem {
    CAShapeLayer* curShapeLayer = [self.activityItems objectAtIndex:self.index];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5f;
    animation.fillMode = kCAFillModeForwards;
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(self.maxScaleRate, self.maxScaleRate, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    animation.keyTimes = @[@0, @0.5, @1];
    
    
    [curShapeLayer removeAllAnimations];
    [curShapeLayer addAnimation:animation forKey:@"scaleAnimation"];
}



# pragma mask 2 布局

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubviews];
        [self initialDatas];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
        [self initialDatas];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutSublayers];
}


- (void) initialDatas {
    self.maxScaleRate = 1.8;
    self.canAnimating = YES; // no
    self.index = 0;
    _tintColor = [UIColor colorWithHex:0x999999 alpha:1];
    self.layer.masksToBounds = YES;
}

- (void) loadSubviews {
    for (CAShapeLayer* shape in self.activityItems) {
        [self.layer addSublayer:shape];
    }
}

- (void) layoutSublayers {
    CGFloat maxItemRadius = self.frame.size.height * 0.24 * 0.5;
    CGFloat minItemRadius = maxItemRadius / self.maxScaleRate;
    CGFloat oCenterX = self.frame.size.width * 0.5;
    CGFloat oCenterY = self.frame.size.height * 0.5;
    CGFloat oRadius = self.frame.size.height * 0.5 - maxItemRadius;
    
    for (int i = 0; i < self.activityItems.count; i++) {
        CAShapeLayer* shapeLayer = [self.activityItems objectAtIndex:i];
        CGFloat centerX = oCenterX + oRadius * sin(M_PI_4 * i);
        CGFloat centerY = oCenterY - oRadius * cos(M_PI_4 * i);
        CGRect frame = CGRectMake(centerX - minItemRadius,
                                  centerY - minItemRadius,
                                  minItemRadius * 2, minItemRadius * 2);
        shapeLayer.frame = frame;
        
        UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds];
        shapeLayer.path = path.CGPath;
        
        // ------- 布局 shapeLayer 组
        shapeLayer.fillColor = self.tintColor.CGColor;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    }
}


# pragma mask 4 getter

- (NSArray *)activityItems {
    if (!_activityItems) {
        NSMutableArray* items = [NSMutableArray array];
        for (int i = 0; i < 8; i++) {
            CAShapeLayer* shape = [CAShapeLayer layer];
            [items addObject:shape];
        }
        _activityItems = [NSArray arrayWithArray:items];
    }
    return _activityItems;
}


@end
