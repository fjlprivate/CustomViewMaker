//
//  TestForPullMenu.m
//  CustomViewMaker
//
//  Created by jielian on 2017/2/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TestForPullMenu.h"
#import "PublicHeader.h"
#import "MLPullMenu.h"

@interface TestForPullMenu ()

@property (nonatomic, strong) MLPullMenu* pullMenu;
@property (nonatomic, strong) UIButton* downBtn;
@property (nonatomic, strong) UIButton* upBtn;
@property (nonatomic, strong) UIButton* leftBtn;
@property (nonatomic, strong) UIButton* rightBtn;

@end

@implementation TestForPullMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem:[self rightMemuBar]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.pullMenu];
    [self.view addSubview:self.downBtn];
    [self.view addSubview:self.upBtn];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.rightBtn];

    
    CGFloat centerX = ScreenWidth * 0.5;
    CGFloat centerY = ScreenHeight * 0.5;
    CGFloat btnW = 40;
    self.downBtn.frame = CGRectMake(centerX - btnW * 0.5,
                                    centerY + btnW * 0.5,
                                    btnW, btnW);
    
    self.upBtn.frame = CGRectMake(centerX - btnW * 0.5,
                                  centerY - btnW * 1.5,
                                  btnW, btnW);
    self.leftBtn.frame = CGRectMake(centerX - btnW * 1.5,
                                  centerY - btnW * 0.5,
                                  btnW, btnW);
    self.rightBtn.frame = CGRectMake(centerX + btnW * 0.5,
                                  centerY - btnW * 0.5,
                                  btnW, btnW);


# pragma mask : testing ...
    self.rightBtn.frame = CGRectMake(30,
                                    ScreenHeight - btnW,
                                    btnW, btnW);
    self.leftBtn.frame = CGRectMake(200,
                                     0,
                                     btnW, btnW);

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x0099cc alpha:0.3]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x27384b alpha:1]];
}



- (IBAction) clickedMenuBtn :(id)sender {
    CGPoint startPoint = CGPointMake(ScreenWidth - 30, 64);
    if (self.pullMenu.isPulled) {
        [self.pullMenu hide];
    } else {
        [self.pullMenu showWithItems:@[@"单元格一",@"单元格二",@"单元格收到是打飞机三",@"单元格四",@"单元格五"]
                        onStartPoint:startPoint
                        andDirection:MLPullMenuDirectionDown
                           onClicked:^(NSInteger index) {
                               
                           }];
    }

}


- (IBAction) clickedDownBtn:(UIButton*)sender {
    CGPoint startPoint = sender.center;
    startPoint.y += sender.bounds.size.height * 0.51;
    if (self.pullMenu.isPulled) {
        [self.pullMenu hide];
    } else {
        [self.pullMenu showWithItems:@[@"1sdfsd",@"2sdfasdf"]
                        onStartPoint:startPoint
                        andDirection:MLPullMenuDirectionDown
                           onClicked:^(NSInteger index) {
                               
                           }];
    }
}

- (IBAction) clickedUpBtn:(UIButton*)sender {
    CGPoint startPoint = sender.center;
    startPoint.y -= sender.bounds.size.height * 0.51;
    if (self.pullMenu.isPulled) {
        [self.pullMenu hide];
    } else {
        [self.pullMenu showWithItems:@[@"kkkkkkkkkkkkk",@"2sdfasdf",@"2sdfasdf"]
                        onStartPoint:startPoint
                        andDirection:MLPullMenuDirectionUp
                           onClicked:^(NSInteger index) {
                               
                           }];
    }
}

- (IBAction) clickedLeftBtn:(UIButton*)sender {
    CGPoint startPoint = sender.center;
    startPoint.x -= sender.bounds.size.height * 0.51;
    if (self.pullMenu.isPulled) {
        [self.pullMenu hide];
    } else {
        [self.pullMenu showWithItems:@[@"扫地缴费",@"是丹佛给偶加豆腐",@"圣诞节快放假"]
                        onStartPoint:startPoint
                        andDirection:MLPullMenuDirectionLeft
                           onClicked:^(NSInteger index) {
                               
                           }];
    }


}

- (IBAction) clickedRightBtn:(UIButton*)sender {
    CGPoint startPoint = sender.center;
    startPoint.x += sender.bounds.size.height * 0.51;
    if (self.pullMenu.isPulled) {
        [self.pullMenu hide];
    } else {
        [self.pullMenu showWithItems:@[@"世纪东方",@"额我",@"问了句了收到",@"问了句了收到"]
                        onStartPoint:startPoint
                        andDirection:MLPullMenuDirectionRight
                           onClicked:^(NSInteger index) {
                               
                           }];
    }


}




- (UIBarButtonItem*) rightMemuBar {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [btn addTarget:self action:@selector(clickedMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAApple] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:24 scale:1]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
- (MLPullMenu *)pullMenu {
    if (!_pullMenu) {
        _pullMenu = [[MLPullMenu alloc] init];
    }
    return _pullMenu;
}

- (UIButton *)downBtn {
    if (!_downBtn) {
        _downBtn = [UIButton new];
        [_downBtn addTarget:self action:@selector(clickedDownBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_downBtn setTitle:[NSString fontAwesomeIconStringForEnum:FACaretDown] forState:UIControlStateNormal];
        _downBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:20];
        [_downBtn setTitleColor:[UIColor colorWithHex:0x0099cc alpha:1] forState:UIControlStateNormal];
        [_downBtn setTitleColor:[UIColor colorWithHex:0x0099cc alpha:0.5] forState:UIControlStateHighlighted];
    }
    return _downBtn;
}

- (UIButton *)upBtn {
    if (!_upBtn) {
        _upBtn = [UIButton new];
        [_upBtn addTarget:self action:@selector(clickedUpBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_upBtn setTitle:[NSString fontAwesomeIconStringForEnum:FACaretUp] forState:UIControlStateNormal];
        _upBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:20];
        [_upBtn setTitleColor:[UIColor colorWithHex:0x0099cc alpha:1] forState:UIControlStateNormal];
        [_upBtn setTitleColor:[UIColor colorWithHex:0x0099cc alpha:0.5] forState:UIControlStateHighlighted];
    }
    return _upBtn;
}
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton new];
        [_leftBtn addTarget:self action:@selector(clickedLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitle:[NSString fontAwesomeIconStringForEnum:FACaretLeft] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:20];
        [_leftBtn setTitleColor:[UIColor colorWithHex:0x0099cc alpha:1] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor colorWithHex:0x0099cc alpha:0.5] forState:UIControlStateHighlighted];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        [_rightBtn addTarget:self action:@selector(clickedRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitle:[NSString fontAwesomeIconStringForEnum:FACaretRight] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:20];
        [_rightBtn setTitleColor:[UIColor colorWithHex:0x0099cc alpha:1] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorWithHex:0x0099cc alpha:0.5] forState:UIControlStateHighlighted];
    }
    return _rightBtn;
}

@end
