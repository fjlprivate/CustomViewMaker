//
//  TestForIconFont.m
//  CustomViewMaker
//
//  Created by jielian on 16/6/17.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForIconFont.h"

@implementation TestForIconFont


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    [self layoutSubviews];
    
    
    for (NSString* family in [UIFont familyNames]) {
        if ([family hasPrefix:@"icon"] || [family hasPrefix:@"Icon"]) {
            NSLog(@"%@:", family);
            for (NSString* name in [UIFont fontNamesForFamilyName:family]) {
                NSLog(@"  %@", name);
            }
        }
    }
    
}

- (void) loadSubviews {
    [self.view addSubview:self.iconFontLabel];
    for (UILabel* label in self.labels) {
        [self.view addSubview:label];
    }
}
- (void) layoutSubviews {
    __weak typeof(self) wself = self;
    
    CGFloat labelHeight = 60;
    for (int i = 0; i < self.labels.count; i ++) {
        UILabel* label = [self.labels objectAtIndex:i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wself.view.mas_centerX);
            make.top.equalTo(wself.view.mas_top).offset(64 + i * labelHeight);
            make.width.equalTo(wself.view.mas_width).multipliedBy(0.38);
            make.height.mas_equalTo(labelHeight);
        }];
    }
    
//    [self.iconFontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(wself.view.mas_centerX);
//        make.centerY.equalTo(wself.view.mas_centerY);
//        make.width.equalTo(wself.view.mas_width).multipliedBy(0.38);
//        make.height.mas_equalTo(60);
//    }];
    
}


- (UILabel*) newIconFontLabel {
    UILabel* label = [UILabel new];
    label.backgroundColor = [UIColor orangeColor];
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5.f;
    label.layer.borderColor = [UIColor redColor].CGColor;
    label.layer.borderWidth = 1;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"iconfont" size:20];
    return label;
}


# pragma mask 4 getter
- (UILabel *)iconFontLabel {
    if (!_iconFontLabel) {
        _iconFontLabel = [UILabel new];
        _iconFontLabel.backgroundColor = [UIColor orangeColor];
        _iconFontLabel.textColor = [UIColor whiteColor];
        _iconFontLabel.layer.cornerRadius = 5.f;
        _iconFontLabel.textAlignment = NSTextAlignmentCenter;
        _iconFontLabel.text = @"\ue667"; //xe608
        _iconFontLabel.font = [UIFont fontWithName:@"iconfont" size:20];
    }
    return _iconFontLabel;
}

- (NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
        for (NSString* icon in self.icons) {
            UILabel* label = [self newIconFontLabel];
            label.text = icon;
            [_labels addObject:label];
        }
    }
    return _labels;
}

- (NSMutableArray *)icons {
    if (!_icons) {
        _icons = [NSMutableArray array];
        /*
        IconFontType_codeScanning           = 0xe667,
        IconFontType_barCodeAndQRCode       = 0xe654,
        
        IconFontType_backspace				= 0xea82,
        IconFontType_user					= 0xe611,
        IconFontType_alipay					= 0xe631,
        IconFontType_wechatPay				= 0xe6dc,	/
        IconFontType_card					= 0xe65f,	/
        IconFontType_search					= 0xe677,	/

         */
        [_icons addObject:@"\ue667"];
        [_icons addObject:@"\ue654"];
        [_icons addObject:@"\uea82"];
        [_icons addObject:@"\ue611"];
        [_icons addObject:@"\ue631"];

    }
    return _icons;
}

@end
