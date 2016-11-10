//
//  TFCVC_MainViewController.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TFCVC_MainViewController.h"
#import "PublicHeader.h"
#import "TFCVC_childViewController.h"
#import "MLStepSegmentView.h"


@interface TFCVC_MainViewController ()


@property (nonatomic, strong) MLStepSegmentView* stepSegView;


@property (nonatomic, strong) NSArray* titles;
@property (nonatomic, strong) NSArray* childrenVCs;

@property (nonatomic, strong) NSArray* colors;

@property (nonatomic, assign) NSInteger curIndexVC;

@end



@implementation TFCVC_MainViewController



- (void) addKVO {
    @weakify(self);
    [RACObserve(self.stepSegView, itemSelected) subscribeNext:^(id index) {
        @strongify(self);
        NSInteger targetIndex = [index integerValue];
        if (targetIndex == self.curIndexVC) {
            return ;
        }
        else if (targetIndex < self.curIndexVC) {
            UIViewController* curChildVC = [self.childrenVCs objectAtIndex:self.curIndexVC];
            UIViewController* targetChildVC = [self.childrenVCs objectAtIndex:targetIndex];
            [self transitionFromViewController:curChildVC toViewController:targetChildVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                @strongify(self);
                [curChildVC.view.layer removeAllAnimations];
                CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
                animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
                animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.view.frame.size.width, 0, 0)];
                animation.duration = 0.3;
                [curChildVC.view.layer addAnimation:animation forKey:nil];
                
            } completion:^(BOOL finished) {
                
            }];
        }
        else {
            UIViewController* curChildVC = [self.childrenVCs objectAtIndex:self.curIndexVC];
            UIViewController* targetChildVC = [self.childrenVCs objectAtIndex:targetIndex];
            [self transitionFromViewController:curChildVC toViewController:targetChildVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                @strongify(self);
                [curChildVC.view.layer removeAllAnimations];
                CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
                animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
                animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-self.view.frame.size.width, 0, 0)];
                animation.duration = 0.3;
                [curChildVC.view.layer addAnimation:animation forKey:nil];
            } completion:^(BOOL finished) {
                
            }];
        }
        
        
        self.curIndexVC = [index integerValue];
    }];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialDatas];
    [self loadSubviews];
    [self layoutSubviews];
    [self addKVO];
}

- (void) initialDatas {
    for (TFCVC_childViewController* vc in self.childrenVCs) {
        [self addChildViewController:vc];
    }
    self.curIndexVC = 0;
}

- (void) loadSubviews {
    [self.view addSubview:self.stepSegView];
    TFCVC_childViewController* vc = [self.childrenVCs firstObject];
    [self.view addSubview:vc.view];
}

- (void) layoutSubviews {
    
    [self.stepSegView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64 + 5);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(34);
    }];
    
    CGRect frame = CGRectMake(30,
                              64 + 5 + 34 + 10,
                              self.view.frame.size.width - 60,
                              self.view.frame.size.height - (64 + 5 + 34 + 10 + 10));
    for (TFCVC_childViewController* vc in self.childrenVCs) {
        vc.view.frame = frame;
    }
}



# pragma mask 4 getter

- (NSArray *)colors {
    if (!_colors) {
        _colors = @[[UIColor colorWithHex:0x00bb9c alpha:1],
                    [UIColor colorWithHex:0xffcc00 alpha:1],
                    [UIColor colorWithHex:0x27384b alpha:1]];
    }
    return _colors;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"VC1", @"VC2", @"VC3"];
    }
    return _titles;
}

- (MLStepSegmentView *)stepSegView {
    if (!_stepSegView) {
        _stepSegView = [[MLStepSegmentView alloc] initWithTitles:self.titles];
        _stepSegView.stepIsSingle = YES;
        _stepSegView.itemSelected = 0;
    }
    return _stepSegView;
}

- (NSArray *)childrenVCs {
    if (!_childrenVCs) {
        NSMutableArray* children = [NSMutableArray array];
        
        for (int i = 0; i < self.titles.count; i++) {
            TFCVC_childViewController* childvc = [[TFCVC_childViewController alloc] init];
            childvc.view.backgroundColor = [self.colors objectAtIndex:i];
            childvc.view.layer.cornerRadius = 20;
            childvc.textLabel.text = [self.titles objectAtIndex:i];
            childvc.tag = i;
            [children addObject:childvc];
        }
        
        _childrenVCs = [NSArray arrayWithArray:children];
    }
    return _childrenVCs;
}





@end
