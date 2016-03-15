//
//  DirectionView.m
//  JLPay
//
//  Created by 冯金龙 on 16/3/3.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "DirectionView.h"

static NSString* const kKeyPathBackGColorChange = @"backGColor";

@interface DirectionView()
@property (nonatomic, strong) CAShapeLayer* shapeLayer;

@end


@implementation DirectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.layer addSublayer:self.shapeLayer];
        [self addObserver:self forKeyPath:kKeyPathBackGColorChange options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}
- (void)dealloc {
    [self removeObserver:self forKeyPath:kKeyPathBackGColorChange];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.shapeLayer setFrame:self.bounds];
    [self addTriPathToShapeLayer];
}

- (void) addTriPathToShapeLayer {
    CGRect frame = self.frame;
    UIBezierPath* triPath = [UIBezierPath bezierPath];
    [triPath moveToPoint:CGPointMake(0, 0)];
    [triPath addLineToPoint:CGPointMake(frame.size.width, 0)];
    [triPath addLineToPoint:CGPointMake(frame.size.width * 0.5f, frame.size.height)];
    [triPath closePath];

    self.shapeLayer.fillColor = self.backGColor.CGColor;
    self.shapeLayer.path = triPath.CGPath;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:kKeyPathBackGColorChange]) {
        [self setNeedsLayout];
    }
}


#pragma mask 4 getter 
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}


@end
