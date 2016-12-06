//
//  ZFJFMainViewController.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/1.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJFMainViewController.h"
#import "ZFJF_vmMainVCDatasource.h"
#import "PublicHeader.h"
#import "ZFJF_mainVCCell.h"
#import "ZFJF_vCollectionFlowLayout.h"
#import "ZFJF_vHeaderView.h"

@interface ZFJFMainViewController ()
<UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView* collcetionView;
@property (nonatomic, strong) ZFJF_vCollectionFlowLayout* flowlayout;

@end

@implementation ZFJFMainViewController



# pragma mask 2 UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZFJF_mMainVCCellItem* item = [[ZFJF_vmMainVCDatasource mainDataSource].items objectAtIndex:indexPath.row];
    NSLog(@"----------------点击了item:[%@]", item.itemTitle);
}


# pragma mask 3 界面布局

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"中付金服";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadSubviews];
    [self layoutSubviews];
}

- (void) loadSubviews {
    [self.view addSubview:self.collcetionView];
}

- (void) layoutSubviews {
    CGRect frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
    self.collcetionView.frame = frame;
}




# pragma mask 4 getter

- (UICollectionView *)collcetionView {
    if (!_collcetionView) {
        _collcetionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowlayout];
        _collcetionView.dataSource = [ZFJF_vmMainVCDatasource mainDataSource];
        _collcetionView.delegate = self;
        _collcetionView.backgroundColor = [UIColor colorWithHex:0xffffff alpha:1];
        [_collcetionView registerClass:[ZFJF_mainVCCell class] forCellWithReuseIdentifier:@"ZFJF_mainVCCell"];
        [_collcetionView registerClass:[ZFJF_vHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZFJF_vHeaderView"];
    }
    return _collcetionView;
}


- (ZFJF_vCollectionFlowLayout *)flowlayout {
    if (!_flowlayout) {
        _flowlayout = [[ZFJF_vCollectionFlowLayout alloc] initWithItemsCount:[ZFJF_vmMainVCDatasource mainDataSource].items.count];
        _flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowlayout;
}



@end
