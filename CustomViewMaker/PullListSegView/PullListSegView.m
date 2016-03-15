//
//  PullListSegView.m
//  JLPay
//
//  Created by jielian on 16/3/3.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//


#import "PullListSegView.h"


@interface PullListSegView()
{
    CGFloat     animationDuration;
    NSInteger   iMaxDisplayCount;
    CGFloat     fWidthOfTri;
    CGFloat     fHeightOfTri;
}
@property (nonatomic, strong) CAShapeLayer* triShapeLayer;
@property (nonatomic, strong) CAShapeLayer* rectShapeLayer;
@end

@implementation PullListSegView

#pragma mask 1 public interface 
- (void)showAnimation {
    [self.tableView reloadData];
    [self setNeedsLayout];
    [self setNeedsDisplay];
    [self animationShow];
}
- (void)hiddenAnimation {
    [self animationHidden];
}
- (void) showWithCompletion:(void (^) (void))completion {
    [self.tableView reloadData];
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            completion();
        }
    }];

}
- (void) hideWithCompletion:(void (^) (void))completion {
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0;
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        if (finished) {
            self.transform = CGAffineTransformIdentity;
            completion();
        }
    }];
}



#pragma mask 3 private interface
// -- animation: show
- (void) animationShow {
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}
// -- animation: hidden
- (void) animationHidden {
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0;
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
    }];
}

#pragma mask 4 geter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorInset = UIEdgeInsetsMake(15, 0, 0, 15);
        _tableView.rowHeight = 37.f;
    }
    return _tableView;
}
- (CAShapeLayer *) triShapeLayer {
    if (!_triShapeLayer) {
        _triShapeLayer = [CAShapeLayer layer];
    }
    return _triShapeLayer;
}
- (CAShapeLayer *)rectShapeLayer {
    if (!_rectShapeLayer) {
        _rectShapeLayer = [CAShapeLayer layer];
    }
    return _rectShapeLayer;
}

- (UIColor *)tintColor {
    if (!_tintColor) {
        _tintColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    }
    return _tintColor;
}
- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor whiteColor];
    }
    return _textColor;
}

#pragma mask 0 生命周期,和布局
- (instancetype) init {
    self = [super init];
    if (self) {
        [self initialProperties];
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 1;
        [self loadSubViews];
    }
    return self;
}

- (void) initialProperties {
    animationDuration = 0.2;
    iMaxDisplayCount = 5;
    fWidthOfTri = 20.f;
    fHeightOfTri = 20.f * 2.f/3.f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = fHeightOfTri;
    NSInteger dataSourceCount = [self.tableView numberOfRowsInSection:0];
    if (dataSourceCount >= iMaxDisplayCount) {
        height += iMaxDisplayCount * self.tableView.rowHeight;
    } else {
        height += dataSourceCount * self.tableView.rowHeight;
    }
    self.layer.shadowColor = self.tintColor.CGColor;
    
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
    
    self.triShapeLayer.frame = CGRectMake((frame.size.width - fWidthOfTri)/2.f, 0, fWidthOfTri, fHeightOfTri);
    [self addPathToTriShapeLayer];
    
    self.rectShapeLayer.frame = CGRectMake(0, fHeightOfTri, frame.size.width, frame.size.height - fHeightOfTri);
    [self addPathToRectShapeLayer];
    
    frame.origin.x = 0;
    frame.origin.y = fHeightOfTri;
    frame.size.height -= fHeightOfTri;
    [self.tableView setFrame:frame];
}

- (void) loadSubViews {
    [self.layer addSublayer:self.triShapeLayer];
    [self.layer addSublayer:self.rectShapeLayer];
    [self addSubview:self.tableView];
}

- (void) addPathToTriShapeLayer {
    UIBezierPath* path = [UIBezierPath bezierPath];
    CGRect frame = self.triShapeLayer.frame;

    CGFloat centerX = frame.size.width/2.f;
    CGPoint triTopPoint = CGPointMake(centerX, 0);
    CGPoint triBottomLeftPoint = CGPointMake(0, fHeightOfTri);
    CGPoint triBottomRightPoint = CGPointMake(frame.size.width, fHeightOfTri);

    [path moveToPoint:triBottomLeftPoint];
    [path addLineToPoint:triTopPoint];
    [path addLineToPoint:triBottomRightPoint];
    
    self.triShapeLayer.fillColor = self.tintColor.CGColor;
    self.triShapeLayer.path = path.CGPath;
}
- (void) addPathToRectShapeLayer {
    CGRect frame = self.rectShapeLayer.bounds;
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5.f];
    self.rectShapeLayer.fillColor = self.tintColor.CGColor;
    self.rectShapeLayer.path = path.CGPath;
}


@end
