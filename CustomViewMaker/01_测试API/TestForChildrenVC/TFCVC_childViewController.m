//
//  TFCVC_childViewController.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TFCVC_childViewController.h"
#import "PublicHeader.h"

@interface TFCVC_childViewController ()

@end

@implementation TFCVC_childViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _textLabel = [[UILabel alloc] init];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont boldSystemFontOfSize:16];
    self.textLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    NSLog(@"--[%ld] \"viewWillAppear:\"", self.tag);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"--[%ld] \"viewDidAppear:\"", self.tag);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"--[%ld] \"viewWillDisappear:\"", self.tag);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"--[%ld] \"viewDidDisappear:\"", self.tag);
}


@end
