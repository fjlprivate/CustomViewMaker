//
//  LMVC_userHeadView.h
//  CustomViewMaker
//
//  Created by jielian on 16/10/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMVC_userHeadView : UIView

/* 头像 */
@property (nonatomic, strong) UIImageView* headImgView;

/* 商户名 */
@property (nonatomic, strong) UILabel* busiNameLabel;

/* 商户编号 */
@property (nonatomic, strong) UILabel* busiNumLabel;

@end
