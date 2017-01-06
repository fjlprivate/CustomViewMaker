//
//  TVCI_vLayout.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_vLayout.h"

@implementation TVCI_vLayout


- (void)prepareLayout {
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize {
    CGFloat uniteWidth = self.collectionView.frame.size.width / self.numberOfColumns;
    NSInteger numberOflines = self.numberOfAllItems % self.numberOfColumns > 0 ? self.numberOfAllItems/self.numberOfColumns + 1 : self.numberOfAllItems/self.numberOfColumns;
    return CGSizeMake(self.collectionView.frame.size.width,
                      numberOflines * uniteWidth);
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* attris = [NSMutableArray array];
    for (int i = 0; i < self.numberOfAllItems; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes* attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attris addObject:attri];
    }
    return attris;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat uniteWidth = self.collectionView.frame.size.width / self.numberOfColumns;
    attri.size = CGSizeMake(uniteWidth, uniteWidth);
    attri.center = CGPointMake(uniteWidth * (indexPath.row % self.numberOfColumns + 0.5),
                               uniteWidth * (indexPath.row / self.numberOfColumns + 0.5));
    return attri;
}




@end
