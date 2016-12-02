//
//  ZFJF_vmMainVCDatasource.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/2.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ZFJF_vmMainVCDatasource.h"
#import "ZFJF_mainVCCell.h"
#import "ZFJF_mMainVCCellItem.h"

@interface ZFJF_vmMainVCDatasource()



@end



@implementation ZFJF_vmMainVCDatasource


# pragma mask 2 UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFJF_mainVCCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZFJF_mainVCCell" forIndexPath:indexPath];
    
    ZFJF_mMainVCCellItem* item = [self.items objectAtIndex:indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:item.imageName];
    cell.iconLabel.text = item.itemTitle;
    return cell;
}


# pragma mask 4 getter
- (NSArray<ZFJF_mMainVCCellItem *> *)items {
    if (!_items) {
        _items = @[[[ZFJF_mMainVCCellItem alloc] initWithImgName:@"creditcardCheck_orange" title:@"信用卡认证"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"creditcardRequest_blue" title:@"信用卡申请"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"creditApply_orange" title:@"贷款申请"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"wechat_green" title:@"微信支付"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"alipay_blue" title:@"支付宝"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"phone_orange" title:@"手机充值"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"shop_red" title:@"商铺超市"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"transDetail_blue" title:@"交易明细"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"mybusiness_orange" title:@"我的信息"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"assistant_red" title:@"帮助关于"],
                   [[ZFJF_mMainVCCellItem alloc] initWithImgName:@"addition_gray" title:@"更多"]
                   ];
    }
    return _items;
}


@end
