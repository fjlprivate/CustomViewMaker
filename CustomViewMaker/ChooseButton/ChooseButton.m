//
//  ChooseButton.m
//  JLPay
//
//  Created by jielian on 16/3/3.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ChooseButton.h"
#import "DirectionView.h"
#import "Masonry.h"

static NSString* const kKVOChooseDirection = @"direction";

@interface ChooseButton()
{
    CGFloat animationDuration;
}
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) DirectionView* directionView;

@end

@implementation ChooseButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialProperties];
        [self loadSubViews];
        [self addObserver:self forKeyPath:kKVOChooseDirection options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
- (void)dealloc {
    [self removeObserver:self forKeyPath:kKVOChooseDirection];
}

- (void) initialProperties {
    animationDuration = 0.15;
}
- (void) loadSubViews {
    [self addSubview:self.lineView];
    [self addSubview:self.directionView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect textFrame = self.titleLabel.frame;
    CGFloat heightDirection = self.frame.size.height * 1.f/5.f;
    CGFloat widthDirection = heightDirection * 3.f/2.f;
    CGFloat heightLine = 0.6;
    
    __weak typeof(self) wself = self;
    if (self.chooseButtonType == ChooseButtonTypeUnderLine) {
        self.backgroundColor = [UIColor clearColor];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(textFrame.size.width, heightLine));
            make.left.equalTo(wself.mas_left);
            make.bottom.equalTo(wself.mas_bottom);
        }];
    }
    [self.directionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(widthDirection, heightDirection));
        make.centerY.equalTo(wself.mas_centerY);
        make.centerX.equalTo(wself.mas_right).offset(-24);
    }];
    
    // 设置颜色
    if (self.direction == ChooseDirectionUp) {
        [self setTitleColor:self.selectedColor forState:UIControlStateNormal];
        [self.directionView setBackGColor:self.selectedColor];
    }
    else if (self.direction == ChooseDirectionDown) {
        [self setTitleColor:self.nomalColor forState:UIControlStateNormal];
        [self.directionView setBackGColor:self.nomalColor];
    }
}


#pragma mask 1 KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:kKVOChooseDirection]) {
        __weak typeof(self) wself = self;
        NSInteger curDirection = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (curDirection == ChooseDirectionUp) {
            [wself setTitleColor:wself.selectedColor forState:UIControlStateNormal];
            [wself.directionView setBackGColor:wself.selectedColor];

            [UIView animateWithDuration:animationDuration animations:^{
                wself.directionView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
        else if (curDirection == ChooseDirectionDown) {
            [wself setTitleColor:wself.nomalColor forState:UIControlStateNormal];
            [wself.directionView setBackGColor:wself.nomalColor];

            [UIView animateWithDuration:animationDuration animations:^{
                wself.directionView.transform = CGAffineTransformIdentity;
            }];
        }
    }
}

#pragma mask 4 getter
- (DirectionView *)directionView {
    if (!_directionView ) {
        _directionView = [[DirectionView alloc] initWithFrame:CGRectZero];
        _directionView.backGColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
    return _directionView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
    return _lineView;
}
- (UIColor *)nomalColor {
    if (!_nomalColor) {
        _nomalColor = [UIColor colorWithWhite:0.2 alpha:1];

    }
    return _nomalColor;
}
- (UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = [UIColor blueColor];
    }
    return _selectedColor;
}

@end
