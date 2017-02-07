//
//  TestVCIconfont.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/5.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TestVCIconfont.h"
#import "MLIconButtonR.h"
#import "MLFilterView1Section.h"
#import "PublicHeader.h"
#import "TVCI_vFlowLayout.h"
#import "TVCI_vmDatasource.h"
#import "TVCI_vCell.h"



@interface TestVCIconfont () <UICollectionViewDelegate>

@property (nonatomic, strong) MLIconButtonR* titleBtn;
@property (nonatomic, strong) MLFilterView1Section* filterView;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) TVCI_vmDatasource* datasource;

@property (nonatomic, strong) UIView* cellDisplayView;
@property (nonatomic, assign) CGRect lastCellFame;
@property (nonatomic, strong) TVCI_vCell* cellDisplay;

@end

@implementation TestVCIconfont



# pragma mask 2 UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TVCI_vCell* cell = (TVCI_vCell*)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = cell.frame;
    frame.origin.y -= collectionView.contentOffset.y;
    self.cellDisplay = [[TVCI_vCell alloc] initWithFrame:frame];
    self.cellDisplay.iconLabel.text = cell.iconLabel.text;
    self.cellDisplay.iconLabel.font = [[self.datasource curFontType] isEqualToString:TVCI_FONTNAME_AWESOME] ? [UIFont fontAwesomeFontOfSize:50] : [UIFont fontWithName:@"iconfont" size:50];
    self.cellDisplay.titleLabel.text  = cell.titleLabel.text;
    self.cellDisplay.headLabel.text = cell.headLabel.text;
    self.cellDisplay.iconLabel.textColor = [UIColor colorWithHex:0xe0e0e0 alpha:1];
    self.cellDisplay.contentView.backgroundColor = [UIColor whiteColor];
    [self showCellDisplayViewAnimation];
}


# pragma mask 3 生命周期 & 布局

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0x27384b alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadSubviews];
    [self makeMasonries];
    [self addKVO];
}

- (void) loadSubviews {
    [self.navigationItem setTitleView:self.titleBtn];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem backItemWithVC:self color:[UIColor colorWithHex:0xf4ea2a]]];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.cellDisplayView];
}

- (void) makeMasonries {
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

- (void) addKVO {
    @weakify(self);
    [RACObserve(self.filterView, isSpread) subscribeNext:^(id x) {
        if ([x boolValue]) {
            [UIView animateWithDuration:0.2 animations:^{
                @strongify(self);
                self.titleBtn.rightIconLabel.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        } else {
            [UIView animateWithDuration:0.2 animations:^{
                @strongify(self);
                self.titleBtn.rightIconLabel.transform = CGAffineTransformMakeRotation(0);
            }];
        }
    }];
    
    [[RACObserve(self.datasource, curFontIndex) delay:0.1] subscribeNext:^(id x) {
        @strongify(self);
        [self.titleBtn setTitle:[self.datasource curFontType] forState:UIControlStateNormal];
        [self.collectionView reloadData];
    }];
    
    
    
}

- (IBAction) clickedShowFilter:(id)sender {
    NameWeakSelf(wself);
    [self.filterView showWithItems:self.datasource.fontTypes onCompletion:^(NSInteger selectedIndex) {
        wself.datasource.curFontIndex = selectedIndex;
    } onCancel:nil];
}

- (IBAction) clickedBackVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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



# pragma mask 4 getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        TVCI_vFlowLayout* layout = [TVCI_vFlowLayout new];
        layout.headerReferenceSize = CGSizeMake(0, 44);
        layout.numberOfColumns = 4;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.dataSource = self.datasource;
        _collectionView.delegate = self;
        [_collectionView registerClass:NSClassFromString(@"TVCI_vCell") forCellWithReuseIdentifier:@"TVCI_vCell"];
        [_collectionView registerClass:NSClassFromString(@"TVCI_vHeaderView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TVCI_vHeaderView"];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (TVCI_vmDatasource *)datasource {
    if (!_datasource) {
        _datasource = [TVCI_vmDatasource new];
    }
    return _datasource;
}

- (MLIconButtonR *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [[MLIconButtonR alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_titleBtn setTitleColor:[UIColor colorWithHex:0xf4ea2a alpha:1] forState:UIControlStateNormal];
        [_titleBtn setTitleColor:[UIColor colorWithHex:0xf4ea2a alpha:0.4] forState:UIControlStateHighlighted];
        _titleBtn.rightIconLabel.text = [NSString fontAwesomeIconStringForEnum:FACaretDown];
        _titleBtn.rightIconLabel.font = [UIFont fontAwesomeFontOfSize:15];
        _titleBtn.rightIconLabel.textColor = [UIColor colorWithHex:0xf4ea2a alpha:1];
        [_titleBtn addTarget:self action:@selector(clickedShowFilter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}
- (MLFilterView1Section *)filterView {
    if (!_filterView) {
        _filterView = [[MLFilterView1Section alloc] initWithSuperVC:self];
        _filterView.tintColor = [UIColor colorWithHex:0xf4ea2a alpha:1];
        _filterView.normalColor = [UIColor colorWithHex:0xffffff alpha:0.8];
        _filterView.backgroundColorOfCell = [UIColor colorWithHex:0x27384b alpha:1];
    }
    return _filterView;
}

- (UIBarButtonItem*) backVCBarItem {
    CGFloat heightIcon = 22;
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, heightIcon, heightIcon)];
    [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAChevronCircleLeft] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHex:0xf4ea2a alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHex:0xf4ea2a alpha:0.4] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:heightIcon scale:1]];
    [btn addTarget:self action:@selector(clickedBackVC:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
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
