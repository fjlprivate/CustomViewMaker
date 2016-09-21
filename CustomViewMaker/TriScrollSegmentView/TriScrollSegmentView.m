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

@property (nonatomic, strong) MSSV_itemView* itemView0;

@property (nonatomic, strong) MSSV_itemView* itemView1;

@property (nonatomic, strong) MSSV_itemView* itemView2;


@property (nonatomic, assign) CGPoint lastOffset;

@end




@implementation TriScrollSegmentView

- (instancetype)initWithSegInfos:(NSArray *)segInfos {
    self = [super init];
    if (self) {
        self.segInfos = [NSArray arrayWithArray:segInfos];
        self.curSegIndex = 0;
        [self loadSubviews];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.delegate = self;
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentSize = CGSizeMake(self.itemSize.width * 3, self.bounds.size.height);
    
    if (self.bounds.size.width > 1 && self.itemView0.frame.size.width < 1) {
        
        CGPoint curOffset = self.contentOffset;
        curOffset.x = self.itemSize.width * 0.5;
        self.contentOffset = curOffset;
        [self reloadData];
    }
    
}


- (void)updateConstraints {
    __weak typeof(self) wself = self;
    
    [self.itemView0 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(wself.itemSize.width);
        make.centerY.mas_equalTo(wself.mas_centerY);
        make.height.mas_equalTo(wself.itemSize.height);
    }];
    
    [self.itemView1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.itemView0.mas_right);
        make.width.mas_equalTo(wself.itemSize.width);
        make.centerY.mas_equalTo(wself.mas_centerY);
        make.height.mas_equalTo(wself.itemSize.height);
    }];
    
    [self.itemView2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.itemView1.mas_right);
        make.width.mas_equalTo(wself.itemSize.width);
        make.centerY.mas_equalTo(wself.mas_centerY);
        make.height.mas_equalTo(wself.itemSize.height);
    }];
    
    self.itemView0.layer.cornerRadius = self.itemSize.height * 0.5;
    self.itemView1.layer.cornerRadius = self.itemSize.height * 0.5;
    self.itemView2.layer.cornerRadius = self.itemSize.height * 0.5;

    
    [super updateConstraints];
}


# pragma mask 2 UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint curOffset = self.contentOffset;
    if (self.contentOffset.x > self.itemSize.width) {
        self.curSegIndex = (self.curSegIndex == self.segInfos.count - 1) ? (0) : (self.curSegIndex + 1);
        curOffset.x = 0;
    }
    else if (self.contentOffset.x < 0) {
        self.curSegIndex = (self.curSegIndex == 0) ? (self.segInfos.count - 1) : (self.curSegIndex - 1);
        curOffset.x = self.itemSize.width;
    }
    
    if (!CGPointEqualToPoint(self.contentOffset, curOffset)) {
        self.contentOffset = curOffset;
    }
    
    [self makeTransformsForItemViews];
    
    [self reloadData];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        CGPoint curOffset = self.contentOffset;
        curOffset.x = self.itemSize.width * 0.5;
        __weak typeof(self) wself = self;
        [UIView animateWithDuration:0.2 animations:^{
            wself.contentOffset = curOffset;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint curOffset = self.contentOffset;
    curOffset.x = self.itemSize.width * 0.5;
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.2 animations:^{
        wself.contentOffset = curOffset;
    } completion:^(BOOL finished) {
        
    }];
}



# pragma mask 3 private interfunctions

- (void) loadSubviews {
    [self addSubview:self.itemView0];
    [self addSubview:self.itemView1];
    [self addSubview:self.itemView2];
}


- (void) reloadData {
    // 重载数据
    
    NSDictionary* node0 = [self.segInfos objectAtIndex:(self.curSegIndex == 0 ? self.segInfos.count - 1: self.curSegIndex - 1)];
    NSDictionary* node1 = [self.segInfos objectAtIndex:self.curSegIndex];
    NSDictionary* node2 = [self.segInfos objectAtIndex:(self.curSegIndex == self.segInfos.count - 1 ? 0: self.curSegIndex + 1)];
    
    self.itemView0.imageView.image = [UIImage imageNamed:[node0 objectForKey:@"imgName"]];
    self.itemView0.titleLabel.text = [node0 objectForKey:@"title"];
    self.itemView0.titleLabel.textColor = [node0 objectForKey:@"titleColor"];
    self.itemView0.backgroundColor = [node0 objectForKey:@"backColor"];

    self.itemView1.imageView.image = [UIImage imageNamed:[node1 objectForKey:@"imgName"]];
    self.itemView1.titleLabel.text = [node1 objectForKey:@"title"];
    self.itemView1.titleLabel.textColor = [node1 objectForKey:@"titleColor"];
    self.itemView1.backgroundColor = [node1 objectForKey:@"backColor"];

    self.itemView2.imageView.image = [UIImage imageNamed:[node2 objectForKey:@"imgName"]];
    self.itemView2.titleLabel.text = [node2 objectForKey:@"title"];
    self.itemView2.titleLabel.textColor = [node2 objectForKey:@"titleColor"];
    self.itemView2.backgroundColor = [node2 objectForKey:@"backColor"];

    
}

- (void) makeTransformsForItemViews {
    CGFloat contentCenterX = self.contentOffset.x + self.bounds.size.width * 0.5;
    CGFloat denomenater = self.bounds.size.width * 1.1;
    
    
    // itemView0
    CGFloat ratioScale0 = 1 - ABS(self.itemSize.width * 0.5 - contentCenterX) / denomenater;
    CGAffineTransform transformScale0 = CGAffineTransformMakeScale(ratioScale0, ratioScale0);
    self.itemView0.transform = transformScale0;
    
    // itemView1
    CGFloat ratioScale1 = 1 - ABS(self.itemSize.width * 1.5 - contentCenterX) / denomenater;
    CGAffineTransform transformScale1 = CGAffineTransformMakeScale(ratioScale1, ratioScale1);
    self.itemView1.transform = transformScale1;


    // itemView2
    CGFloat ratioScale2 = 1 - ABS(self.itemSize.width * 2.5 - contentCenterX) / denomenater;
    CGAffineTransform transformScale2 = CGAffineTransformMakeScale(ratioScale2, ratioScale2);
    self.itemView2.transform = transformScale2;
    
}




# pragma mask 4 getter

- (MSSV_itemView *)itemView0 {
    if (!_itemView0) {
        _itemView0 = [[MSSV_itemView alloc] init];
    }
    return _itemView0;
}

- (MSSV_itemView *)itemView1 {
    if (!_itemView1) {
        _itemView1 = [[MSSV_itemView alloc] init];
    }
    return _itemView1;
}

- (MSSV_itemView *)itemView2 {
    if (!_itemView2) {
        _itemView2 = [[MSSV_itemView alloc] init];
    }
    return _itemView2;
}


@end
