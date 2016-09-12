//
//  TestForCustomAlertView.h
//  CustomViewMaker
//
//  Created by jielian on 16/6/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CustomIOSAlertView.h>


@interface TestForCustomAlertView : UIViewController

@property (nonatomic, strong) UIButton* showButton;
@property (nonatomic, strong) UIButton* closeButton;

@property (nonatomic, strong) CustomIOSAlertView* alertView;

@end
