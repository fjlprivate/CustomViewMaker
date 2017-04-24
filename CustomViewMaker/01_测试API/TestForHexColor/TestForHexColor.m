//
//  TestForHexColor.m
//  CustomViewMaker
//
//  Created by jielian on 2017/2/21.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TestForHexColor.h"
#import "PublicHeader.h"

@interface TestForHexColor ()<UITextFieldDelegate>

@property (nonatomic, assign) NSInteger red;
@property (nonatomic, assign) NSInteger green;
@property (nonatomic, assign) NSInteger blue;

@property (nonatomic, strong) UILabel* redLabel;
@property (nonatomic, strong) UITextField* redText;
@property (nonatomic, strong) UILabel* greenLabel;
@property (nonatomic, strong) UITextField* greenText;
@property (nonatomic, strong) UILabel* blueLabel;
@property (nonatomic, strong) UITextField* blueText;

@property (nonatomic, strong) UILabel* hexColorLabel;

@property (nonatomic, strong) UIButton* randomBtn;


@end

@implementation TestForHexColor


# pragma mask 2 事件
- (IBAction) clickedRandomBtn:(id)sender {
    self.redText.text = [NSString stringWithFormat:@"%02X", arc4random()%255];
    self.greenText.text = [NSString stringWithFormat:@"%02X", arc4random()%255];
    self.blueText.text = [NSString stringWithFormat:@"%02X", arc4random()%255];
}

- (NSInteger) intTransforFromString:(NSString*)string {
    NSInteger number = 0;
    NSString* upper = string.uppercaseString;
    for (int i = 0; i < string.length; i++) {
        unichar curC = [upper characterAtIndex:i];
        if (curC >= '0' && curC <= '9') {
            number += (curC - '0') * powl(16, i);
        }
        else {
            number += (curC - 'a' + 10) * powl(16, i);
        }
        
    }
    return number;
}

# pragma mask 2 UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 1) {
        return NO;
    }
    else if (string.length == 1) {
        unichar c = [string characterAtIndex:0];
        if (c == 10) {
            [textField resignFirstResponder];
            return YES;
        }
        else if ((c >= 'a' && c <= 'f') ||
                 (c >= 'A' && c <= 'F') ||
                 (c >= '0' && c <= '9')
                 )
        {
            return textField.text.length < 2;
        }
        else {
            return NO;
        }
    }
    else {
        return YES;
    }
}

# pragma mask 3 生命周期 & 布局
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addKVO];
    [self initialDatas];
    [self loadSubviews];
    [self makeMasonries];
}

- (void) addKVO {
    RACSignal* sig = [RACSignal merge:@[RACObserve(self, red),
                                        RACObserve(self, green),
                                        RACObserve(self, blue)]];
    @weakify(self)
    RAC(self.hexColorLabel, backgroundColor) = [sig map:^id(id value) {
        @strongify(self);
        return [UIColor colorWithRed:self.red/255.0 green:self.green/255.0 blue:self.blue/255.0 alpha:1];
    }];
    
    RAC(self, red) = [RACObserve(self.redText, text) map:^id(NSString* text) {
        @strongify(self);
        return @([self intTransforFromString:text]);
    }];
    RAC(self, green) = [RACObserve(self.greenText, text) map:^id(NSString* text) {
        @strongify(self);
        return @([self intTransforFromString:text]);
    }];
    RAC(self, blue) = [RACObserve(self.blueText, text) map:^id(NSString* text) {
        @strongify(self);
        return @([self intTransforFromString:text]);
    }];

}

- (void) initialDatas {
    self.title = @"HEX Color";
    self.view.backgroundColor = [UIColor whiteColor];
    [self clickedRandomBtn:nil];
}
- (void) loadSubviews {
    [self.view addSubview:self.redLabel];
    [self.view addSubview:self.redText];
    [self.view addSubview:self.greenLabel];
    [self.view addSubview:self.greenText];
    [self.view addSubview:self.blueLabel];
    [self.view addSubview:self.blueText];
    [self.view addSubview:self.hexColorLabel];
    [self.view addSubview:self.randomBtn];

}
- (void) makeMasonries {
    CGFloat insetH = ScreenWidth * 15/320.0;
    CGFloat insetV = ScreenWidth * 40/320.0;
    CGFloat heightLable = ScreenWidth * 40/320.0;
    CGFloat heightAvilable = ScreenHeight - 64 - insetH - insetV - heightLable * 2;
    
    NameWeakSelf(wself);
    
    [self.redLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(insetH);
        make.top.mas_equalTo(64 + insetH);
        make.height.mas_equalTo(heightLable);
        make.width.mas_equalTo(wself.greenLabel);
    }];
    [self.greenLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.redLabel.mas_right).offset(insetH);
        make.top.bottom.mas_equalTo(wself.redLabel);
        make.width.mas_equalTo(wself.blueLabel);
    }];
    [self.blueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.greenLabel.mas_right).offset(insetH);
        make.top.bottom.mas_equalTo(wself.greenLabel);
        make.right.mas_equalTo(- insetH);
    }];
    [self.redText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(wself.redLabel);
        make.top.mas_equalTo(wself.redLabel.mas_bottom);
    }];
    [self.greenText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(wself.greenLabel);
        make.top.mas_equalTo(wself.greenLabel.mas_bottom);
    }];
    [self.blueText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(wself.blueLabel);
        make.top.mas_equalTo(wself.blueLabel.mas_bottom);
    }];

    [self.randomBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view);
        make.bottom.mas_equalTo(- insetV);
        make.height.mas_equalTo(heightLable);
        make.width.mas_equalTo(wself.redLabel.mas_width).multipliedBy(2);
    }];
    [self.hexColorLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view);
        make.width.mas_equalTo(wself.view.mas_width).multipliedBy(0.618);
        make.top.mas_equalTo(wself.redText.mas_bottom).offset(heightAvilable * (1 - 0.8));
        make.bottom.mas_equalTo(wself.randomBtn.mas_top).offset(heightAvilable * (0.8 - 1));
    }];
    
}




