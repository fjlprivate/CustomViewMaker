//
//  TFCVC_childVC2.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/11.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TFCVC_childVC2.h"
#import "PublicHeader.h"

#import "TFCVC_mainVC2.h"

@interface TFCVC_childVC2 ()



@end

@implementation TFCVC_childVC2


- (void)doSpread {
    NameWself(wself);
    [UIView animateWithDuration:0.3 animations:^{
        wself.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        wself.closeBtn.center = CGPointMake(wself.view.frame.size.width * 0.5f, wself.view.frame.size.height * 0.5f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 animations:^{
            CGRect bounds = wself.closeBtn.bounds;
            bounds.size.width *= 2;
            bounds.size.height *= 2;
            wself.closeBtn.bounds = bounds;
        } completion:^(BOOL finished) {
        }];
    }];
    [self.closeBtn addTarget:self action:@selector(clickedCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)dealloc {
    NSLog(@"----------------- TFCVC_childVC2 dealloc");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (IBAction) clickedCloseBtn:(id)sender {
    TFCVC_mainVC2* mainVC = (TFCVC_mainVC2*)[self parentViewController];
    self.view.frame = CGRectZero;
    [self.closeBtn removeTarget:self action:@selector(clickedCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn removeFromSuperview];
    [mainVC.view addSubview:self.closeBtn];
    
    [self.view removeFromSuperview];
    
    [mainVC doClose];
}




@end
