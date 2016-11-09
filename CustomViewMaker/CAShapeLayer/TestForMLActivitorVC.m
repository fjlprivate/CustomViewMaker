//
//  TestForMLActivitorVC.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForMLActivitorVC.h"
#import "MLActivitor.h"
#import "Masonry.h"
#import "UIColor+ColorWithHex.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "NSString+Custom.h"

@interface TestForMLActivitorVC ()

@property (nonatomic, strong) MLActivitor* activitor;
@property (nonatomic, strong) UIBarButtonItem* handleBarBtn;

@property (nonatomic, strong) CAShapeLayer* shapeLayer;

@end



@implementation TestForMLActivitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    [self layoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.activitor show];
}

- (void) loadSubviews {
    [self.view addSubview:self.activitor];
    [self.view.layer addSublayer:self.shapeLayer];
    [self.navigationItem setRightBarButtonItem:self.handleBarBtn];
}

- (void) layoutSubviews {
    __weak typeof(self) wself = self;
    [self.activitor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(wself.view);
        make.width.height.mas_equalTo(100);
    }];
    
    
    UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 60, 60)];
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.frame = CGRectMake(100, 68, 60, 60);
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
//    self.shapeLayer.anchorPoint = CGPointMake((100 + 30)/width, (68 + 30)/height);
//    self.shapeLayer.position = CGPointMake((100 + 30), (68 + 30));
}



- (void) makeAnimationFor {
    [self.shapeLayer removeAllAnimations];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0)];
    [self.shapeLayer addAnimation:animation forKey:nil];
    
}

# pragma mask 2 IBAction

- (IBAction) clickedHandle:(id)sender {
    NSString* curTitle = [(UIButton*)self.handleBarBtn.customView titleForState:UIControlStateNormal];
    if ([curTitle isEqualToString:[NSString fontAwesomeIconStringForEnum:FAPlay]]) {
        [(UIButton*)self.handleBarBtn.customView setTitle:[NSString fontAwesomeIconStringForEnum:FAPause] forState:UIControlStateNormal];
    } else {
        [(UIButton*)self.handleBarBtn.customView setTitle:[NSString fontAwesomeIconStringForEnum:FAPlay] forState:UIControlStateNormal];
    }
    [self.activitor show];
    
    [self makeAnimationFor];
}


# pragma mask 4 getter
- (MLActivitor *)activitor {
    if (!_activitor) {
        _activitor = [[MLActivitor alloc] init];
//        _activitor.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:0.9];
        _activitor.tintColor = [UIColor colorWithHex:0x00bb9c alpha:1];
    }
    return _activitor;
}

- (UIBarButtonItem *)handleBarBtn {
    if (!_handleBarBtn) {
        UIButton* handleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [handleBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAPlay] forState:UIControlStateNormal];
        [handleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        handleBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:15];
        [handleBtn addTarget:self action:@selector(clickedHandle:) forControlEvents:UIControlEventTouchUpInside];
        _handleBarBtn = [[UIBarButtonItem alloc] initWithCustomView:handleBtn];
    }
    return _handleBarBtn;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
//        _shapeLayer.fillColor = [UIColor colorWithHex:0x00bb9c alpha:1].CGColor;
    }
    return _shapeLayer;
}

@end
