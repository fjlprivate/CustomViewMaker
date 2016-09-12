//
//  LabelAutoresize.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/12.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "LabelAutoresize.h"
#import <ReactiveCocoa.h>
#import "Masonry.h"
#import "UIColor+ColorWithHex.h"



@interface LabelAutoresize()

@property (nonatomic, strong) UILabel* testLabel;

@property (nonatomic, strong) UITextView* testTextField;


@end




@implementation LabelAutoresize


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LabelAutoresize";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testLabel];
    [self.view addSubview:self.testTextField];
    [self addKVOs];
}


- (void) addKVOs {
    RAC(self.testLabel, text) = self.testTextField.rac_textSignal;
    @weakify(self);
    [RACObserve(self.testLabel, text) subscribeNext:^(id x) {
        @strongify(self);
        [self.testLabel sizeToFit];
    }];
}


- (void)updateViewConstraints {
    
    __weak typeof(self) wself = self;
    
    [self.testTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.mas_equalTo(0);
        make.height.mas_equalTo(210);
    }];
    
    [self.testLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.view.mas_top).offset(64);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    
    [super updateViewConstraints];
}




# pragma maks : getter

- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [UILabel new];
        _testLabel.backgroundColor = [UIColor orangeColor];
        
        _testLabel.layer.masksToBounds = YES;
        _testLabel.layer.cornerRadius = 5;
        
//        _testLabel.adjustsFontSizeToFitWidth = 
        
    }
    return _testLabel;
}

- (UITextView *)testTextField {
    if (!_testTextField) {
        _testTextField = [UITextView new];
        _testTextField.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
//        _testTextField.placeholder = @"inputs words..";
        _testTextField.font = [UIFont systemFontOfSize:15];
    }
    return _testTextField;
}

@end
