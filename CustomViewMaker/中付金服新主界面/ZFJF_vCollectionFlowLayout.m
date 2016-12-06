//
//  ZFJF_vCollectionFlowLayout.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/2.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_vCollectionFlowLayout.h"
#import "ZFJF_vNetBackView.h"
#import "ZFJF_vmMainVCDatasource.h"


@interface ZFJF_vCollectionFlowLayout()

@property (nonatomic, assign) NSInteger itemsCount;

@property (nonatomic, assign) CGFloat heightHeaderView;

@property (nonatomic, strong) ZFJF_vNetBackView* backView;

@end

@implementation ZFJF_vCollectionFlowLayout


# pragma mask 3 初始化

- (instancetype)initWithItemsCount:(NSInteger)itemsCount {
    self = [super init];
    if (self) {
        _itemsCount = itemsCount;
    }
    return self;
}


/* 注册背景视图 */
- (void)prepareLayout {
    [super prepareLayout];
    
    if (!self.backView.superview) {
        [self.collectionView addSubview:self.backView];
    }
    CGSize viewSize = [self collectionViewContentSize];
    self.backView.frame = CGRectMake(0, self.heightHeaderView, viewSize.width, viewSize.height - self.heightHeaderView);
}


/* 初始化layout的大小 */
- (CGSize)collectionViewContentSize {
    CGSize size = self.collectionView.bounds.size;
    NSInteger numberColumn = [ZFJF_vmMainVCDatasource mainDataSource].numberOfColumns;
    CGFloat allItemsHeight = size.width/numberColumn * (self.itemsCount % numberColumn == 0 ? self.itemsCount / numberColumn : self.itemsCount / numberColumn + 1);
    self.heightHeaderView = size.height * 0.4;
    size.height = allItemsHeight + self.heightHeaderView;
    return size;
}

/* 计算item的属性 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberColumn = [ZFJF_vmMainVCDatasource mainDataSource].numberOfColumns;

    UICollectionViewLayoutAttributes* attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat width = [self collectionViewContentSize].width / numberColumn;
    attri.size = CGSizeMake(width, width);
    attri.center = CGPointMake((indexPath.row % numberColumn + 0.5) * width, self.heightHeaderView + (indexPath.row / numberColumn + 0.5) * width);
    return attri;
}

/* 计算header的属性 */
- (UICollectionViewLayoutAttributes*) layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* headerAttri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat width = self.collectionView.bounds.size.width;
    headerAttri.frame = CGRectMake(0, 0, width, self.heightHeaderView);
    
    return headerAttri;
}

/* 布局可视范围内的items+decorationView */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attris = [NSMutableArray array];
    
    // header
    [attris addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]];
    
    // items
    for (int i = 0; i < self.itemsCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [attris addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attris;
}


# pragma mask 4 getter

- (ZFJF_vNetBackView *)backView {
    if (!_backView) {
        _backView = [[ZFJF_vNetBackView alloc] initWithFrame:CGRectZero];
    }
    return _backView;
}

@end
