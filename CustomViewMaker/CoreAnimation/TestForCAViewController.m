//
//  TestForCAViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForCAViewController.h"
#import "CoreAniLayer.h"
#import "UIColor+ColorWithHex.h"
#import "Masonry.h"
#import "NSString+Custom.h"



@interface TestForCAViewController ()

@property (nonatomic, strong) CoreAniLayer* coreAniLayer;
@property (nonatomic, strong) UIButton* basicAniBtn;
@property (nonatomic, strong) UIButton* keyframeAniBtn;


@end



@implementation TestForCAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CoreAnimation";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    [self initialFrames];
}

- (void) loadSubviews {
    [self.view addSubview:self.basicAniBtn];
    [self.view addSubview:self.keyframeAniBtn];
    [self.view.layer addSublayer:self.coreAniLayer];
}

- (void) initialFrames {
    CGFloat width = 100;
    CGFloat heightBtn = 30;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake((screenWidth - width) * 0.5, 64 + 15, width, width);
    
    self.coreAniLayer.frame = frame;
    self.coreAniLayer.cornerRadius = width * 0.5;
    
    
    frame.origin.x = 0;
    frame.size.width = screenWidth;
    frame.origin.y += frame.size.height + 20;
    frame.size.height = heightBtn;
    self.basicAniBtn.frame = frame;
    
    frame.origin.y += frame.size.height + 10;
    self.keyframeAniBtn.frame = frame;
    
}



# pragma mask 2 IBAction

// basicAnimation
- (IBAction) clickedBasicAnimationBtn:(UIButton*)sender {
    CABasicAnimation* basicAnimation = [CABasicAnimation animationWithKeyPath:@"scale.x"];
    
}

- (IBAction) clickedKeyframeAnimationBtn:(id)sender {
    CAKeyframeAnimation* keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"scale"];
    
    
    
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    
    keyframeAnimation.values = [self animationValues:@(2) toValue:@(1) usingSpringWithDamping:3 initialSpringVelocity:30 duration:2];
    //keyframeAnimation.values = @[@0.1, @0.5, @0.3, @0.8, @1.5];
    //keyframeAnimation.keyTimes = @[@0.1, @0.2, @0.4, @0.7, @1];
    keyframeAnimation.duration = 2.f;
    [self.coreAniLayer addAnimation:keyframeAnimation forKey:@"keyframeAnimation"];
    
}


# pragma mask -- 阻尼动画

// 阻尼动画
-(NSMutableArray *) animationValues:(id)fromValue
                            toValue:(id)toValue
             usingSpringWithDamping:(CGFloat)damping
              initialSpringVelocity:(CGFloat)velocity
                           duration:(CGFloat)duration {
    
    
    //60个关键帧
    NSInteger numOfPoints  = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfPoints];
    for (NSInteger i = 0; i < numOfPoints; i++) {
        [values addObject:@(0.0)];
    }
    
    //差值
    CGFloat d_value = [toValue floatValue] - [fromValue floatValue];
    
    for (NSInteger point = 0; point<numOfPoints; point++) {
        
        CGFloat x = ((CGFloat)point / ( CGFloat)(numOfPoints - 1)) * 1.4;
        
        CGFloat dampingRatio = pow(M_E, -damping * x) * cos(velocity * x);
        
        /* 区间是0-1.3 */
        CGFloat value = [toValue floatValue] - d_value * dampingRatio; // y = 1-e^{-5x} * cos(30x)
        
        values[point] = @(value);
    }
    
    return values;
    
}



# pragma mask 4 getter

- (CoreAniLayer *)coreAniLayer {
    if (!_coreAniLayer) {
        _coreAniLayer = [CoreAniLayer layer];
        //_coreAniLayer.backgroundColor = [UIColor orangeColor].CGColor;
        _coreAniLayer.contentsScale = [UIScreen mainScreen].scale;
        _coreAniLayer.masksToBounds = YES;
    }
    return _coreAniLayer;
}

- (UIButton *)basicAniBtn {
    if (!_basicAniBtn) {
        _basicAniBtn = [UIButton new];
        [_basicAniBtn setTitle:@"basicAnimation" forState:UIControlStateNormal];
        [_basicAniBtn setTitleColor:[UIColor colorWithHex:0x27384b] forState:UIControlStateNormal];
        [_basicAniBtn setTitleColor:[UIColor colorWithHex:0x27384b alpha:0.5] forState:UIControlStateHighlighted];
        [_basicAniBtn addTarget:self action:@selector(clickedBasicAnimationBtn:) forControlEvents:UIControlEventTouchUpInside];
        _basicAniBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _basicAniBtn;
}

- (UIButton *)keyframeAniBtn {
    if (!_keyframeAniBtn) {
        _keyframeAniBtn = [UIButton new];
        [_keyframeAniBtn setTitle:@"keyframeAnimation" forState:UIControlStateNormal];
        [_keyframeAniBtn setTitleColor:[UIColor colorWithHex:0x27384b] forState:UIControlStateNormal];
        [_keyframeAniBtn setTitleColor:[UIColor colorWithHex:0x27384b alpha:0.5] forState:UIControlStateHighlighted];
        [_keyframeAniBtn addTarget:self action:@selector(clickedKeyframeAnimationBtn:) forControlEvents:UIControlEventTouchUpInside];
        _keyframeAniBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _keyframeAniBtn;
}

@end
