//
//  TestIconBtnVC.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestIconBtnVC.h"
#import "MLIconButtonR.h"
#import "PublicHeader.h"


@interface TestIconBtnVC ()

@property (nonatomic, strong) MLIconButtonR* iconBtn;

@end

@implementation TestIconBtnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MLIconButtonR";
    [self.view addSubview:self.iconBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    NameWeakSelf(wself);
    [self.iconBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view.mas_centerX);
        make.centerY.mas_equalTo(wself.view.mas_centerY);
        make.width.mas_equalTo(wself.view.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(44);
    }];
    self.iconBtn.layer.cornerRadius = 22;
    
}

- (MLIconButtonR *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [[MLIconButtonR alloc] init];
        _iconBtn.rightIconLabel.text = [NSString fontAwesomeIconStringForEnum:FACaretDown];
        _iconBtn.rightIconLabel.font = [UIFont fontAwesomeFontOfSize:18];
        _iconBtn.rightIconLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        [_iconBtn setTitle:@"2016年12月" forState:UIControlStateNormal];
        [_iconBtn setTitleColor:[UIColor colorWithHex:0x27384b alpha:1] forState:UIControlStateNormal];
        [_iconBtn setTitleColor:[UIColor colorWithHex:0x27384b alpha:0.5] forState:UIControlStateHighlighted];
        _iconBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _iconBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    }
    return _iconBtn;
}


@end
