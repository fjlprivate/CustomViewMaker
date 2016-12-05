//
//  ZFJF_vCollectionFlowLayout.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/2.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_vCollectionFlowLayout.h"
#import "ZFJF_vNetBackView.h"


@interface ZFJF_vCollectionFlowLayout()

@property (nonatomic, assign) NSInteger itemsCount;

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
    NSLog(@"------- prepareLayout");
    [self registerClass:[ZFJF_vNetBackView class] forDecorationViewOfKind:@"ZFJF_vNetBackView"];
}


/* 初始化layout的大小 */
- (CGSize)collectionViewContentSize {
    NSLog(@"------- collectionViewContentSize [%@]", NSStringFromCGSize(self.collectionView.bounds.size));
    CGSize size = self.collectionView.bounds.size;
    size.height = size.width/3.f * (self.itemsCount % 3 == 0 ? self.itemsCount / 3 : self.itemsCount / 3 + 1);
    return size;
}

/* 计算item的属性 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat width = [self collectionViewContentSize].width / 3.f;
    NSLog(@"--------item.width = [%lf]", width);
    attri.size = CGSizeMake(width, width);
    attri.center = CGPointMake((indexPath.row % 3 + 0.5) * width, (indexPath.row / 3 + 0.5) * width);
    return attri;
}

/* 计算decorationView的布局属性 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind
                                                                  atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attri = [UICollectionViewLayoutAttributes
                                               layoutAttributesForDecorationViewOfKind:elementKind
                                               withIndexPath:indexPath];
    attri.frame = self.collectionView.bounds;
    return attri;
}

/* 布局可视范围内的items+decorationView */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attris = [NSMutableArray array];
    
    // decorationView
    [attris addObject:[self layoutAttributesForDecorationViewOfKind:@"ZFJF_vNetBackView" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]];
    
    // items
    for (int i = 0; i < self.itemsCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [attris addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attris;
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
    
    //
    //    return YES;
}

@end