# pragma mask 4 getter
- (UILabel *)redLabel {
    if (!_redLabel) {
        _redLabel = [UILabel new];
        _redLabel.textAlignment = NSTextAlignmentCenter;
        _redLabel.font = [UIFont boldSystemFontOfSize:14];
        _redLabel.textColor = [UIColor colorWithHex:0xef454b alpha:1];
        _redLabel.text = @"RED";
    }
    return _redLabel;
}
- (UILabel *)greenLabel {
    if (!_greenLabel) {
        _greenLabel = [UILabel new];
        _greenLabel.textAlignment = NSTextAlignmentCenter;
        _greenLabel.font = [UIFont boldSystemFontOfSize:14];
        _greenLabel.textColor = [UIColor colorWithHex:0x41ad71 alpha:1];
        _greenLabel.text = @"GREEN";
    }
    return _greenLabel;
}
- (UILabel *)blueLabel {
    if (!_blueLabel) {
        _blueLabel = [UILabel new];
        _blueLabel.textAlignment = NSTextAlignmentCenter;
        _blueLabel.font = [UIFont boldSystemFontOfSize:14];
        _blueLabel.textColor = [UIColor colorWithHex:0x00a1dc alpha:1];
        _blueLabel.text = @"BLUE";
    }
    return _blueLabel;
}
- (UITextField *)redText {
    if (!_redText) {
        _redText = [UITextField new];
        _redText.textAlignment = NSTextAlignmentCenter;
        _redText.font = [UIFont boldSystemFontOfSize:14];
        _redText.textColor = [UIColor colorWithHex:0xef454b alpha:1];
        _redText.placeholder = @"红色";
        _redText.backgroundColor = [UIColor colorWithHex:0xf0f0f0 alpha:1];
        _redText.layer.cornerRadius = 6.0;
        _redText.delegate = self;
    }
    return _redText;
}
- (UITextField *)greenText {
    if (!_greenText) {
        _greenText = [UITextField new];
        _greenText.textAlignment = NSTextAlignmentCenter;
        _greenText.font = [UIFont boldSystemFontOfSize:14];
        _greenText.textColor = [UIColor colorWithHex:0x41ad71 alpha:1];
        _greenText.placeholder = @"绿色";
        _greenText.backgroundColor = [UIColor colorWithHex:0xf0f0f0 alpha:1];
        _greenText.layer.cornerRadius = 6.0;
        _greenText.delegate = self;
    }
    return _greenText;
}
- (UITextField *)blueText {
    if (!_blueText) {
        _blueText = [UITextField new];
        _blueText.textAlignment = NSTextAlignmentCenter;
        _blueText.font = [UIFont boldSystemFontOfSize:14];
        _blueText.textColor = [UIColor colorWithHex:0x00a1dc alpha:1];
        _blueText.placeholder = @"蓝色";
        _blueText.backgroundColor = [UIColor colorWithHex:0xf0f0f0 alpha:1];
        _blueText.layer.cornerRadius = 6.0;
        _blueText.delegate = self;
    }
    return _blueText;
}

- (UILabel *)hexColorLabel {
    if (!_hexColorLabel) {
        _hexColorLabel = [UILabel new];
        _hexColorLabel.textAlignment = NSTextAlignmentCenter;
        _hexColorLabel.font = [UIFont boldSystemFontOfSize:20];
        _hexColorLabel.backgroundColor = [UIColor colorWithHex:0xf0f0f0 alpha:1];
        _hexColorLabel.layer.masksToBounds = YES;
        _hexColorLabel.layer.cornerRadius = 10.0;
    }
    return _hexColorLabel;
}
- (UIButton *)randomBtn {
    if (!_randomBtn) {
        _randomBtn = [UIButton new];
        [_randomBtn setTitle:@"Random" forState:UIControlStateNormal];
        [_randomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_randomBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        _randomBtn.backgroundColor = [UIColor colorWithHex:0x00a1dc alpha:1];
        _randomBtn.layer.cornerRadius = 6.0;
        _randomBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_randomBtn addTarget:self action:@selector(clickedRandomBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _randomBtn;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
