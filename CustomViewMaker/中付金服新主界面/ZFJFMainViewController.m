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

@interface ZFJFMainViewController ()
<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView* collcetionView;
@property (nonatomic, strong) UICollectionViewFlowLayout* flowlayout;
@property (nonatomic, strong) ZFJF_vmMainVCDatasource* dataSource;

@end

@implementation ZFJFMainViewController


# pragma mask 2 UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ScreenWidth / 3.1;
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


# pragma mask 2 UICollectionViewDelegate



# pragma mask 3 界面布局

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"中付金服";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    [self layoutSubviews];
}

- (void) loadSubviews {
    [self.view addSubview:self.collcetionView];
}

- (void) layoutSubviews {
    CGFloat heightCollectionV = ScreenHeight * 0.67;
    CGRect frame = CGRectMake(0, ScreenHeight - heightCollectionV, ScreenWidth, heightCollectionV);
    self.collcetionView.frame = frame;
}




# pragma mask 4 getter

- (UICollectionView *)collcetionView {
    if (!_collcetionView) {
        _collcetionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowlayout];
        _collcetionView.dataSource = self.dataSource;
        _collcetionView.delegate = self;
        _collcetionView.backgroundColor = [UIColor whiteColor];
        [_collcetionView registerClass:[ZFJF_mainVCCell class] forCellWithReuseIdentifier:@"ZFJF_mainVCCell"];
    }
    return _collcetionView;
}

- (UICollectionViewFlowLayout *)flowlayout {
    if (!_flowlayout) {
        _flowlayout = [[UICollectionViewFlowLayout alloc] init];
        _flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [_flowlayout registerClass:nil forDecorationViewOfKind:nil];
    }
    return _flowlayout;
}

- (ZFJF_vmMainVCDatasource *)dataSource {
    if (!_dataSource) {
        _dataSource = [ZFJF_vmMainVCDatasource new];
    }
    return _dataSource;
}


@end
