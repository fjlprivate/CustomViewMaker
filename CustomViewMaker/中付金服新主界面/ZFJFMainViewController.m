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
#import <UINavigationBar+Awesome.h>

@interface ZFJFMainViewController ()
<UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView* collcetionView;
@property (nonatomic, strong) ZFJF_vCollectionFlowLayout* flowlayout;
@property (nonatomic, strong) UIBarButtonItem* billListBarItem;

@end

@implementation ZFJFMainViewController



# pragma mask 2 UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ZFJF_mMainVCCellItem* item = [[ZFJF_vmMainVCDatasource mainDataSource].items objectAtIndex:indexPath.row];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x12c4a3 alpha:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x27384b alpha:1]];
}

- (void) loadSubviews {
    [self.view addSubview:self.collcetionView];
    [self.navigationItem setRightBarButtonItem:self.billListBarItem];
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

- (UIBarButtonItem *)billListBarItem {
    if (!_billListBarItem) {
        UIButton* billListBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [billListBtn setTitle:[NSString fontAwesomeIconStringForEnum:FABars] forState:UIControlStateNormal];
        billListBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:24 scale:1]];
        [billListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [billListBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        _billListBarItem = [[UIBarButtonItem alloc] initWithCustomView:billListBtn];
    }
    return _billListBarItem;
}


@end
