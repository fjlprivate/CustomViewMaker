//
//  CustomFlowLayout.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* allElementsLayoutAttri = [super layoutAttributesForElementsInRect:rect];
    
    
    
    return allElementsLayoutAttri;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    return proposedContentOffset;
}

@end
