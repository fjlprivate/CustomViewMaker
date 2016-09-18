//
//  TriScrollSegmentView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/13.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TriScrollSegmentView.h"
#import "TriSegView_cell.h"
#import "UIColor+ColorWithHex.h"
#import "HJCarouselViewLayout.h"



@interface TriScrollSegmentView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>






@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) HJCarouselViewLayout* carouseLayout;

@end


@implementation TriScrollSegmentView

- (instancetype)initWithSegInfos:(NSArray *)segInfos {
    self = [super init];
    if (self) {
        self.segInfos = segInfos;
        self.curSegIndex = 0;
        
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    self.carouseLayout.itemSize = CGSizeMake(self.bounds.size.width * 0.46, self.bounds.size.height * 0.5);
}




# pragma mask 2 UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.segInfos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TriSegView_cell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    /*
     NSDictionary<
     imgName: <NSString> 图片名
     title: <NSString> 标题
     titleColor: <UIColor>  标题色
     backColor: <UIColor>  背景色
     >
     */
    NSDictionary* node = [self.segInfos objectAtIndex:indexPath.row];
    
    cell.contentView.backgroundColor = [node objectForKey:@"backColor"];
    cell.iconImgView.image = [UIImage imageNamed:[node objectForKey:@"imgName"]];
    cell.titleLabel.text = [node objectForKey:@"title"];
    cell.titleLabel.textColor = [node objectForKey:@"titleColor"];
    
    return cell;
}

# pragma mask 2 UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = cell.contentView.frame;
    cell.contentView.layer.cornerRadius = frame.size.height * 0.5;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath* curIndexPath = [self curIndexPath];
    if (curIndexPath.row == indexPath.row) {
        return YES;
    } else {
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        return NO;
    }
}







- (NSIndexPath*) curIndexPath {
    NSArray* visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath* curIndexPath = nil;
    NSInteger curZIndex = NSIntegerMin;
    
    for (NSIndexPath* indexPath in visibleIndexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes* attris = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        printf("\n  indexPath.row = [%d], curZIndex = [%d], attris.zIndex = [%d]\n", indexPath.row, curZIndex, attris.zIndex);
        if (!curIndexPath || curZIndex < attris.zIndex) {
            curIndexPath = indexPath;
            curZIndex = attris.zIndex;
            printf("    new curIndexPath.row = [%d]\n", curIndexPath.row);
        }
    }
    
    return curIndexPath;
}



# pragma mask 4 getter



- (HJCarouselViewLayout *)carouseLayout {
    if (!_carouseLayout) {
        _carouseLayout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimCoverFlow];
        _carouseLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _carouseLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.carouseLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TriSegView_cell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        _collectionView.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}



@end
