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
    
    CGFloat centerX = ScreenWidth * 0.5;
    CGFloat centerY = ScreenHeight * 0.5;
    CGFloat btnW = 40;
    self.downBtn.frame = CGRectMake(centerX - btnW * 0.5,
                                    centerY + btnW * 0.5,
                                    btnW, btnW);
    
    self.upBtn.frame = CGRectMake(centerX - btnW * 0.5,
                                  centerY - btnW * 1.5,
                                  btnW, btnW);

    

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
}

- (IBAction) clickedRightBtn:(UIButton*)sender {
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

@end
