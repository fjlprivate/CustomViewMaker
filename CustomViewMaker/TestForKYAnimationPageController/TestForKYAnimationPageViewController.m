//
//  TestForKYAnimationPageViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/28.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForKYAnimationPageViewController.h"
#import <KYAnimatedPageControl.h>
#import "UIColor+ColorWithHex.h"
#import "DampingView.h"
#import <KYSpringLayerAnimation.h>
#import "Masonry.h"
#import "UIColor+ColorWithHex.h"




@interface TestForKYAnimationPageViewController () <UIScrollViewDelegate, CAAnimationDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;



@property (nonatomic, strong) KYAnimatedPageControl* pageController;


@property (nonatomic, strong) DampingView* dampingView;

@property (nonatomic, assign) CGPoint originPosition;
@property (nonatomic, assign) CGPoint lastMovedP;


@property (nonatomic, strong) UIButton* startDampingAniBtn;


@end




@implementation TestForKYAnimationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"阻尼动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageController];
    self.scrollView.pagingEnabled = YES;
    
    [self.view addSubview:self.dampingView];
    self.originPosition = self.dampingView.layer.position;
    
    UIView* lineView = [UIView new];
    [self.view addSubview:lineView];
    lineView.backgroundColor = [UIColor grayColor];
    __weak typeof (self) wself = self;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(wself.dampingView);
        make.bottom.mas_equalTo(wself.dampingView.mas_top).offset(-10);
        make.height.mas_equalTo(2);
    }];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat duration = 1.5f;
    NSArray* animationYValues = [self animationValues:@(self.dampingView.layer.position.y + 100)
                                              toValue:@(self.dampingView.layer.position.y)
                               usingSpringWithDamping:3
                                initialSpringVelocity:30
                                             duration:duration];
    
    
    CAKeyframeAnimation* keyanimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    keyanimation.values = animationYValues;
    keyanimation.duration = duration;
    
    //[self.dampingView.layer addAnimation:keyanimation forKey:@"ssss"];
    

}




# pragma mask UITouch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    self.lastMovedP = [touch locationInView:self.view];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:self.view];
    CGFloat offsetX = curPoint.x - self.lastMovedP.x;
    CGFloat offsetY = curPoint.y - self.lastMovedP.y;

    CABasicAnimation* basicAniX = [CABasicAnimation animationWithKeyPath:@"position.x"];
    basicAniX.byValue = @(offsetX);
    
    CABasicAnimation* basicAniY = [CABasicAnimation animationWithKeyPath:@"position.y"];
    basicAniY.byValue = @(offsetY);
    
    CAAnimationGroup* aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[basicAniX, basicAniY];
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;

    //[self.dampingView.layer addAnimation:aniGroup forKey:@"ddddddd"];

    
    CGPoint newerPosition = self.dampingView.layer.position;
    newerPosition.x += offsetX;
    newerPosition.y += offsetY;
    
    
    //self.dampingView.layer.position = newerPosition;
    self.lastMovedP = curPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:self.view];
    CGFloat offsetX = curPoint.x - self.lastMovedP.x;
    CGFloat offsetY = curPoint.y - self.lastMovedP.y;

    CGFloat duration = 1.5f;
    NSInteger damping = 3;
    NSInteger velocity = 30;
    
    // x
    NSArray* xValues = [self animationValues:@(self.originPosition.x + offsetX) toValue:@(self.originPosition.x) usingSpringWithDamping:damping initialSpringVelocity:velocity duration:duration];
    CAKeyframeAnimation* xKeyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    xKeyFrameAni.values = xValues;
    xKeyFrameAni.duration = duration;
    
    // y
    NSArray* yValues = [self animationValues:@(self.originPosition.y + offsetY) toValue:@(self.originPosition.y) usingSpringWithDamping:damping initialSpringVelocity:velocity duration:duration];
    CAKeyframeAnimation* yKeyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    yKeyFrameAni.values = yValues;
    yKeyFrameAni.duration = duration;
    
    
    CAAnimationGroup* aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[xKeyFrameAni, yKeyFrameAni];
    aniGroup.duration = duration;
    aniGroup.delegate = self;
    
    //[self.dampingView.layer addAnimation:aniGroup forKey:@"soidjfo"];
    
}

# pragma mask CAAnimationDeledate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self.dampingView.layer removeAllAnimations];
        //self.dampingView.layer.position = self.originPosition;
    }
}




