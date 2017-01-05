//
//  CustomFlowLayout.m
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "CustomFlowLayout.h"
#import "PublicHeader.h"


@interface CustomFlowLayout()

/* x位置组: 每列 */
@property (nonatomic, strong) NSArray* originXArray;

/* y位置组: 每列 */
@property (nonatomic, strong) NSMutableArray* originYArray;

/* height组: 所有items */
@property (nonatomic, strong) NSArray* heightAllItemsArray;

/* 间隔 */
@property (nonatomic, assign) CGFloat padding;

/* 单位宽度 */
@property (nonatomic, assign) CGFloat uniteWidth;

@end


@implementation CustomFlowLayout


# pragma mask 2 重载

- (void)prepareLayout {
    [super prepareLayout];
}


- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, [[self.originYArray objectAtIndex:[self indexOfMaxOriginY]] floatValue]);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    self.originYArray = nil;
    
    NSMutableArray* attris = [NSMutableArray arrayWithCapacity:self.numberOfItems];
    for (int i = 0 ; i < self.numberOfItems; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [attris addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attris;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes* attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger index = [self indexOfMinOriginY];
    
    CGFloat curOriginX = [[self.originXArray objectAtIndex:index] floatValue];
    CGFloat curOriginY = [[self.originYArray objectAtIndex:index] floatValue];
    CGFloat curWidth = self.uniteWidth;
    CGFloat curHeight = [[self.heightAllItemsArray objectAtIndex:indexPath.row] floatValue];
    attri.frame = CGRectMake(curOriginX, curOriginY, curWidth, curHeight);
    
    /* 更新y坐标数组 */
    curOriginY += curHeight + self.padding;
    [self.originYArray setObject:@(curOriginY) atIndexedSubscript:index];
    
    return attri;
}


# pragma mask 3 tools

/* 最小y坐标的索引 */
- (NSInteger) indexOfMinOriginY {
    NSInteger index = 0;
    CGFloat minOriginY = [[self.originYArray firstObject] floatValue];
    for (NSInteger i = 0; i < self.originYArray.count; i++) {
        CGFloat curOriginY = [[self.originYArray objectAtIndex:i] floatValue];
        if (curOriginY < minOriginY) {
            index = i;
            minOriginY = curOriginY;
        }
    }
    return index;
}

/* 最大y坐标的索引 */
- (NSInteger) indexOfMaxOriginY {
    NSInteger index = 0;
    CGFloat maxOriginY = [[self.originYArray firstObject] floatValue];
    for (NSInteger i = 0; i < self.originYArray.count; i++) {
        CGFloat curOriginY = [[self.originYArray objectAtIndex:i] floatValue];
        if (curOriginY > maxOriginY) {
            index = i;
            maxOriginY = curOriginY;
        }
    }
    return index;
}


# pragma mask 4 getter
- (CGFloat)padding {
    return ScreenWidth * 2/320.f;
}

- (CGFloat)uniteWidth {
    return (self.collectionView.bounds.size.width - self.padding * (self.numberOfColumns - 1))/self.numberOfColumns;
}

- (NSArray *)originXArray {
    if (!_originXArray) {
        NSMutableArray* array = [NSMutableArray arrayWithCapacity:self.numberOfColumns];
        for (int i = 0 ; i < self.numberOfColumns; i ++) {
            [array addObject:@((self.uniteWidth + self.padding) * i)];
        }
        _originXArray = [NSArray arrayWithArray:array];
    }
    return _originXArray;
}


- (NSMutableArray *)originYArray {
    if (!_originYArray) {
        _originYArray = [NSMutableArray arrayWithCapacity:self.numberOfColumns];
        for (int i = 0 ; i < self.numberOfColumns; i ++) {
            [_originYArray addObject:@(0)];
        }
    }
    return _originYArray;
}

- (NSArray *)heightAllItemsArray {
    if (!_heightAllItemsArray) {
        NSMutableArray* array = [NSMutableArray arrayWithCapacity:self.numberOfItems];
        CGFloat minHeight = 100;
        NSInteger maxHeight = 200;
        for (int i = 0 ; i < self.numberOfItems; i ++) {
            CGFloat height = arc4random() % maxHeight;
            if (height < minHeight) {
                height = minHeight;
            }
            [array addObject:@(height)];
        }
        _heightAllItemsArray = [NSArray arrayWithArray:array];
    }
    return _heightAllItemsArray;
}

@end
