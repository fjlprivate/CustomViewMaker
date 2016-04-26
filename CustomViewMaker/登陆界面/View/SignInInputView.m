//
//  SignInInputView.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/14.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "SignInInputView.h"
#import "Masonry.h"
#import <ReactiveCocoa.h>


@interface SignInInputView()
@property (nonatomic, strong) CAShapeLayer* leftLayer;
@property (nonatomic, strong) CAShapeLayer* rightLayer;
@property (nonatomic, strong) UITextField* textField;

@end

@implementation SignInInputView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews];
    }
    return self;
}
- (void) addSubviews {
    [self.layer addSublayer:self.leftLayer];
    [self.layer addSublayer:self.rightLayer];
    [self addSubview:self.textField];
    [self addSubview:self.leftImageView];
}

- (void) viewOnProperties {
    RAC(self.textField, placeholder) = RACObserve(self, placeHold);
    RAC(self.rightLayer, fillColor) = RACObserve(self, rightTintColor);
    RAC(self.leftLayer, fillColor) = RACObserve(self, leftTintColor);

}
- (void)layoutSubviews {
    CGRect frame = self.bounds;
    CGFloat widthLeftLayer = frame.size.height;
    CGFloat widthRightLayer = frame.size.width - widthLeftLayer;
    CGFloat widthTextField = widthRightLayer;
    CGFloat heightView = frame.size.height;
    
    // left
    self.leftLayer.frame = CGRectMake(0, 0, widthLeftLayer, heightView);
    self.leftLayer.path = [self rectPathInRect:CGRectMake(0, 0, widthLeftLayer, heightView) leftOrRight:YES].CGPath;
//    self.leftLayer.fillColor = self.leftTintColor.CGColor;
    // right
    self.rightLayer.frame = CGRectMake(widthLeftLayer, 0, widthRightLayer, heightView);
    self.rightLayer.path = [self rectPathInRect:CGRectMake(0, 0, widthRightLayer, heightView) leftOrRight:NO].CGPath;
//    self.rightLayer.fillColor = self.rightTintColor.CGColor;
    // textField
//    self.textField.frame = CGRectMake(widthLeftLayer, 0, widthTextField, heightView);
//    self.textField.placeholder = self.placeHold;
    @weakify(self);
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_left).offset(widthLeftLayer);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(widthLeftLayer);
        make.right.equalTo(self.mas_right);
    }];
    
    
    [super layoutSubviews];
}

- (UIBezierPath*) rectPathInRect:(CGRect)rect leftOrRight:(BOOL)left{
    if (self.direction == SignInInputViewDirecitionUp) {
        if (left) {
            return [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
        } else {
            return [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
        }
    } else {
        if (left) {
            return [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
        } else {
            return [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
        }
    }
}


#pragma mask 4 getter
- (UIColor *)leftTintColor {
    if (!_leftTintColor) {
        _leftTintColor = [UIColor colorWithWhite:0.05 alpha:0.2];
    }
    return _leftTintColor;
}
- (UIColor *)rightTintColor {
    if (!_rightTintColor) {
        _rightTintColor = [UIColor colorWithWhite:0.4 alpha:0.2];
    }
    return _rightTintColor;
}
- (CAShapeLayer *)leftLayer {
    if (!_leftLayer) {
        _leftLayer = [CAShapeLayer layer];
    }
    return _leftLayer;
}
- (CAShapeLayer *)rightLayer {
    if (!_rightLayer) {
        _rightLayer = [CAShapeLayer layer];
    }
    return _rightLayer;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
        [_textField setLeftView:leftView];
        [_textField setLeftViewMode:UITextFieldViewModeAlways];
        _textField.textColor = [UIColor whiteColor];
    }
    return _textField;
}
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
    }
    return _leftImageView;
}

@end
