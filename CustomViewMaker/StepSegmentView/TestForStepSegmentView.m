//
//  TestForStepSegmentView.m
//  CustomViewMaker
//
//  Created by jielian on 16/8/29.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForStepSegmentView.h"
#import "UIColor+ColorWithHex.h"
#import "StepSegmentView.h"
#import "MLStepSegmentView.h"

@interface TestForStepSegmentView()

@property (nonatomic, strong) StepSegmentView* stepSegView;
@property (nonatomic, strong) MLStepSegmentView* mlStepSegView;

@property (nonatomic, strong) UIButton* stepBtn;

@end



@implementation TestForStepSegmentView


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"StepSegmentView";
    self.view.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    
    self.stepSegView = [[StepSegmentView alloc] initWithTitles:@[@"费率", @"省/市", @"商户"]];
    self.stepSegView.tintColor = [UIColor colorWithHex:0xef454b alpha:1];
    self.stepSegView.normalColor = [UIColor whiteColor];
    self.stepSegView.frame = CGRectMake(0, 200, self.view.frame.size.width - 0 , 68);
    [self.view addSubview:self.stepSegView];
    
    self.mlStepSegView = [[MLStepSegmentView alloc] initWithTitles:@[@"连接设备", @"刷卡", @"发起交易"]];
    self.mlStepSegView.frame = CGRectMake(30, 280 + 40 + 20, self.view.frame.size.width - 60, 40);
    self.mlStepSegView.stepIsSingle = YES;
    self.mlStepSegView.tintColor = [UIColor colorWithHex:0x00bb9c alpha:1];
    [self.view addSubview:self.mlStepSegView];
    
    
    self.stepBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, 26)];
    [self.stepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.stepBtn setTitleColor:[UIColor colorWithHex:0xef454b alpha:1] forState:UIControlStateNormal];
    [self.stepBtn setTitleColor:[UIColor colorWithHex:0xef454b alpha:0.5] forState:UIControlStateHighlighted];
    [self.stepBtn addTarget:self action:@selector(clickedStepBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.stepBtn];
}


- (void) clickedStepBtn:(UIButton*)btn {
    NSInteger cur = self.stepSegView.itemSelected + 1;
    self.stepSegView.itemSelected = (cur > 2) ? (-1) : (cur);
    
    NSInteger curMIndex = self.mlStepSegView.itemSelected + 1;
    self.mlStepSegView.itemSelected = (curMIndex > 2) ? (-1) : (curMIndex);
}

@end
