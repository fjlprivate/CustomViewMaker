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
#import "TCV_vmDataSource.h"

@interface TestCollectionView() <UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) CustomFlowLayout* flowlayout;
@property (nonatomic, strong) TCV_vmDataSource* dataSource;

@end

@implementation TestCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:HexColorTypeDarkCyan];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadSubviews];
    [self relayoutSubviews];
}

- (void) loadSubviews {
    [self.view addSubview:self.collectionView];
}
- (void) relayoutSubviews {
    CGRect frame = self.view.bounds;
    frame.origin.y = 64;
    frame.size.height -= frame.origin.y;
    self.collectionView.frame = frame;
}


#pragma mask 3 ,UICollectionViewDelegate,
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



#pragma mask 4 getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self.dataSource;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    }
    return _collectionView;
}

- (TCV_vmDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TCV_vmDataSource alloc] init];
    }
    return _dataSource;
}

- (CustomFlowLayout *)flowlayout {
    if (!_flowlayout) {
        _flowlayout = [[CustomFlowLayout alloc] initWithColumnCount:4 allItemsCount:self.dataSource.items.count];
    }
    return _flowlayout;
}

@end
