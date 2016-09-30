//
//  CoreAniLayer.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "CoreAniLayer.h"
#import <UIKit/UIKit.h>

@implementation CoreAniLayer

- (void)drawInContext:(CGContextRef)ctx {
    
    NSLog(@"---------scale[%lf]", self.scale);
    CGFloat radius = 30 * self.scale;
    
    CGFloat centerX = self.bounds.size.width * 0.5;
    CGFloat centerY = self.bounds.size.height * 0.5;
    
    
    UIBezierPath*  path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    [path closePath];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextFillPath(ctx);
    
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"scale"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

/*
- (instancetype)initWithLayer:(CoreAniLayer*)layer {
    self = [super initWithLayer:layer];
    if (self) {
        self.scale = layer.scale;
    }
    return self;
}
 */


@end
