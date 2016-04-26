//
//  TestCollectionView.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestCollectionView.h"
#import "CustomFlowLayout.h"
#import "Masonry.h"
#import "UIColor+ColorWithHex.h"
#import "CustomCollectionViewCell.h"

@interface TestCollectionView()
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation TestCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:HexColorTypeDarkCyan];
    [self.view addSubview:self.collectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self relayoutSubviews];
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void) relayoutSubviews {
    __weak typeof(self)wself = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wself.view.mas_centerY);
        make.left.equalTo(wself.view.mas_left).offset(30);
        make.right.equalTo(wself.view.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
}
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedIndex"]) {
        NSInteger oldIndex = [[change objectForKey:NSKeyValueChangeOldKey] integerValue];
        NSInteger newIndex = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        CGPoint curOffset = self.collectionView.contentOffset;
        if (labs(newIndex - oldIndex) != 0) {
            curOffset.x += (newIndex - oldIndex) * (self.collectionView.frame.size.width/5);
            [UIView animateWithDuration:0.2 animations:^{
                self.collectionView.contentOffset = curOffset;
            }];
        }
    }
    else if ([keyPath isEqualToString:@"contentOffset"]) {
        NSLog(@"contentOffset.x = [%lf]",[[change objectForKey:NSKeyValueChangeNewKey] CGPointValue].x);
    }
}


#pragma mask 3 UICollectionViewDataSource,
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%02ld",indexPath.item];
    return cell;
}

#pragma mask 3 ,UICollectionViewDelegate,
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"collectionView.contentOffset=[%@]",NSStringFromCGPoint(collectionView.contentOffset));
//    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.selectedIndex = indexPath.item;
}

#pragma mask 3 ,UICollectionViewDelegateFlowLayout


#pragma mask 4 getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CustomFlowLayout* flowLayout = [[CustomFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 30*2)/5, 30);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        NSLog(@"itemSize.width=[%lf]",flowLayout.itemSize.width);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.contentInset = UIEdgeInsetsMake(0, flowLayout.itemSize.width*2, 0, flowLayout.itemSize.width*2);
        
    }
    return _collectionView;
}


@end
