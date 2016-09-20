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

/* item视图组 */
@property (nonatomic, strong) NSMutableArray* itemViewList;

/* 每个item间的重叠: 减少item在缩放后的间隔 */
@property (nonatomic, assign) CGFloat MSSV_ITEM_INSET;

@end



@implementation MoreSegScrollView


- (instancetype)initWithSegInfos:(NSArray *)segInfos {
    self = [super init];
    if (self) {
        self.segInfos = [NSArray arrayWithArray:segInfos];
        self.MSSV_ITEM_INSET = 10.f;
        
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
    
    self.contentSize = CGSizeMake((self.itemSize.width - self.MSSV_ITEM_INSET) * self.itemViewList.count + self.MSSV_ITEM_INSET + (self.bounds.size.width - self.itemSize.width),
                                  self.bounds.size.height);

    // 滚动时也会引发layout, 所以控制第一次重新布局
    UIView* itemView = [self.itemViewList objectAtIndex:0];
    if (self.bounds.size.width > 1 && itemView.frame.size.width < 1) {
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}


- (void)updateConstraints {
    
    __weak typeof(self) wself = self;
    
    UIView* lastItemView = nil;
    for (int i = 0; i < self.itemViewList.count; i++) {
        UIView* itemView = [self.itemViewList objectAtIndex:i];
        
        // 布局
        [itemView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(wself.itemSize.width);
            make.height.mas_equalTo(wself.itemSize.height);
            make.centerY.mas_equalTo(wself.mas_centerY);
            if (lastItemView) {
                make.left.mas_equalTo(lastItemView.mas_right).offset(self.MSSV_ITEM_INSET);
            } else {
                make.centerX.mas_equalTo(wself.mas_left).offset(wself.bounds.size.width * 0.5);
            }
        }];
        itemView.layer.cornerRadius = self.itemSize.height * 0.5;
        
        lastItemView = itemView;
        
        // 计算缩放
        CGPoint itemCenterP = itemView.center;
        itemCenterP.x = self.bounds.size.width * 0.5 + (self.itemSize.width - self.MSSV_ITEM_INSET) * i;
        CGFloat curItemCenterX = itemCenterP.x - self.contentOffset.x;
        
        CGFloat scale = 1 - ABS(curItemCenterX - self.bounds.size.width * 0.5) / (self.bounds.size.width * 0.5) * 0.35;
        scale = scale < 0.35 ? 0.35 : scale;
        scale = scale > 1 ? 1 : scale;
        
        itemView.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    
    [super updateConstraints];
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

/* 滚动时进行缩放 */
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


/* 滚动停止更新索引 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    for (UIView* itemView in self.itemViewList) {
        if (itemView.center.x - self.contentOffset.x == self.bounds.size.width * 0.5) {
            self.curSegIndex = itemView.tag;
            break;
        }
    }
}



# pragma mask 4 getter

- (NSMutableArray *)itemViewList {
    if (!_itemViewList) {
        _itemViewList = [NSMutableArray array];
        for (int i = 0; i < self.segInfos.count; i ++) {
            NSDictionary* node = [self.segInfos objectAtIndex:i];
            MSSV_itemView* itemView = [[MSSV_itemView alloc] initWithFrame:CGRectZero];
            itemView.tag = i;
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
