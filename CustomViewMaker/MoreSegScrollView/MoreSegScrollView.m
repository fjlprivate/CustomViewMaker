//
//  MoreSegScrollView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/18.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MoreSegScrollView.h"
#import "MSSV_itemView.h"
#import "UIColor+ColorWithHex.h"
#import "Masonry.h"


@interface MoreSegScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong) NSMutableArray* itemViewList;


@end




@implementation MoreSegScrollView


- (instancetype)initWithSegInfos:(NSArray *)segInfos {
    self = [super init];
    if (self) {
        self.segInfos = [NSArray arrayWithArray:segInfos];
        [self loadSubviews];
        
    }
    return self;
}


- (void) loadSubviews {
    [self addSubview:self.scrollView];
    for (UIView* itemView in self.itemViewList) {
        [self.scrollView addSubview:itemView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    
    
    self.scrollView.contentSize = CGSizeMake((self.itemSize.width - 10) * self.itemViewList.count + 10, self.bounds.size.height);
    self.scrollView.contentInset = UIEdgeInsetsMake(0, self.itemSize.width * 0.5, 0, self.itemSize.width * 0.5);
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}


- (void)updateConstraints {
    
    __weak typeof(self) wself = self;
    UIView* lastView = nil;
    for (int i = 0; i < self.itemViewList.count; i++) {
        UIView* itemView = [self.itemViewList objectAtIndex:i];
        [itemView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(wself.itemSize.width);
            make.height.mas_equalTo(wself.itemSize.height);
            make.centerY.mas_equalTo(wself.scrollView.mas_centerY);
            
            if (lastView == nil) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(lastView.mas_right).offset(-10);
            }
            
        }];
        itemView.layer.cornerRadius = self.itemSize.height * 0.5;
        
        lastView = itemView;
    }
    
    
    [super updateConstraints];
}


# pragma mask 2 UITouch 

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:self.scrollView];
    
    
    UIView* touchedItemView = nil;
    
    for (UIView* itemView in self.itemViewList) {
        CGRect frame = itemView.frame;
        frame.origin.x -= self.scrollView.contentOffset.x;
        if (CGRectContainsPoint(frame, curPoint)) {
            touchedItemView = itemView;
            break;
        }
    }
    
    NSLog(@"======点击事件, 被点击的cell:[%@]", touchedItemView);
    if (touchedItemView != nil) {
        CGRect toScrolledRect = self.scrollView.bounds;
        toScrolledRect.origin.x = self.scrollView.contentOffset.x + (touchedItemView.center.x - (self.scrollView.contentOffset.x + self.scrollView.bounds.size.width * 0.5));
        toScrolledRect.origin.x = touchedItemView.center.x - self.scrollView.bounds.size.width * 0.5;
        [self.scrollView scrollRectToVisible:toScrolledRect animated:YES];
    }
    
}


# pragma mask 2 UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    for (UIView* itemView in self.itemViewList) {
        CGPoint itemCenterP = itemView.center;
        CGFloat curItemCenterX = itemCenterP.x - scrollView.contentOffset.x;
        
        CGFloat scale = 1 - ABS(curItemCenterX - self.bounds.size.width * 0.5) / (self.bounds.size.width * 0.5) * 0.35;
        
        itemView.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    
}


/* 计算停止点为最近的 item.center */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat centerX = targetContentOffset->x + scrollView.frame.size.width * 0.5;
    
    CGPoint nearestItemCenterP = ((UIView*)[self.itemViewList objectAtIndex:0]).center;
    
    for (UIView* itemView in self.itemViewList) {
        CGPoint itemCenter = itemView.center;
        
        if (ABS(itemCenter.x - centerX) < ABS(nearestItemCenterP.x - centerX)) {
            nearestItemCenterP = itemCenter;
        }
    }
    
    targetContentOffset->x += (nearestItemCenterP.x - centerX);
    
}




# pragma mask 4 getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (NSMutableArray *)itemViewList {
    if (!_itemViewList) {
        _itemViewList = [NSMutableArray array];
        for (NSDictionary* node in self.segInfos) {
            MSSV_itemView* itemView = [[MSSV_itemView alloc] initWithFrame:CGRectZero];
            itemView.layer.cornerRadius = 10;
            itemView.backgroundColor = [node objectForKey:@"backColor"];
            itemView.imageView.image = [UIImage imageNamed:[node objectForKey:@"imgName"]];
            itemView.titleLabel.text = [node objectForKey:@"title"];
            itemView.titleLabel.textColor = [node objectForKey:@"titleColor"];
            [_itemViewList addObject:itemView];
        }
    }
    return _itemViewList;
}




@end
