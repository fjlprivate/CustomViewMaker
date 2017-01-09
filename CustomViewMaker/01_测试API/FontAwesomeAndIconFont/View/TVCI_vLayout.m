//
//  TVCI_vLayout.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_vLayout.h"

/* collectionView 的宽度 */
#define TVCI_CONTENT_WIDTH          self.collectionView.frame.size.width


@implementation TVCI_vLayout


- (void)prepareLayout {
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize {
    /* 总和: 所有头视图高度 */
    CGFloat allHeightOfHeaders = 0;
    for (int i = 0; i < self.numberOfSections; i ++) {
        allHeightOfHeaders += [self heightOfHeaderViewAtSection:i];
    }
    /* 总和: 所有分部高度 */
    CGFloat allHeightOfItems = 0;
    for (int i = 0; i < self.numberOfSections; i ++) {
        allHeightOfItems += [self heightOfAllItemsAtSection:i];
    }
    return CGSizeMake(TVCI_CONTENT_WIDTH,
                      allHeightOfHeaders + allHeightOfItems);
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* attris = [NSMutableArray array];
    for (int section = 0; section < self.numberOfSections; section++) {
        [attris addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]]];
        for (int row = 0; row < [self numberOfItemsAtSection:section]; row++) {
            [attris addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]]];
        }
    }
    return attris;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat startOffsetY = 0;
    for (int i = 0; i < indexPath.section; i++) {
        startOffsetY += [self heightOfHeaderViewAtSection:i];
        startOffsetY += [self heightOfAllItemsAtSection:i];
    }
    startOffsetY += [self heightOfHeaderViewAtSection:indexPath.section] * 1;


    attri.size = self.itemSize;
    attri.center = CGPointMake(self.itemSize.width * (indexPath.row % self.numberOfColumns + 0.5),
                               startOffsetY + self.itemSize.height * (indexPath.row / self.numberOfColumns + 0.5));
    return attri;
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* attri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    attri.size = CGSizeMake(TVCI_CONTENT_WIDTH, [self heightOfHeaderViewAtSection:indexPath.section]);
    CGFloat curOffsetY = 0;
    for (int i = 0; i < indexPath.section; i++) {
        curOffsetY += [self heightOfHeaderViewAtSection:i];
        curOffsetY += [self heightOfAllItemsAtSection:i];
    }
    curOffsetY += [self heightOfHeaderViewAtSection:indexPath.section] * 0.5;
    attri.center = CGPointMake(TVCI_CONTENT_WIDTH * 0.5, curOffsetY);
    return attri;
}


# pragma mask 2 tools 

/* 总高度: 指定分部的所有items */
- (CGFloat) heightOfAllItemsAtSection:(NSInteger)section {
    NSInteger numberOfItems = [[self.numbersOfItemsPerSec objectAtIndex:section] integerValue];
    return self.itemSize.height * (numberOfItems % self.numberOfColumns > 0 ? numberOfItems/self.numberOfColumns + 1 : numberOfItems/self.numberOfColumns);
}

/* 高度: 指定分部的头视图 */
- (CGFloat ) heightOfHeaderViewAtSection:(NSInteger)section {
    return [[self.heightsOfHeaderViews objectAtIndex:section] floatValue];
}

/* 个数: 指定的分部 */
- (NSInteger) numberOfItemsAtSection:(NSInteger)section {
    return [[self.numbersOfItemsPerSec objectAtIndex:section] integerValue];
}


@end