# pragma mask 3 给layer添加抖动动画效果

- (void) addAnimationOnLayer:(CALayer*)layer {
    CAKeyframeAnimation *animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.5f;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.values = [NSArray arrayWithObjects:   	// i.e., Rotation values for the 3 keyframes, in RADIANS
                        [NSNumber numberWithFloat:0.0 * M_PI],
                        [NSNumber numberWithFloat:0.75 * M_PI],
                        [NSNumber numberWithFloat:1.5 * M_PI], nil];
    animation.keyTimes = [NSArray arrayWithObjects:     // Relative timing values for the 3 keyframes
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:.5],
                          [NSNumber numberWithFloat:1.0], nil];
    animation.timingFunctions = [NSArray arrayWithObjects:
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],	// from keyframe 1 to keyframe 2
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], nil];	// from keyframe 2 to keyframe 3
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [layer addAnimation:animation forKey:nil];
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
        
        CGFloat x = ((CGFloat)point / ( CGFloat)(numOfPoints - 1)) * 1.25;
        
        CGFloat dampingRatio = pow(M_E, -damping * x) * cos(velocity * x);
        
        /* 区间是0-1.3 */
        CGFloat value = [toValue floatValue] - d_value * dampingRatio; // y = 1-e^{-5x} * cos(30x)
        NSLog(@"---------dampingRatio[%lf], x[%lf]", dampingRatio, x);

        values[point] = @(value);
    }
    
    return values;
    
}



# pragma mask UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"scrollViewDidScroll");

    //Indicator动画
    [self.pageController.indicator animateIndicatorWithScrollView:scrollView andIndicator:self.pageController];
    
    if (scrollView.dragging || scrollView.isDecelerating || scrollView.tracking) {
        //背景线条动画
        [self.pageController.pageControlLine animateSelectedLineWithScrollView:scrollView];
    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    self.pageController.indicator.lastContentOffset = scrollView.contentOffset.x;
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"--------scrollViewWillBeginDecelerating");
    [self.pageController.indicator restoreAnimation:@(1.0/self.pageController.pageCount)];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.pageController.indicator.lastContentOffset = scrollView.contentOffset.x;
}






# pragma mask 4 getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat width = self.view.frame.size.width - 40;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 64, width, 100)];
        _scrollView.delegate = self;
        
        
        for (int i = 0; i < 10; i++) {
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0, width, 100)];
            label.backgroundColor = [UIColor colorWithRed:i * 25/255.f green:i* 25/255.f blue:i* 25/255.f alpha:1];
            label.textColor = i < 5 ? [UIColor whiteColor]:[UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@"%d", i];
            [_scrollView addSubview:label];
        }
        _scrollView.contentSize = CGSizeMake(width * 10, 100);
        
        
    }
    return _scrollView;
}


- (KYAnimatedPageControl *)pageController {
    if (!_pageController) {
        _pageController = [[KYAnimatedPageControl alloc] initWithFrame:CGRectMake(20, 64 + 120, self.view.frame.size.width - 40, 50)];
        _pageController.pageCount = 10;
        _pageController.unSelectedColor = [UIColor colorWithHex:0xeeeeee];
        _pageController.selectedColor = [UIColor colorWithHex:0xef454b];
        _pageController.bindScrollView = self.scrollView;
        _pageController.shouldShowProgressLine = YES;
        _pageController.indicatorStyle = IndicatorStyleGooeyCircle;
        _pageController.indicatorSize = 25;
        
    }
    return _pageController;
}


- (DampingView *)dampingView {
    if (!_dampingView) {
        CGFloat width = 60;
        _dampingView = [[DampingView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - width)/2,
                                                                    (self.view.frame.size.height - 64 - 120 - 50 - width)/2 + 234 ,
                                                                     width, width)];
        _dampingView.backgroundColor = [UIColor orangeColor];
        _dampingView.layer.cornerRadius = width * 0.5;
    }
    return _dampingView;
}

- (UIButton *)startDampingAniBtn {
    if (!_startDampingAniBtn) {
        _startDampingAniBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 40)];
        [_startDampingAniBtn setTitle:@"启动阻尼动画" forState:UIControlStateNormal];
        [_startDampingAniBtn setTitleColor:[UIColor colorWithHex:0x27384b] forState:UIControlStateNormal];
        [_startDampingAniBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return _startDampingAniBtn;
}



@end
