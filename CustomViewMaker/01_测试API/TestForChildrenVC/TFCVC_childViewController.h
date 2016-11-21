//
//  TFCVC_childViewController.h
//  CustomViewMaker
//
//  Created by jielian on 2016/11/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFCVC_labelForChildVCTest.h"

@interface TFCVC_childViewController : UIViewController

@property (nonatomic, strong) TFCVC_labelForChildVCTest* textLabel;

@property (nonatomic, assign) NSInteger tag;

@end
