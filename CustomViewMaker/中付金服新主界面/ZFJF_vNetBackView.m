//
//  ZFJF_vNetBackView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/5.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_vNetBackView.h"
#import "UIColor+ColorWithHex.h"
#import "ZFJF_vmMainVCDatasource.h"


@interface ZFJF_vNetBackView()

@property (nonatomic, assign) NSInteger vCount;
@property (nonatomic, assign) NSInteger hCount;
@property (nonatomic, assign) BOOL hasBorder;
@property (nonatomic, strong) CAShapeLayer* shapeLayer;

@end

@implementation ZFJF_vNetBackView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _hCount = [ZFJF_vmMainVCDatasource mainDataSource].numberOfColumns;
        NSInteger itemsCount = [ZFJF_vmMainVCDatasource mainDataSource].items.count;
        _vCount = itemsCount % _hCount == 0 ? itemsCount / _hCount : itemsCount / _hCount + 1 ;
        _hasBorder = YES;
        [self.layer addSublayer:self.shapeLayer];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath* path = [UIBezierPath bezierPath];

    
    CGFloat wView = self.bounds.size.width;
    CGFloat hView = self.bounds.size.height;
    CGFloat uniteWidth = wView / self.hCount;
    
    
    // 绘制纵线条
    for (int i = 1; i < self.hCount; i++) {
        CGPoint upPoint = CGPointMake(uniteWidth * i, 0);
        CGPoint downPoint = CGPointMake(uniteWidth * i, hView);
        [path moveToPoint:upPoint];
        [path addLineToPoint:downPoint];
    }
    // 绘制横线条
    for (int i = 1; i < self.vCount; i++) {
        CGPoint leftPoint = CGPointMake(0, uniteWidth * i);
        CGPoint rightPoint = CGPointMake(wView, uniteWidth * i);
        [path moveToPoint:leftPoint];
        [path addLineToPoint:rightPoint];
    }
    
    // 绘制边框
    if (self.hasBorder) {
        CGPoint leftUpP = CGPointMake(0, 0);
        CGPoint leftDownP = CGPointMake(0, hView);
        CGPoint rightUpP = CGPointMake(wView, 0);
        CGPoint rightDownP = CGPointMake(wView, hView);
        [path moveToPoint:leftUpP];
        [path addLineToPoint:rightUpP];
        [path addLineToPoint:rightDownP];
        [path addLineToPoint:leftDownP];
    }
    
    [path closePath];

    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.strokeColor = self.borderLineColor.CGColor;
    self.shapeLayer.lineWidth = self.borderLineWidth;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
}



# pragma mask 4 getter
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}

- (UIColor *)borderLineColor {
    if (!_borderLineColor) {
        _borderLineColor = [UIColor colorWithHex:0xe0e0e0 alpha:1];
    }
    return _borderLineColor;
}
- (CGFloat)borderLineWidth {
    if (_borderLineWidth < 0.0001) {
        _borderLineWidth = 0.5f;
    }
    return _borderLineWidth;
}

@end
