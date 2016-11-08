//
//  LeftMenuViewController.h
//  CustomViewMaker
//
//  Created by jielian on 16/10/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMVC_logoutButton.h"
#import "LMVC_userHeadView.h"
#import "LMVC_modelMenuData.h"

@interface LeftMenuViewController : UIViewController

@property (nonatomic, strong) LMVC_userHeadView* userHeadView;

@property (nonatomic, strong) UITableView* menuTableView;

@property (nonatomic, strong) LMVC_logoutButton* logoutBtn;

@property (nonatomic, strong) LMVC_modelMenuData* modelMenuData;

@end
