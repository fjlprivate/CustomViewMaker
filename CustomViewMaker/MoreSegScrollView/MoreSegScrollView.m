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
#import <ReactiveCocoa.h>


@interface MoreSegScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray* itemViewList;

@end



@implementation MoreSegScrollView


- (instancetype)initWithSegInfos:(NSArray *)segInfos {
    self = [super init];
    if (self) {
        self.segInfos = [NSArray arrayWithArray:segInfos];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self loadSubviews];
        self.delegate = self;
    }
    return self;
}


- (void) loadSubviews {
    for (UIView* itemView in self.itemViewList) {
        [self addSubview:itemView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIView* itemView = [self.itemViewList objectAtIndex:0];
    if (self.bounds.size.width > 1 && itemView.frame.size.width < 1) {
        self.contentSize = CGSizeMake((self.itemSize.width - 10) * self.itemViewList.count + 10, self.bounds.size.height);
        self.contentInset = UIEdgeInsetsMake(0, self.itemSize.width * 0.5, 0, self.itemSize.width * 0.5);
        
        CGRect frame = CGRectMake(0, (self.bounds.size.height - self.itemSize.height) * 0.5, self.itemSize.width, self.itemSize.height);
        for (int i = 0; i < self.itemViewList.count; i++) {
            UIView* itemView = [self.itemViewList objectAtIndex:i];
            [itemView setFrame:frame];
            itemView.layer.cornerRadius = frame.size.height * 0.5;
            frame.origin.x += self.itemSize.width - 10;
        }
    }
}





# pragma mask 2 UITouch 

/* 点击切换元素 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    
    // 这个坐标系已经是 scrollView 的 contentSize 里面了
    CGPoint curPoint = [touch locationInView:self];
    
    UIView* touchedItemView = nil;
    
    for (UIView* itemView in self.itemViewList) {
        if (CGRectContainsPoint(itemView.frame, curPoint)) {
            touchedItemView = itemView;
            break;
        }
    }
    
    if (touchedItemView != nil) {
        CGPoint originOffset = self.contentOffset;
        originOffset.x += touchedItemView.center.x - self.contentOffset.x - self.bounds.size.width * 0.5;
        __weak typeof(self) wself = self;
        [UIView animateWithDuration:0.3 animations:^{
            wself.contentOffset = originOffset;
        }];
    }
}


# pragma mask 2 UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    for (UIView* itemView in self.itemViewList) {
        CGPoint itemCenterP = itemView.center;
        CGFloat curItemCenterX = itemCenterP.x - scrollView.contentOffset.x;
        
        CGFloat scale = 1 - ABS(curItemCenterX - self.bounds.size.width * 0.5) / (self.bounds.size.width * 0.5) * 0.35;
        scale = scale < 0.35 ? 0.35 : scale;
        scale = scale > 1 ? 1 : scale;
        
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


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    for (UIView* itemView in self.itemViewList) {
        if (itemView.center.x - self.contentOffset.x == self.bounds.size.width * 0.5) {
            self.curSegIndex = itemView.tag;
            break;
        }
    }
    NSLog(@"--------- 当前停止的index = [%d]", self.curSegIndex);
}



# pragma mask 4 getter

- (NSMutableArray *)itemViewList {
    if (!_itemViewList) {
        _itemViewList = [NSMutableArray array];
        for (int i = 0; i < self.segInfos.count; i ++) {
            NSDictionary* node = [self.segInfos objectAtIndex:i];
            MSSV_itemView* itemView = [[MSSV_itemView alloc] initWithFrame:CGRectZero];
            itemView.tag = i;
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
