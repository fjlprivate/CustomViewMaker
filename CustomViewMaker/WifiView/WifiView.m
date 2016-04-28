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
    [self.layer addSublayer:self.shapeLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /* remake bezierPath to shapeLayer by animationCount */
    CGRect frame = self.bounds;
    CGFloat angle = frame.size.width * 0.5 * 0.25 * sqrt(2);
    
    CGFloat centerX = frame.size.width * 0.5;
    CGFloat bottomY = frame.size.height;
    
    CGPoint centerBottomP = CGPointMake(centerX, bottomY);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    [path addArcWithCenter:centerBottomP radius:angle startAngle:M_PI * 1.25 endAngle:M_PI * 1.75 clockwise:YES];
    
    for (int i = 0; i < self.animationCount; i++) {
        UIBezierPath* inPath = [UIBezierPath bezierPathWithArcCenter:centerBottomP radius:(i + 2) * angle startAngle:M_PI * 1.25 endAngle:M_PI * 1.75 clockwise:YES];
        [path appendPath:inPath];
    }
    
    self.shapeLayer.path = path.CGPath;
}


- (void) startAnimationOnFinished:(void (^) (void))finishedBlock {
    
}

- (void) stopAnimationOnFinished:(void (^) (void))finishedBlock {
    
}



# pragma mask 4 getter
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}




@end
