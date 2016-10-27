//
//  FLGradientLabelLayer.m
//  CustomViewMaker
//
//  Created by jielian on 2016/10/27.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "FLGradientLabelLayer.h"
#import <UIKit/UIKit.h>
#import "UIColor+ColorWithHex.h"

@interface FLGradientLabelLayer()

@property (nonatomic, strong) UILabel* gradientLabel;

@property (nonatomic, strong) CABasicAnimation* gradientAnimation;

@property (nonatomic, strong) CAKeyframeAnimation* keyframeAnimation;

@end


@implementation FLGradientLabelLayer


- (void)layoutSublayers {
    [super layoutSublayers];
    [self resetGradientDatas];
    [self reloadGradientLabel];
    [self resetKeyframeAnimation];
}

/* 重设layer属性 */
- (void) resetGradientDatas {
    
    /* colors */
    self.colors = @[(id)self.backColor.CGColor,
                    (id)self.tintColor.CGColor,
                    (id)self.backColor.CGColor];
    
    /* direction */
    switch (self.direction) {
        case FLGradientDirectionFromBottomToTop:
        {
            self.startPoint = CGPointMake(0.5, 1);
            self.endPoint = CGPointMake(0.5, 0);
        }
            break;
        case FLGradientDirectionFromLeftToRight:
        {
            self.startPoint = CGPointMake(0, 0.5);
            self.endPoint = CGPointMake(1, 0.5);
        }
            break;
        case FLGradientDirectionFromRightToLeft:
        {
            self.startPoint = CGPointMake(1, 0.5);
            self.endPoint = CGPointMake(0, 0.5);
        }
            break;
        case FLGradientDirectionFromTopToBottom:
        {
            self.startPoint = CGPointMake(0.5, 0);
            self.endPoint = CGPointMake(0.5, 1);
        }
            break;
        default:
            break;
    }
    
    self.locations = @[@0, @0.5, @1];
}

/* 重设label的属性 */
- (void) reloadGradientLabel {
    self.gradientLabel.text = self.text;
    self.gradientLabel.font = self.textFont;
    self.gradientLabel.alpha = self.textAlpha;
    self.gradientLabel.frame = self.bounds;
    self.mask = self.gradientLabel.layer;
}

/* 重载动画: basicAnimation */
- (void) resetBasicAnimation {
    [self removeAllAnimations];
    self.gradientAnimation.fromValue = @[@0, @0, @(self.minGradientSection)];
    self.gradientAnimation.toValue = @[@(1 - self.minGradientSection), @1, @1];
    self.gradientAnimation.duration = self.gradientDuration;
    self.gradientAnimation.repeatCount = HUGE;
    [self addAnimation:self.gradientAnimation forKey:nil];
}

/* 重载动画: keyframeAnimation */
- (void) resetKeyframeAnimation {
    [self removeAllAnimations];
    self.keyframeAnimation.values = @[@[@0, @0, @(self.minGradientSection)],
                                      @[@((1 - self.minGradientSection) * 0.83), @0.8, @0.9],
                                      @[@(1 - self.minGradientSection), @1, @1]
                                      ];
    self.keyframeAnimation.keyTimes = @[@0, @0.618, @1];
    self.keyframeAnimation.duration = self.gradientDuration;
    self.keyframeAnimation.repeatCount = HUGE;
    [self addAnimation:self.keyframeAnimation forKey:nil];
}


# pragma mask 4 getter

- (UILabel *)gradientLabel {
    if (!_gradientLabel) {
        _gradientLabel = [UILabel new];
        _gradientLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _gradientLabel;
}

- (CABasicAnimation *)gradientAnimation {
    if (!_gradientAnimation) {
        _gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    }
    return _gradientAnimation;
}

- (CAKeyframeAnimation *)keyframeAnimation {
    if (!_keyframeAnimation) {
        _keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"locations"];
    }
    return _keyframeAnimation;
}

- (UIColor *)tintColor {
    if (!_tintColor) {
        _tintColor = [UIColor whiteColor];
    }
    return _tintColor;
}

- (UIColor *)backColor {
    if (!_backColor) {
        _backColor = [UIColor colorWithHex:0x27384b alpha:1];
    }
    return _backColor;
}

- (CGFloat)minGradientSection {
    if (_minGradientSection == 0) {
        _minGradientSection = 0.4;
    }
    return _minGradientSection;
}

- (CGFloat)gradientDuration {
    if (_gradientDuration == 0) {
        _gradientDuration = 1.5;
    }
    return _gradientDuration;
}

- (CGFloat)textAlpha {
    if (_textAlpha == 0) {
        _textAlpha = 0.9;
    }
    return _textAlpha;
}

@end
