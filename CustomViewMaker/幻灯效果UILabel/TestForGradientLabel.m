//
//  TestForGradientLabel.m
//  CustomViewMaker
//
//  Created by jielian on 2016/10/27.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForGradientLabel.h"
#import "UIColor+ColorWithHex.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "FLGradientLabelLayer.h"

@interface TestForGradientLabel ()

/*  */
@property (nonatomic, strong) UILabel* gradientLabel;

@property (nonatomic, strong) CAGradientLayer* gradientLayer;

@property (nonatomic, strong) FLGradientLabelLayer* flGradientLayer;

@end

@implementation TestForGradientLabel



- (CAAnimation*) basicAniForGradientLayer {
    CABasicAnimation* basicAni = [CABasicAnimation animationWithKeyPath:@"locations"];
    basicAni.fromValue = @[@0, @0, @0.4];
    basicAni.toValue = @[@0.6, @1, @1];
    basicAni.duration = 1.5f;
    basicAni.repeatCount = HUGE;
    
    
    CAKeyframeAnimation* keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"locations"];
    keyframeAni.values = @[@[@0,        @0,     @0.4],
                           @[@0.5,      @0.8,   @0.9],
                           @[@0.6,      @1,     @1]
                           ];
    keyframeAni.keyTimes = @[@0, @0.618, @1];
    keyframeAni.duration = 1.5;
    keyframeAni.repeatCount = HUGE;
    
    return keyframeAni;
}



- (void) loadSubviews {
    [self.view.layer addSublayer:self.gradientLayer];
    self.gradientLayer.mask = self.gradientLabel.layer;
    
    
    [self.view.layer addSublayer:self.flGradientLayer];
}


- (void) layoutSubviews {
    CGFloat width = 200;
    CGFloat height = 200;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect frame = CGRectMake((screenWidth - width)*0.5, (screenHeight - height)*0.5, width, height);
    self.gradientLayer.frame = frame;
    
    self.gradientLabel.frame = self.gradientLayer.bounds;
    
    frame.origin.y += frame.size.height + 50;
    self.flGradientLayer.frame = frame;
}

- (void) initialDatas {
    self.title = @"GradientLayer";
    self.view.backgroundColor = [UIColor colorWithHex:0xffffff alpha:1];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubviews];
    [self layoutSubviews];
    [self initialDatas];
}


# pragma mask 4 getter

- (UILabel *)gradientLabel {
    if (!_gradientLabel) {
        _gradientLabel = [UILabel new];
        _gradientLabel.textAlignment = NSTextAlignmentCenter;
        _gradientLabel.font = [UIFont boldSystemFontOfSize:20];
        _gradientLabel.text = @"滑动来解锁 >>dskjfjsldfj";
//        _gradientLabel.text = [NSString fontAwesomeIconStringForEnum:FAwifi];
//        _gradientLabel.font = [UIFont fontAwesomeFontOfSize:60];
        _gradientLabel.alpha = 0.9;
    }
    return _gradientLabel;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 0.5);
        _gradientLayer.colors = @[(id)[UIColor colorWithHex:0x27384b alpha:1].CGColor,
                                  (id)[UIColor colorWithHex:0xffffff alpha:1].CGColor,
                                  (id)[UIColor colorWithHex:0x27384b alpha:1].CGColor];
        _gradientLayer.locations = @[@0.25, @0.5, @0.75];
        [_gradientLayer addAnimation:[self basicAniForGradientLayer] forKey:nil];
    }
    return _gradientLayer;
}


- (FLGradientLabelLayer *)flGradientLayer {
    if (!_flGradientLayer) {
        _flGradientLayer = [FLGradientLabelLayer layer];
        _flGradientLayer.backColor = [UIColor colorWithHex:0x99cccc alpha:1];
        _flGradientLayer.tintColor = [UIColor colorWithHex:0xef454b alpha:1];
        _flGradientLayer.text = @"我的很长";
        _flGradientLayer.textFont = [UIFont boldSystemFontOfSize:17];
        _flGradientLayer.minGradientSection = 0.2;
    }
    return _flGradientLayer;
}

@end
