//
//  TriScrollSegmentView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/13.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TriScrollSegmentView.h"
#import "MSSV_itemView.h"
#import "UIColor+ColorWithHex.h"
#import "Masonry.h"



@interface TriScrollSegmentView() <UIScrollViewDelegate>

@property (nonatomic, strong) MSSV_itemView* leftItemView;

@property (nonatomic, strong) MSSV_itemView* midItemView;

@property (nonatomic, strong) MSSV_itemView* rightItemView;

@property (nonatomic, assign) BOOL scrollDirectionLeft;

@property (nonatomic, assign) CGPoint lastOffset;

@end




@implementation TriScrollSegmentView

- (instancetype)initWithSegInfos:(NSArray *)segInfos {
    self = [super init];
    if (self) {
        self.segInfos = segInfos;
        self.curSegIndex = 0;
        self.lastOffset = CGPointZero;
        [self loadSubviews];
        self.delegate = self;
    }
    return self;
}

- (void) loadSubviews {
    [self addSubview:self.leftItemView];
    [self addSubview:self.midItemView];
    [self addSubview:self.rightItemView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftItemView.backgroundColor = [UIColor colorWithHex:0xef454b];
    self.midItemView.backgroundColor = [UIColor colorWithHex:0x01abf0];
    self.rightItemView.backgroundColor = [UIColor colorWithHex:0x2da43a];
    self.contentSize = CGSizeMake(self.itemSize.width * 3, self.bounds.size.height);
    
    if (self.bounds.size.width > 1 && self.leftItemView.frame.size.width < 1) {
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    
}

- (void)updateConstraints {
    
    __weak typeof(self) wself = self;
    
    [self.leftItemView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(wself.itemSize.width);
        make.centerY.mas_equalTo(wself.mas_centerY);
        make.height.mas_equalTo(wself.itemSize.height);
    }];
    
    [self.midItemView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.leftItemView.mas_right);
        make.width.mas_equalTo(wself.leftItemView.mas_width);
        make.top.bottom.mas_equalTo(wself.leftItemView);
    }];
    
    [self.rightItemView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.midItemView.mas_right);
        make.width.mas_equalTo(wself.leftItemView.mas_width);
        make.top.bottom.mas_equalTo(wself.leftItemView);
    }];
    
    
    [super updateConstraints];
}



# pragma mask 2 UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateScrollDirection];
    if (self.scrollDirectionLeft) {
        if (self.contentOffset.x == self.itemSize.width) {
            CGPoint curOffset = self.contentOffset;
            curOffset.x = 0;
            self.contentOffset = curOffset;
        }
    } else {
        if (self.contentOffset.x == 0) {
            CGPoint curOffset = self.contentOffset;
            curOffset.x = self.itemSize.width;
            self.contentOffset = curOffset;
        }
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}







# pragma mask 3 private interfunctions

- (void) updateScrollDirection {
    self.scrollDirectionLeft = (self.lastOffset.x - self.contentOffset.x < 0);
    self.lastOffset = self.contentOffset;
}





# pragma mask 4 getter

- (MSSV_itemView *)leftItemView {
    if (!_leftItemView) {
        _leftItemView = [[MSSV_itemView alloc] init];
        _leftItemView.titleLabel.text = @"1";
    }
    return _leftItemView;
}

- (MSSV_itemView *)midItemView {
    if (!_midItemView) {
        _midItemView = [[MSSV_itemView alloc] init];
        _midItemView.titleLabel.text = @"2";
    }
    return _midItemView;
}

- (MSSV_itemView *)rightItemView {
    if (!_rightItemView) {
        _rightItemView = [[MSSV_itemView alloc] init];
        _rightItemView.titleLabel.text = @"3";

    }
    return _rightItemView;
}

@end
