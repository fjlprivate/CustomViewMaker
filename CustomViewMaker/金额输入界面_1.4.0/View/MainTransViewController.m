//
//  MainTransViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MainTransViewController.h"
#import "MTVC_screenView.h"
#import "MTVC_keybordView.h"
#import "TriScrollSegmentView.h"
#import "UIColor+ColorWithHex.h"
#import "Masonry.h"
#import <UIFont+FontAwesome.h>
#import <NSString+FontAwesome.h>
#import "NSString+Custom.h"


@interface MainTransViewController ()

@property (nonatomic, strong) MTVC_screenView*  screenView;

@property (nonatomic, strong) MTVC_keybordView* keybordView;

@property (nonatomic, strong) TriScrollSegmentView* triSwitchView;

@property (nonatomic, strong) UIBarButtonItem* userBarBtn;

@property (nonatomic, strong) UIBarButtonItem* billListBarBtn;

@end

@implementation MainTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户收款";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void) loadSubviews {
    [self.view addSubview:self.screenView];
    [self.view addSubview:self.keybordView];
    [self.view addSubview:self.triSwitchView];
    [self.navigationItem setLeftBarButtonItem:self.userBarBtn];
    [self.navigationItem setRightBarButtonItem:self.billListBarBtn];
}





- (void)updateViewConstraints {
    
 CGFloat triSwitchVHeight = self.view.frame.size.height * 1/6.5;
    CGFloat inset = 15;
    
    CGFloat keyBordVHeight = (self.view.frame.size.height - triSwitchVHeight - 64) * 0.5;
    
    __weak typeof(self) wself = self;
    
    [self.triSwitchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(triSwitchVHeight);
    }];
    self.triSwitchView.itemSize = CGSizeMake(self.view.frame.size.width * 0.5, triSwitchVHeight * 0.6);
    
    [self.keybordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(wself.triSwitchView.mas_top);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(keyBordVHeight);
    }];
    
    [self.screenView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.view.mas_top).offset(64 + inset);
        make.bottom.mas_equalTo(wself.keybordView.mas_top).offset(- inset);
        make.left.mas_equalTo(wself.view.mas_left).offset(inset);
        make.right.mas_equalTo(wself.view.mas_right).offset(- inset);
    }];
    
    [super updateViewConstraints];
}


# pragma mask 2 IBAction

- (IBAction) clickedUserBarBtn:(UIBarButtonItem*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




# pragma mask 4 getter 

- (MTVC_screenView *)screenView {
    if (!_screenView) {
        _screenView = [[MTVC_screenView alloc] init];
        _screenView.moneyLabel.textColor = [UIColor colorWithHex:0x27384b];
        _screenView.layer.cornerRadius = 15;
        _screenView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
        _screenView.moneyLabel.text = @"￥1.00";
        _screenView.settleTypeLabel.text = @"T+0";
        _screenView.settleTypeLabel.backgroundColor = [UIColor colorWithHex:0xef454b];
        _screenView.settleTypeLabel.textColor = [UIColor whiteColor];
        _screenView.businessLabel.text = @"我的商户:阿迪奥斯逻辑店";
        _screenView.businessLabel.textColor = [UIColor colorWithHex:0x27384b alpha:0.9];
        _screenView.deviceLinkedStateLabel.text = [NSString fontAwesomeIconStringForEnum:FAExclamationCircle];
        _screenView.deviceLinkedStateLabel.textColor = [UIColor colorWithHex:0xef454b];
        _screenView.deviceCBtnTitle = @"请点我,您还未绑定设备!";
    }
    return _screenView;
}

- (MTVC_keybordView *)keybordView {
    if (!_keybordView) {
        _keybordView = [[MTVC_keybordView alloc] init];
        _keybordView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
        _keybordView.numBtnBackColor = [UIColor colorWithHex:0x27384b];
        _keybordView.numBtnTextColor = [UIColor whiteColor];
        _keybordView.inset = 8;
    }
    return _keybordView;
}

- (TriScrollSegmentView *)triSwitchView {
    if (!_triSwitchView) {
        NSMutableArray* cells = [NSMutableArray array];
        
        NSMutableDictionary* node1 = [NSMutableDictionary dictionary];
        [node1 setObject:@"JLPayWhite" forKey:@"imgName"];
        [node1 setObject:@"刷卡交易" forKey:@"title"];
        [node1 setObject:[UIColor colorWithHex:0xef454b] forKey:@"backColor"];
        [node1 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node1];
        
        NSMutableDictionary* node2 = [NSMutableDictionary dictionary];
        [node2 setObject:@"Alipay_white" forKey:@"imgName"];
        [node2 setObject:@"支付宝支付" forKey:@"title"];
        [node2 setObject:[UIColor colorWithHex:0x01abf0] forKey:@"backColor"];
        [node2 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node2];

        NSMutableDictionary* node3 = [NSMutableDictionary dictionary];
        [node3 setObject:@"WechatPay_white" forKey:@"imgName"];
        [node3 setObject:@"微信支付" forKey:@"title"];
        [node3 setObject:[UIColor colorWithHex:0x2da43a] forKey:@"backColor"];
        [node3 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node3];
        
        _triSwitchView = [[TriScrollSegmentView alloc] initWithSegInfos:cells andMidItemCliecked:^{
            
        }];
        _triSwitchView.layer.masksToBounds = NO;
        _triSwitchView.backCircleColor = [UIColor colorWithHex:0x27384b];
        _triSwitchView.backgroundColor = [UIColor colorWithHex:0xeeeeee];

    }
    return _triSwitchView;
}

- (UIBarButtonItem *)userBarBtn {
    if (!_userBarBtn) {
        UIButton* userBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        [userBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAUser] forState:UIControlStateNormal];
        userBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[@"teset" resizeFontAtHeight:28 scale:0.9]];
        [userBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [userBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        [userBtn addTarget:self action:@selector(clickedUserBarBtn:) forControlEvents:UIControlEventTouchUpInside];
        _userBarBtn = [[UIBarButtonItem alloc] initWithCustomView:userBtn];
    }
    return _userBarBtn;
}

- (UIBarButtonItem *)billListBarBtn {
    if (!_billListBarBtn) {
        UIButton* billListBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [billListBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAList] forState:UIControlStateNormal];
        billListBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[@"teset" resizeFontAtHeight:25 scale:0.8]];
        [billListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [billListBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        _billListBarBtn = [[UIBarButtonItem alloc] initWithCustomView:billListBtn];
    }
    return _billListBarBtn;
}

@end
