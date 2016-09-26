//
//  MTVC_screenView.h
//  CustomViewMaker
//
//  Created by jielian on 16/9/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTVC_screenView : UIView

@property (nonatomic, strong) UILabel* moneyLabel;

@property (nonatomic, strong) UILabel* settleTypeLabel;

@property (nonatomic, strong) UILabel* businessLabel;

@property (nonatomic, strong) UIButton* businessSwitchBtn;

@property (nonatomic, strong) UILabel* deviceLinkedStateLabel;

@property (nonatomic, copy) NSString* deviceCBtnTitle;
@property (nonatomic, strong) UIButton* deviceConnectBtn;

@end
