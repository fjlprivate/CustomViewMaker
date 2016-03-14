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
#import "TestCAShapeLayerViewController.h"
#import "TestCheckViewController.h"
#import <MBProgressHUD.h>

@interface ViewController ()
@property (nonatomic, strong) MBProgressHUD* hud;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主界面";
    [self.view addSubview:self.hud];
    
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
    
    UIButton* circleCheckViewButton = [self buttonWithTitle:@"ConcentricCirclesCheckView"];
    [circleCheckViewButton addTarget:self action:@selector(clickToPushToCircleCheckViewC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:circleCheckViewButton];
    [circleCheckViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(shapeLayerButton);
        make.left.equalTo(shapeLayerButton.mas_right);
        make.top.equalTo(shapeLayerButton.mas_top);
    }];
    
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
