//
//  WifiView.m
//  CustomViewMaker
//
//  Created by jielian on 16/4/28.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "WifiView.h"

@interface WifiView()

{
    
}

@end

@implementation WifiView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}
- (void) initial {
    self.hiddenWhenAnimationEnd = YES;
    [self.layer addSublayer:self.ringCircleLayer];
    [self.layer addSublayer:self.centerCircleLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    CGFloat angle = frame.size.width * 0.5 * 0.25 * sqrt(2);
    
    CGFloat centerX = frame.size.width * 0.5;
    CGFloat bottomY = frame.size.height;
    
    CGPoint centerBottomP = CGPointMake(centerX, bottomY);
    
    /* remake bezierPath to centerCircleLayer  */
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:centerBottomP];
    [path addArcWithCenter:centerBottomP radius:angle startAngle:M_PI * 1.25 endAngle:M_PI * 1.75 clockwise:YES];
    self.centerCircleLayer.path = path.CGPath;
    
    
    /* remake bezierPath to ringCircleLayer by animationCount */
    UIBezierPath* ringPath = [UIBezierPath bezierPath];
    for (int i = 0; i < self.animationCount; i++) {
        UIBezierPath* inPath = [UIBezierPath bezierPathWithArcCenter:centerBottomP radius:(i + 2) * angle startAngle:M_PI * 1.25 endAngle:M_PI * 1.75 clockwise:YES];
        [ringPath appendPath:inPath];
    }
    self.ringCircleLayer.path = ringPath.CGPath;
}


- (void) startAnimationOnFinished:(void (^) (void))finishedBlock {
    [NSTimer scheduledTimerWithTimeInterval:0.3 + 0.2 + 0.1 target:self selector:@selector(doAnimation) userInfo:nil repeats:YES];
}

- (void) stopAnimationOnFinished:(void (^) (void))finishedBlock {
    
}

- (void) doAnimation {
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        wself.animationCount = 0;
        [wself setNeedsLayout];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            wself.animationCount = 1;
            [wself setNeedsLayout];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                wself.animationCount = 2;
                [wself setNeedsLayout];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}


# pragma mask 4 getter
- (CAShapeLayer *)ringCircleLayer {
    if (!_ringCircleLayer) {
        _ringCircleLayer = [CAShapeLayer layer];
    }
    return _ringCircleLayer;
}
- (CAShapeLayer *)centerCircleLayer {
    if (!_centerCircleLayer) {
        _centerCircleLayer = [CAShapeLayer layer];
    }
    return _centerCircleLayer;
}




@end
