//
//  TFCVC_mainVC2.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/11.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TFCVC_mainVC2.h"
#import "PublicHeader.h"
#import "TFCVC_childVC2.h"

@interface TFCVC_mainVC2 ()


@property (nonatomic, strong) TFCVC_childVC2* childVC;

@property (nonatomic, weak) UIButton* spreadBtn;


@end

@implementation TFCVC_mainVC2


- (void)doClose {
    NameWself(wself);
    [UIView animateWithDuration:0.3 animations:^{
        wself.spreadBtn.center = CGPointMake(wself.view.frame.size.width * 0.5f, wself.view.frame.size.height * 0.3f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 animations:^{
            CGRect bounds = wself.spreadBtn.bounds;
            bounds.size.width /= 2;
            bounds.size.height /= 2;
            wself.spreadBtn.bounds = bounds;
        } completion:^(BOOL finished) {
        }];
    }];
    [self.spreadBtn addTarget:self action:@selector(clickedSpreadBtn:) forControlEvents:UIControlEventTouchUpInside];
}




- (void)dealloc {
    NSLog(@"----------------- TFCVC_mainVC2 dealloc");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubviews];
    self.view.backgroundColor = [UIColor colorWithHex:0x00bb9c alpha:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) loadSubviews {
    UIButton* spreadBtn = [self newSpreadBtn];
    [self.view addSubview:spreadBtn];
    self.spreadBtn = spreadBtn;
    [self addChildViewController:self.childVC];
}



- (UIButton*) newSpreadBtn {
    UIButton* spreadBtn = [[UIButton alloc] initWithFrame: CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, 120, 100, 100)];
    spreadBtn.layer.cornerRadius = 50;
    spreadBtn.backgroundColor = [UIColor colorWithHex:0xffcc00 alpha:1];
    [spreadBtn addTarget:self action:@selector(clickedSpreadBtn:) forControlEvents:UIControlEventTouchUpInside];
    return spreadBtn;
}





# pragma mask 2 IBAction

- (IBAction) clickedSpreadBtn:(UIButton*)sender {
    
    UIButton* btn = self.spreadBtn;
    [btn removeTarget:self action:@selector(clickedSpreadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn removeFromSuperview];
    self.childVC.closeBtn = btn;
    [self.childVC.view addSubview:btn];
    
    
    self.childVC.view.frame = self.view.bounds;
    [self.view addSubview:self.childVC.view];
    
    [self.childVC doSpread];
    
}




# pragma mask 4 getter


- (TFCVC_childVC2 *)childVC {
    if (!_childVC) {
        _childVC = [[TFCVC_childVC2 alloc] init];
    }
    return _childVC;
}


@end
