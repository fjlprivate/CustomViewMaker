//
//  ViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <MBProgressHUD.h>
#import "CheckViewController.h"
#import "TestCAShapeLayerViewController.h"
#import "TestCheckViewController.h"
#import "TestRACCommand.h"
#import "TextPullListViewController.h"
#import "TestJLAlertView.h"
#import "TestMBProgressHUD.h"
#import "TestCollectionView/TestCollectionView.h"

@interface ViewController ()
@property (nonatomic, strong) MBProgressHUD* hud;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主界面";
    [self.view addSubview:self.hud];
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];

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
    
    UIButton* shapeLayerButton = [self buttonWithTitle:@"shapeLayer"];
    [shapeLayerButton addTarget:self action:@selector(clickToPushToShapeLayerViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shapeLayerButton];
    [shapeLayerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(checkViewButton);
        make.left.equalTo(checkViewButton.mas_right);
        make.top.equalTo(checkViewButton.mas_top);
    }];
    
    UIButton* circleCheckViewButton = [self buttonWithTitle:@"环形标记"];
    [circleCheckViewButton addTarget:self action:@selector(clickToPushToCircleCheckViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:circleCheckViewButton];
    [circleCheckViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(shapeLayerButton);
        make.left.equalTo(shapeLayerButton.mas_right);
        make.top.equalTo(shapeLayerButton.mas_top);
    }];
    
    UIButton* pullListViewButton = [self buttonWithTitle:@"下拉列表"];
    [pullListViewButton addTarget:self action:@selector(clickToPushToPullListViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pullListViewButton];
    [pullListViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(checkViewButton);
        make.left.equalTo(checkViewButton.mas_left);
        make.top.equalTo(checkViewButton.mas_bottom);
    }];
    
    UIButton* commandViewBotton = [self buttonWithTitle:@"RACCommand"];
    [commandViewBotton addTarget:self action:@selector(clickToPushToRACCommandViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commandViewBotton];
    [commandViewBotton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(pullListViewButton);
        make.left.equalTo(pullListViewButton.mas_right);
        make.top.equalTo(pullListViewButton);
    }];

    UIButton* jlalertView = [self buttonWithTitle:@"JCAlert"];
    [jlalertView addTarget:self action:@selector(clickToPushToJCAlertViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jlalertView];
    [jlalertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(commandViewBotton);
        make.left.equalTo(commandViewBotton.mas_right);
        make.top.equalTo(commandViewBotton);
    }];
    UIButton* mbprogressHud = [self buttonWithTitle:@"MBHUD"];
    [mbprogressHud addTarget:self action:@selector(clickToPushToMBHUdViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mbprogressHud];
    [mbprogressHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(pullListViewButton);
        make.left.equalTo(pullListViewButton.mas_left);
        make.top.equalTo(pullListViewButton.mas_bottom);
    }];
    UIButton* collectionVC = [self buttonWithTitle:@"Collection"];
    [collectionVC addTarget:self action:@selector(clickToPushToTestCollectionViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionVC];
    [collectionVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(mbprogressHud);
        make.left.equalTo(mbprogressHud.mas_right);
        make.top.equalTo(mbprogressHud.mas_top);
    }];

    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 27, 27)];
    imageView.image = [UIImage imageNamed:@"头像"];
//    imageView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    [self.view addSubview:imageView];
    
    
    // ---
    UIButton* showHud = [self buttonWithTitle:@"显示HUD"];
    [showHud addTarget:self action:@selector(clickToShowMBProgress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showHud];
    [showHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(checkViewButton);
        make.left.equalTo(wself.view.mas_left).offset((frame.size.width - width*2)/2.f);
        make.bottom.equalTo(wself.view.mas_bottom);
    }];
    
    UIButton* hiddenHud = [self buttonWithTitle:@"隐藏HUD"];
    [hiddenHud addTarget:self action:@selector(clickToHiddenMBProgress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hiddenHud];
    [hiddenHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(showHud);
        make.left.equalTo(showHud.mas_right);
        make.bottom.equalTo(showHud.mas_bottom);
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
- (IBAction) clickToPushToShapeLayerViewC:(UIButton*)sender {
    TestCAShapeLayerViewController* viewController = [[TestCAShapeLayerViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction) clickToPushToCircleCheckViewC:(UIButton*)sender {
    TestCheckViewController* viewController = [[TestCheckViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction) clickToPushToPullListViewC:(UIButton*)sender {
    TextPullListViewController* viewController = [[TextPullListViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction) clickToPushToRACCommandViewC:(UIButton*)sender {
    TestRACCommand* viewController = [[TestRACCommand alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction) clickToPushToJCAlertViewC:(UIButton*)sender {
    TestJLAlertView* jcalertViewC = [[TestJLAlertView alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:jcalertViewC animated:YES];
}
- (IBAction) clickToPushToMBHUdViewC:(UIButton*)sender {
    TestMBProgressHUD* viewController = [[TestMBProgressHUD alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction) clickToPushToTestCollectionViewC:(UIButton*)sender {
    TestCollectionView* viewController = [[TestCollectionView alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (IBAction) clickToShowMBProgress:(UIButton*)sender {
    [self.hud showAnimated:YES whileExecutingBlock:^{
        
    } completionBlock:^{
        
    }];
}
- (IBAction) clickToHiddenMBProgress:(UIButton*)sender {
    [self.hud hide:YES];
}

#pragma mask 2 添加子按钮
- (UIButton*) buttonWithTitle:(NSString*)title {
    UIButton* button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    return button;
}

#pragma mask 4 getter 
- (MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hud;
}

@end
