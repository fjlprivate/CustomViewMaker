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
#import "ModelFontAwesomeType.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>


@interface TestForIconFont()
<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView* fontCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout* flowLayout;


@end


@implementation TestForIconFont


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"IconFont";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    //[self layoutSubviews];
    
}


- (void) loadSubviews {
    [self.view addSubview:self.fontCollectionView];
    /*
    [self.view addSubview:self.iconFontLabel];
    for (UILabel* label in self.labels) {
        [self.view addSubview:label];
    }
     */
}




# pragma mask UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [ModelFontAwesomeType curFontAwesomeTypeList].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FontAwesomeIconFontCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fontCell" forIndexPath:indexPath];
    
    NSArray* fontArray = [ModelFontAwesomeType curFontAwesomeTypeList];
    cell.iconLabel.text = [NSString fontAwesomeIconStringForEnum:indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", [fontArray objectAtIndex:indexPath.row]];
    cell.indexLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}


# pragma mask UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}




- (void) layoutSubviews {
    __weak typeof(self) wself = self;
    
    CGFloat labelHeight = 60;
    for (int i = 0; i < self.labels.count; i ++) {
        UILabel* label = [self.labels objectAtIndex:i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wself.view.mas_centerX);
            make.top.equalTo(wself.view.mas_top).offset(64 + i * labelHeight);
            make.width.equalTo(wself.view.mas_width).multipliedBy(0.38);
            make.height.mas_equalTo(labelHeight);
        }];
    }
    
}


- (UILabel*) newIconFontLabel {
    UILabel* label = [UILabel new];
    label.backgroundColor = [UIColor orangeColor];
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5.f;
    label.layer.borderColor = [UIColor redColor].CGColor;
    label.layer.borderWidth = 1;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"iconfont" size:20];
    return label;
}


# pragma mask 4 getter


- (UICollectionView *)fontCollectionView {
    if (!_fontCollectionView) {
        _fontCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        [_fontCollectionView registerClass:[FontAwesomeIconFontCell class] forCellWithReuseIdentifier:@"fontCell"];
        _fontCollectionView.dataSource = self;
        _fontCollectionView.delegate = self;
        _fontCollectionView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    }
    return _fontCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 4.f, self.view.frame.size.width / 4.f);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.footerReferenceSize = CGSizeZero;
    }
    return _flowLayout;
}






- (UILabel *)iconFontLabel {
    if (!_iconFontLabel) {
        _iconFontLabel = [UILabel new];
        _iconFontLabel.backgroundColor = [UIColor orangeColor];
        _iconFontLabel.textColor = [UIColor whiteColor];
        _iconFontLabel.layer.cornerRadius = 5.f;
        _iconFontLabel.textAlignment = NSTextAlignmentCenter;
        _iconFontLabel.text = @"\ue667"; //xe608
        _iconFontLabel.font = [UIFont fontWithName:@"iconfont" size:20];
    }
    return _iconFontLabel;
}

- (NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
        for (NSString* icon in self.icons) {
            UILabel* label = [self newIconFontLabel];
            label.text = icon;
            [_labels addObject:label];
        }
    }
    return _labels;
}

- (NSMutableArray *)icons {
    if (!_icons) {
        _icons = [NSMutableArray array];
        /*
        IconFontType_codeScanning           = 0xe667,
        IconFontType_barCodeAndQRCode       = 0xe654,
        
        IconFontType_backspace				= 0xea82,
        IconFontType_user					= 0xe611,
        IconFontType_alipay					= 0xe631,
        IconFontType_wechatPay				= 0xe6dc,	/
        IconFontType_card					= 0xe65f,	/
        IconFontType_search					= 0xe677,	/

         */
        [_icons addObject:@"\ue667"];
        [_icons addObject:@"\ue654"];
        [_icons addObject:@"\uea82"];
        [_icons addObject:@"\ue611"];
        [_icons addObject:@"\ue631"];

    }
    return _icons;
}

@end
