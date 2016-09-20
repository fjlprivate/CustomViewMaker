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
        self.MSSV_ITEM_INSET = 0.f;
        
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
    }
    
    [self makeTransformsForItems];
    
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
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            wself.contentOffset = originOffset;
        } completion:^(BOOL finished) {
            wself.curSegIndex = touchedItemView.tag;
        }];
        
    }
}


# pragma mask 2 UIScrollViewDelegate

/* 滚动时进行缩放 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self makeTransformsForItems];
}


/* 计算停止点为最近的 item.center */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // 滚动视图的屏幕中点
    CGFloat centerX = targetContentOffset->x + scrollView.frame.size.width * 0.5;
    
    CGPoint nearestItemCenterP = ((UIView*)[self.itemViewList objectAtIndex:0]).center;
    
    // 扫描并取出离当前滚动视图的屏幕中点最近的item
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
    UIView* nearestView = [self.itemViewList firstObject];
    CGFloat curCenterXOffset = self.contentOffset.x + self.bounds.size.width * 0.5;
    
    for (UIView* itemView in self.itemViewList) {
        if (ABS(itemView.center.x - curCenterXOffset) < ABS(nearestView.center.x - curCenterXOffset)) {
            nearestView = itemView;
        }
    }
    self.curSegIndex = nearestView.tag;
}


# pragma mask 3 transforms

/* 对所有items进行缩放和位移 */
- (void) makeTransformsForItems {
    for (int i = 0; i < self.itemViewList.count; i++) {
        UIView* itemView = [self.itemViewList objectAtIndex:i];
        
        /* 计算缩放和位移 */
        CGPoint itemCenterP = itemView.center;
        itemCenterP.x = self.bounds.size.width * 0.5 + (self.itemSize.width - self.MSSV_ITEM_INSET) * i;
        CGFloat curItemCenterX = itemCenterP.x - self.contentOffset.x;
        /* item中点相对中点的偏移比例: 越近越小,min(0) */
        CGFloat scaleCenterXOffset = ABS(curItemCenterX - self.bounds.size.width * 0.5) / (self.bounds.size.width * 0.5);
        
        // 缩放
        CGFloat scale = 1 - scaleCenterXOffset * 0.3;
        scale = scale > 1 ? 1 : scale;
        CGAffineTransform scaleTrans = CGAffineTransformMakeScale(scale, scale);
        
        // 计算位移
        CGAffineTransform translateTrans = CGAffineTransformMakeTranslation(0, scaleCenterXOffset * (self.bounds.size.height * 0.5 - self.itemSize.height * 0.5));
        
        
        itemView.transform = CGAffineTransformConcat(scaleTrans, translateTrans);
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
