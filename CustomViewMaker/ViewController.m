//
//  ViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "CheckViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主界面";
    __weak typeof(self)wself = self;
    CGRect frame = self.view.frame;
    CGFloat width = frame.size.width/3.f;
    CGFloat height = 50;
    
    UIButton* checkViewButton = [self buttonWithTitle:@"标记勾叉"];
    [checkViewButton addTarget:self action:@selector(clickToPushToCheckViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkViewButton];
    [checkViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.left.equalTo(wself.view.mas_left);
        make.top.mas_equalTo(64);
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mask 3 IBActions
- (IBAction) clickToPushToCheckViewC:(UIButton*)sender {
    CheckViewController* viewController = [[CheckViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mask 2 添加子按钮
- (UIButton*) buttonWithTitle:(NSString*)title {
    UIButton* button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    return button;
}

@end
