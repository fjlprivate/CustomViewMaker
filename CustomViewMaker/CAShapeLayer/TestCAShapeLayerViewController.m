//
//  TestCAShapeLayerViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/11.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestCAShapeLayerViewController.h"
#import "Masonry.h"

@interface TestCAShapeLayerViewController()
{
    CGPoint startPoint;
}
@property (nonatomic, strong) CAShapeLayer* testShapeLayer;

@property (nonatomic, strong) CAShapeLayer* checkShapeLayer;
@end

@implementation TestCAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:(8*16+10+1)/255.f blue:(8*16+10+1)/255.f alpha:1.f];
    self.title = @"shapeLayer";
    [self addSubViews];
    [self relayoutSubViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(moveShapeLayerToMax) userInfo:nil repeats:NO];
}
- (void) moveShapeLayerToMax {
    self.testShapeLayer.strokeEnd = 1;
    self.checkShapeLayer.strokeEnd = 1;
}

- (void) addSubViews {
    [self.view.layer addSublayer:self.testShapeLayer];
    [self.view.layer addSublayer:self.checkShapeLayer];
}
- (void) relayoutSubViews {
    
    
    self.checkShapeLayer.frame = CGRectMake(0, 0, 100, 100);
    self.checkShapeLayer.position = CGPointMake(self.view.center.x, 64+50);
    [self addPathIntoCheckShapeLayer:self.checkShapeLayer];
    
    self.testShapeLayer.frame = CGRectMake(0, 0, 100, 100);
    self.testShapeLayer.position = self.view.center;
    [self addCirclePathIntoShapeLayer:self.testShapeLayer];
}

- (void) addCirclePathIntoShapeLayer:(CAShapeLayer*)shapeLayer {
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds];
    shapeLayer.path = circlePath.CGPath;
}

- (void) addPathIntoCheckShapeLayer:(CAShapeLayer*)shapeLayer {
    CGRect rect = shapeLayer.bounds;
    CGFloat insetHorizontal = rect.size.width * 1.f/4.5;
//    CGFloat unitLength = (rect.size.width - insetHorizontal*2)/3.f;
//    CGFloat insetVertical = (rect.size.height - unitLength*2)/2.f;
//    CGPoint rightStartPoint = CGPointMake(insetHorizontal, insetVertical + unitLength);
//    CGPoint rightMidPoint = CGPointMake(insetHorizontal + unitLength, insetVertical + unitLength*2);
//    CGPoint rightEndPoint = CGPointMake(insetHorizontal + unitLength*3, insetVertical);
//    
    UIBezierPath* path = [UIBezierPath bezierPath];
//    [path moveToPoint:rightStartPoint];
//    [path addLineToPoint:rightMidPoint];
//    [path addLineToPoint:rightEndPoint];
//    shapeLayer.path = path.CGPath;
    
    CGPoint wrongUpStartPoint = CGPointMake(insetHorizontal, insetHorizontal);
    CGPoint wrongUpEndPoint = CGPointMake(rect.size.width - insetHorizontal, rect.size.height - insetHorizontal);
    CGPoint wrongDownStartPoint = CGPointMake(insetHorizontal, rect.size.height - insetHorizontal);
    CGPoint wrongDownEndPoint = CGPointMake(rect.size.width - insetHorizontal, insetHorizontal);
    [path moveToPoint:wrongUpStartPoint];
    [path addLineToPoint:wrongUpEndPoint];
    [path moveToPoint:wrongDownStartPoint];
    [path addLineToPoint:wrongDownEndPoint];
    shapeLayer.path = path.CGPath;
}


#pragma mask 2 touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    self.testShapeLayer.strokeEnd = 0;
    self.checkShapeLayer.strokeEnd = 0;
    startPoint = [touch locationInView:self.view];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:self.view];
    CGFloat movedY = curPoint.y - startPoint.y;
    CGFloat movedX = curPoint.x - startPoint.x;
    if (movedY < 0) {
        movedY = 0;
    }
    if (movedX < 0) {
        movedX = 0;
    }
    CGFloat maxHeight = self.view.frame.size.height - 64;
    self.testShapeLayer.strokeEnd = movedY/maxHeight;
    self.checkShapeLayer.strokeEnd = movedX/self.view.frame.size.width;
}


#pragma mask 4 getter 
- (CAShapeLayer *)testShapeLayer {
    if (!_testShapeLayer) {
        _testShapeLayer = [CAShapeLayer layer];
        _testShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _testShapeLayer.strokeColor = [UIColor blueColor].CGColor;
        _testShapeLayer.lineWidth = 2.f;
        _testShapeLayer.lineCap = @"round";
        _testShapeLayer.strokeStart = 0;
        _testShapeLayer.strokeEnd = 0;
    }
    return _testShapeLayer;
}

- (CAShapeLayer *)checkShapeLayer {
    if (!_checkShapeLayer) {
        _checkShapeLayer = [CAShapeLayer layer];
        _checkShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _checkShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _checkShapeLayer.lineWidth = 4.f;
        _checkShapeLayer.lineCap = @"round";
        _checkShapeLayer.strokeStart = 0;
        _checkShapeLayer.strokeEnd = 1;
    }
    return _checkShapeLayer;
}
@end
