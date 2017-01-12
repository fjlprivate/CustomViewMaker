//
//  TestForIconFont.m
//  CustomViewMaker
//
//  Created by jielian on 16/6/17.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForIconFont.h"
#import "UIColor+ColorWithHex.h"
#import <UINavigationBar+Awesome.h>
#import "TVCI_vCell.h"
#import "TVCI_vHeaderView.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "IconFont_dataSourceFilter.h"
#import "MFontAwesomeNode.h"
#import "NSString+Custom.h"
#import <ReactiveCocoa.h>

#import "PublicHeader.h"


@interface TestForIconFont()

<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView* fontCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout* flowLayout;

@property (nonatomic, strong) IconFont_dataSourceFilter* datasource;

@property (nonatomic, strong) UISearchController* searchController;

@property (nonatomic, strong) UIBarButtonItem* cancelBarItem;


@property (nonatomic, strong) UIView* cellDisplayView;
@property (nonatomic, assign) CGRect lastCellFame;
@property (nonatomic, strong) TVCI_vCell* cellDisplay;


@end


@implementation TestForIconFont


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"IconFont";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    [self addKVO];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void) addKVO {
    @weakify(self);
    
    [RACObserve(self.datasource, keyTitleList) subscribeNext:^(id x) {
        @strongify(self);
        [self.fontCollectionView reloadData];
    }];
}


# pragma mask 2 IBActions

- (IBAction) clickedCancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) loadSubviews {
    [self.view addSubview:self.fontCollectionView];
    [self.view addSubview:self.cellDisplayView];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    CGRect frame = self.searchController.searchBar.frame;
    frame.size.height = 44;
    self.searchController.searchBar.frame = frame;
    
    [self.navigationItem setLeftBarButtonItem:self.cancelBarItem];
    [self.navigationItem setTitleView:self.searchController.searchBar];
}


- (IBAction) clickedCellDisplayView:(id)sender {
    [self hideCellDisplayViewAnimation];
}

- (void) showCellDisplayViewAnimation {
    [self.cellDisplayView addSubview:self.cellDisplay];
    self.lastCellFame = self.cellDisplay.frame;
    CGFloat duration = 0.3;
    CGFloat newWidth = self.cellDisplayView.frame.size.width * 0.618;
    
    NameWeakSelf(wself);
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        wself.cellDisplayView.alpha = 1;
        wself.cellDisplay.bounds = CGRectMake(0, 0, newWidth, newWidth);
        wself.cellDisplay.center = CGPointMake(wself.cellDisplayView.frame.size.width * 0.5,
                                               wself.cellDisplayView.frame.size.height * 0.5);
    } completion:^(BOOL finished) {
        
    }];
}
- (void) hideCellDisplayViewAnimation {
    NameWeakSelf(wself);
    CGFloat duration = 0.3;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        wself.cellDisplay.bounds = CGRectMake(0, 0, wself.lastCellFame.size.width, wself.lastCellFame.size.height);
        wself.cellDisplay.center = CGPointMake(wself.lastCellFame.origin.x + wself.lastCellFame.size.width * 0.5,
                                               wself.lastCellFame.origin.y + wself.lastCellFame.size.height * 0.5);
        wself.cellDisplayView.alpha = 0;
    } completion:^(BOOL finished) {
        [wself.cellDisplay removeFromSuperview];
    }];
}



# pragma mask UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    self.datasource.filterKey = searchController.searchBar.text;
}



# pragma mask UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TVCI_vCell* cell = (TVCI_vCell*)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = cell.frame;
    frame.origin.y -= collectionView.contentOffset.y;
    self.cellDisplay = [[TVCI_vCell alloc] initWithFrame:frame];
    self.cellDisplay.iconLabel.text = cell.iconLabel.text;
    self.cellDisplay.iconLabel.font = [UIFont fontAwesomeFontOfSize:40];
    self.cellDisplay.titleLabel.text  = cell.titleLabel.text;
    self.cellDisplay.headLabel.text = cell.headLabel.text;
    [self showCellDisplayViewAnimation];
}


# pragma mask UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datasource.keyTitleList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.datasource.iconfontList objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TVCI_vCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TVCI_vCell" forIndexPath:indexPath];
    
    MFontAwesomeNode* fontNode = [[self.datasource.iconfontList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.iconLabel.text = [NSString fontAwesomeIconStringForEnum:fontNode.key];
    cell.iconLabel.font = [UIFont fontAwesomeFontOfSize:16];
    cell.titleLabel.text = fontNode.name;
    cell.headLabel.text = [NSString stringWithFormat:@"%d", fontNode.key];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TVCI_vHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TVCI_vHeaderView" forIndexPath:indexPath];
    NSArray* list = [self.datasource.iconfontList objectAtIndex:indexPath.section];

    NSString* title = [self.datasource.keyTitleList objectAtIndex:indexPath.section];
    [headerView.titleBtn setTitle:[title stringByAppendingFormat:@" (%d)", [list count]] forState:UIControlStateNormal];
    
    return headerView;
}


# pragma mask UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 10, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 34);
}



# pragma mask 4 getter


- (UICollectionView *)fontCollectionView {
    if (!_fontCollectionView) {
        _fontCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        [_fontCollectionView registerClass:[TVCI_vCell class] forCellWithReuseIdentifier:@"TVCI_vCell"];
        [_fontCollectionView registerClass:[TVCI_vHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TVCI_vHeaderView"];
        _fontCollectionView.dataSource = self;
        _fontCollectionView.delegate = self;
        _fontCollectionView.backgroundColor = [UIColor colorWithHex:0x27384b];
    }
    return _fontCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 4.f,
                                          self.view.frame.size.width / 4.f);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.footerReferenceSize = CGSizeZero;
    }
    return _flowLayout;
}

- (IconFont_dataSourceFilter *)datasource {
    if (!_datasource) {
        _datasource = [[IconFont_dataSourceFilter alloc] init];
    }return _datasource;
}


- (UIBarButtonItem *)cancelBarItem {
    if (!_cancelBarItem) {
        UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [cancelBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAChevronCircleLeft] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHex:0xfeea2a alpha:1] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[@"ss" resizeFontAtHeight:25 scale:1]];
        [cancelBtn addTarget:self action:@selector(clickedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBarItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    }
    return _cancelBarItem;
}

- (UIView *)cellDisplayView {
    if (!_cellDisplayView) {
        _cellDisplayView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        _cellDisplayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        _cellDisplayView.alpha = 0;
        [_cellDisplayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedCellDisplayView:)]];
    }
    return _cellDisplayView;
}



@end
