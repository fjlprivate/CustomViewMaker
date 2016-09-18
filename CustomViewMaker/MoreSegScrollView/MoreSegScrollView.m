//
//  MoreSegScrollView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/18.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MoreSegScrollView.h"
#import "MSSV_itemView.h"


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
        
        
        self.minScale = 0.4;
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
    
    CGFloat itemWidth = self.bounds.size.width / 2;
    CGFloat itemHeight = self.bounds.size.height * 0.618;
    
    CGRect frame = CGRectMake(0, (self.bounds.size.height - itemHeight) * 0.5, itemWidth, itemHeight);
    for (UIView* itemView in self.itemViewList) {
        
        itemView.frame = frame;
        
        frame.origin.x += itemWidth;
    }
    
    self.scrollView.contentSize = CGSizeMake(itemWidth * self.itemViewList.count, self.bounds.size.height);
    
}



# pragma mask 2 UIScrollViewDelegate



# pragma mask 4 getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (NSMutableArray *)itemViewList {
    if (!_itemViewList) {
        _itemViewList = [NSMutableArray array];
        for (NSDictionary* node in self.segInfos) {
            MSSV_itemView* itemView = [[MSSV_itemView alloc] initWithFrame:CGRectZero];
            itemView.imageView.image = [UIImage imageNamed:[node objectForKey:@"imgName"]];
            itemView.titleLabel.text = [node objectForKey:@"title"];
            [_itemViewList addObject:itemView];
        }
    }
    return _itemViewList;
}




@end
