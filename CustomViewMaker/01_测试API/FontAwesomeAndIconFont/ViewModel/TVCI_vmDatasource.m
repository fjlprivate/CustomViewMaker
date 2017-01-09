//
//  TVCI_vmDatasource.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/5.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_vmDatasource.h"
#import "TVCI_vHeaderView.h"
#import "TVCI_vCell.h"
#import "PublicHeader.h"



# define TVCI_HEIGHT_HEADERVIEW        44.f


@interface TVCI_vmDatasource()

@property (nonatomic, strong) TVCI_mDataList* dataList;

@end


@implementation TVCI_vmDatasource




- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        [RACObserve(self, curFontIndex) subscribeNext:^(id x) {
            @strongify(self);
            if ([[self curFontType] isEqualToString:TVCI_FONTNAME_AWESOME]) {
                self.numberOfSections = self.dataList.listAwesome.count;
                NSMutableArray* counts = [NSMutableArray array];
                for (TVCI_mNodeItems* items in self.dataList.listAwesome) {
                    [counts addObject:@(items.items.count)];
                }
                self.numbersOfItemsPerSec = [NSArray arrayWithArray:counts];
                NSMutableArray* heights = [NSMutableArray arrayWithCapacity:self.numberOfSections];
                for (int i = 0; i < self.numberOfSections; i++) {
                    [heights addObject:@(TVCI_HEIGHT_HEADERVIEW)];
                }
                self.heightsOfHeaderViews = [NSArray arrayWithArray:heights];
            } else {
                self.numberOfSections = self.dataList.listIconFont.count;
                NSMutableArray* counts = [NSMutableArray array];
                for (TVCI_mNodeItems* items in self.dataList.listIconFont) {
                    [counts addObject:@(items.items.count)];
                }
                self.numbersOfItemsPerSec = [NSArray arrayWithArray:counts];
                NSMutableArray* heights = [NSMutableArray arrayWithCapacity:self.numberOfSections];
                for (int i = 0; i < self.numberOfSections; i++) {
                    [heights addObject:@(TVCI_HEIGHT_HEADERVIEW)];
                }
                self.heightsOfHeaderViews = [NSArray arrayWithArray:heights];
            }
        }];
    }
    return self;
}


# pragma mask 2 UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UICollectionView* collectionView = (UICollectionView*)scrollView;
    
    CGFloat curOffsetY = collectionView.contentOffset.y;
    
}


# pragma mask 2 UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([[self curFontType] isEqualToString:TVCI_FONTNAME_AWESOME]) {
        return self.dataList.listAwesome.count;
    } else {
        return self.dataList.listIconFont.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([[self curFontType] isEqualToString:TVCI_FONTNAME_AWESOME]) {
        return [self.dataList.listAwesome objectAtIndex:section].items.count;
    } else {
        return [self.dataList.listIconFont objectAtIndex:section].items.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TVCI_vCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TVCI_vCell" forIndexPath:indexPath];
    if ([[self curFontType] isEqualToString:TVCI_FONTNAME_AWESOME]) {
        TVCI_mAwesome* awesome = (TVCI_mAwesome*)[[self.dataList.listAwesome objectAtIndex:indexPath.section].items objectAtIndex:indexPath.row];
        cell.iconLabel.text = awesome.text;
        cell.titleLabel.text = awesome.name;
        cell.iconLabel.font = awesome.font;
        cell.headLabel.text = [NSString stringWithFormat:@"%d", awesome.type];
    } else {
        TVCI_mIconFont* iconfont = (TVCI_mIconFont*)[[self.dataList.listIconFont objectAtIndex:indexPath.section].items objectAtIndex:indexPath.row];
        cell.iconLabel.text = iconfont.text;
        cell.titleLabel.text = iconfont.name;
        cell.iconLabel.font = iconfont.font;
        cell.headLabel.text = [NSString stringWithFormat:@"%x", iconfont.type];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TVCI_vHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"TVCI_vHeaderView" forIndexPath:indexPath];
    TVCI_mNodeItems* nodeItems = nil;
    if ([[self curFontType] isEqualToString:TVCI_FONTNAME_AWESOME]) {
        nodeItems = [self.dataList.listAwesome objectAtIndex:indexPath.section];
    } else {
        nodeItems = [self.dataList.listIconFont objectAtIndex:indexPath.section];
    }
    [headerView.titleBtn setTitle:nodeItems.title forState:UIControlStateNormal];
    return headerView;
}


# pragma mask 3 tools 

- (NSString*) curFontType {
    return [self.fontTypes objectAtIndex:self.curFontIndex];
}



# pragma mask 4 getter


- (NSArray *)fontTypes {
    if (!_fontTypes) {
        _fontTypes = @[TVCI_FONTNAME_AWESOME,TVCI_FONTNAME_ICONFONT];
    }
    return _fontTypes;
}


- (TVCI_mDataList *)dataList {
    if (!_dataList) {
        _dataList = [TVCI_mDataList new];
    }
    return _dataList;
}


@end
