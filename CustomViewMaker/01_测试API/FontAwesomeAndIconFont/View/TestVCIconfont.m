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



@interface TestVCIconfont ()

@property (nonatomic, strong) MLIconButtonR* titleBtn;
@property (nonatomic, strong) MLFilterView1Section* filterView;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) TVCI_vmDatasource* datasource;

@end

@implementation TestVCIconfont

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
    [self.navigationItem setLeftBarButtonItem:[self backVCBarItem]];
    [self.view addSubview:self.collectionView];
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
        _collectionView.delegate = self.datasource;
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

@end
