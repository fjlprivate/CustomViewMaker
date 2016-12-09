//
//  ZFJF_vHeaderView.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/6.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFJF_vBtnItem.h"

@interface ZFJF_vHeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel* noteLabel;

@property (nonatomic, strong) ZFJF_vBtnItem* btnBitCode;
@property (nonatomic, strong) ZFJF_vBtnItem* btnPayCode;
@property (nonatomic, strong) ZFJF_vBtnItem* btnQRCode;



@end
