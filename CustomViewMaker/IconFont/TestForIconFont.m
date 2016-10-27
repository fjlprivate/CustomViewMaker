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
#import "FontAwesomeIconFontCell.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "IconFont_dataSourceFilter.h"
#import "MFontAwesomeNode.h"
#import "IconFontHeaderView.h"
#import "NSString+Custom.h"
#import <ReactiveCocoa.h>


@interface TestForIconFont()

<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating>

@property (nonatomic, strong) UICollectionView* fontCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout* flowLayout;

@property (nonatomic, strong) IconFont_dataSourceFilter* datasource;

@property (nonatomic, strong) UISearchController* searchController;

@property (nonatomic, strong) UIBarButtonItem* cancelBarItem;


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
    //RAC(self.datasource, filterKey) = RACObserve(self.searchController.searchBar, text);
    
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
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    CGRect frame = self.searchController.searchBar.frame;
    frame.size.height = 44;
    self.searchController.searchBar.frame = frame;
    
    //[self.fontCollectionView addSubview:self.searchController.searchBar];
    [self.navigationItem setLeftBarButtonItem:self.cancelBarItem];
    [self.navigationItem setTitleView:self.searchController.searchBar];
}


# pragma mask UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //NSLog(@"-- search text [%@]", searchController.searchBar.text);
    self.datasource.filterKey = searchController.searchBar.text;
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
    FontAwesomeIconFontCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fontCell" forIndexPath:indexPath];
    
    MFontAwesomeNode* fontNode = [[self.datasource.iconfontList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.iconLabel.text = [NSString fontAwesomeIconStringForEnum:fontNode.key];
    cell.titleLabel.text = fontNode.name;
    cell.indexLabel.text = [NSString stringWithFormat:@"%d", fontNode.key];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    IconFontHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"fontHeader" forIndexPath:indexPath];
    NSArray* list = [self.datasource.iconfontList objectAtIndex:indexPath.section];

    NSString* title = [self.datasource.keyTitleList objectAtIndex:indexPath.section];
    headerView.titleLabel.text = [title stringByAppendingFormat:@" (%d)", [list count]];
    
    headerView.backgroundColor = [UIColor colorWithHex:0x99cccc alpha:1];
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
        [_fontCollectionView registerClass:[FontAwesomeIconFontCell class] forCellWithReuseIdentifier:@"fontCell"];
        [_fontCollectionView registerClass:[IconFontHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"fontHeader"];
        _fontCollectionView.dataSource = self;
        _fontCollectionView.delegate = self;
        _fontCollectionView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
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
        [cancelBtn setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[@"ss" resizeFontAtHeight:25 scale:1]];
        [cancelBtn addTarget:self action:@selector(clickedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView* nullView = [[UIView alloc] initWithFrame:CGRectZero];
        _cancelBarItem = [[UIBarButtonItem alloc] initWithCustomView:nullView];
    }
    return _cancelBarItem;
}


@end
