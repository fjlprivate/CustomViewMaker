//
//  MTVC_keybordView.h
//  CustomViewMaker
//
//  Created by jielian on 16/9/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTVC_keybordView : UIView




/* 数字按钮背景色 */
@property (nonatomic, copy) UIColor* numBtnBackColor;

/* 数字按钮标题色 */
@property (nonatomic, copy) UIColor* numBtnTextColor;

/* 数字按钮间隔 */
@property (nonatomic, assign) CGFloat inset;

@end
