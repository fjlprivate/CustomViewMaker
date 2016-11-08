//
//  MTVC_keybordView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MTVC_keybordView.h"
#import "UIColor+ColorWithHex.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "Masonry.h"



@interface MTVC_keybordView()

/* 按钮组 */
@property (nonatomic, strong) NSArray<UIButton*>* numberBtnList;

/* 按钮点击事件 */
@property (nonatomic, copy) void (^ numberBtnClickedBlock) (NSInteger number);

@end



@implementation MTVC_keybordView


- (instancetype) initWithClickedBlock: (void (^) (NSInteger number)) clickedBlock {
    self = [super init];
    if (self) {
        self.numberBtnClickedBlock = clickedBlock;
        [self loadSubviews];
    }
    return self;
}


- (void) loadSubviews {
    for (UIButton* numberBtn in self.numberBtnList) {
        [self addSubview:numberBtn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    for (int i = 0; i < self.numberBtnList.count; i++) {
        UIButton* numberBtn = [self.numberBtnList objectAtIndex:i];
        numberBtn.layer.cornerRadius = numberBtn.frame.size.height * 0.5;
        [numberBtn setTitleColor:self.numBtnTextColor forState:UIControlStateNormal];
        numberBtn.backgroundColor = self.numBtnBackColor;
    }
}

- (void)updateConstraints {
    CGFloat inset = [UIScreen mainScreen].bounds.size.width * 9.f/320.f;
    
    UIView* numberBtn1 = [self.numberBtnList objectAtIndex:0];
    UIView* numberBtn2 = [self.numberBtnList objectAtIndex:1];
    UIView* numberBtn3 = [self.numberBtnList objectAtIndex:2];
    UIView* numberBtn4 = [self.numberBtnList objectAtIndex:3];
    UIView* numberBtn5 = [self.numberBtnList objectAtIndex:4];
    UIView* numberBtn6 = [self.numberBtnList objectAtIndex:5];
    UIView* numberBtn7 = [self.numberBtnList objectAtIndex:6];
    UIView* numberBtn8 = [self.numberBtnList objectAtIndex:7];
    UIView* numberBtn9 = [self.numberBtnList objectAtIndex:8];
    UIView* numberBtnClear = [self.numberBtnList objectAtIndex:9];
    UIView* numberBtn0 = [self.numberBtnList objectAtIndex:10];
    UIView* numberBtnDel = [self.numberBtnList objectAtIndex:11];

    
    [numberBtn1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(inset);
        make.right.mas_equalTo(numberBtn2.mas_left).offset(- inset);
        make.top.mas_equalTo(inset);
        make.bottom.mas_equalTo(numberBtn4.mas_top).offset(- inset);
        make.width.mas_equalTo(@[numberBtn2, numberBtn3]);
        make.height.mas_equalTo(@[numberBtn4, numberBtn7, numberBtnClear]);
    }];
        
    [numberBtn2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtn1.mas_right).offset(inset);
        make.right.mas_equalTo(numberBtn3.mas_left).offset(- inset);
        make.top.mas_equalTo(numberBtn1.mas_top);
        make.bottom.mas_equalTo(numberBtn1.mas_bottom);
        make.width.mas_equalTo(@[numberBtn1, numberBtn3]);
    }];

    [numberBtn3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtn2.mas_right).offset(inset);
        make.right.mas_equalTo(- inset);
        make.top.mas_equalTo(numberBtn1.mas_top);
        make.bottom.mas_equalTo(numberBtn1.mas_bottom);
        make.width.mas_equalTo(@[numberBtn1, numberBtn2]);
    }];
    
    
    [numberBtn4 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(inset);
        make.right.mas_equalTo(numberBtn5.mas_left).offset(- inset);
        make.top.mas_equalTo(numberBtn1.mas_bottom).offset(- inset);
        make.bottom.mas_equalTo(numberBtn7.mas_top).offset(- inset);
        make.width.mas_equalTo(@[numberBtn5, numberBtn6]);
        make.height.mas_equalTo(@[numberBtn1, numberBtn7, numberBtnClear]);
    }];
    
    [numberBtn5 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtn4.mas_right).offset(inset);
        make.right.mas_equalTo(numberBtn6.mas_left).offset(- inset);
        make.top.mas_equalTo(numberBtn4.mas_top);
        make.bottom.mas_equalTo(numberBtn4.mas_bottom);
        make.width.mas_equalTo(@[numberBtn4, numberBtn6]);
    }];
    
    [numberBtn6 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtn5.mas_right).offset(inset);
        make.right.mas_equalTo(- inset);
        make.top.mas_equalTo(numberBtn4.mas_top);
        make.bottom.mas_equalTo(numberBtn4.mas_bottom);
        make.width.mas_equalTo(@[numberBtn4, numberBtn5]);
    }];
    
    
    [numberBtn7 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(inset);
        make.right.mas_equalTo(numberBtn8.mas_left).offset(- inset);
        make.top.mas_equalTo(numberBtn4.mas_bottom).offset(- inset);
        make.bottom.mas_equalTo(numberBtnClear.mas_top).offset(- inset);
        make.width.mas_equalTo(@[numberBtn8, numberBtn9]);
        make.height.mas_equalTo(@[numberBtn1, numberBtn4, numberBtnClear]);
    }];
    
    [numberBtn8 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtn7.mas_right).offset(inset);
        make.right.mas_equalTo(numberBtn9.mas_left).offset(- inset);
        make.top.mas_equalTo(numberBtn7.mas_top);
        make.bottom.mas_equalTo(numberBtn7.mas_bottom);
        make.width.mas_equalTo(@[numberBtn7, numberBtn9]);
    }];
    
    [numberBtn9 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtn8.mas_right).offset(inset);
        make.right.mas_equalTo(- inset);
        make.top.mas_equalTo(numberBtn7.mas_top);
        make.bottom.mas_equalTo(numberBtn7.mas_bottom);
        make.width.mas_equalTo(@[numberBtn7, numberBtn8]);
    }];

    [numberBtnClear mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(inset);
        make.right.mas_equalTo(numberBtn0.mas_left).offset(- inset);
        make.top.mas_equalTo(numberBtn7.mas_bottom).offset(- inset);
        make.bottom.mas_equalTo(- inset);
        make.width.mas_equalTo(@[numberBtn0, numberBtnDel]);
        make.height.mas_equalTo(@[numberBtn1, numberBtn4, numberBtn7]);
    }];
    
    [numberBtn0 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtnClear.mas_right).offset(inset);
        make.right.mas_equalTo(numberBtnDel.mas_left).offset(- inset);
        make.top.mas_equalTo(numberBtnClear.mas_top);
        make.bottom.mas_equalTo(numberBtnClear.mas_bottom);
        make.width.mas_equalTo(@[numberBtnClear, numberBtnDel]);
    }];
    
    [numberBtnDel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtn8.mas_right).offset(inset);
        make.right.mas_equalTo(- inset);
        make.top.mas_equalTo(numberBtnClear.mas_top);
        make.bottom.mas_equalTo(numberBtnClear.mas_bottom);
        make.width.mas_equalTo(@[numberBtnClear, numberBtn0]);
    }];
    
    [super updateConstraints];
}





# pragma mask 2 IBAction

- (IBAction) clickedNumBtnDown:(UIButton*)numBtn {
    numBtn.transform = CGAffineTransformMakeScale(0.9, 0.9);
}

- (IBAction) clickedNumBtnUpOutside:(UIButton*)numBtn {
    numBtn.transform = CGAffineTransformMakeScale(1, 1);
}

- (IBAction) clickedNumBtnUpInside:(UIButton*)numBtn {
    numBtn.transform = CGAffineTransformMakeScale(1, 1);
    if (self.numberBtnClickedBlock) {
        self.numberBtnClickedBlock(numBtn.tag);
    }
}


# pragma mask 4 getter

- (UIColor *)numBtnBackColor {
    if (!_numBtnBackColor) {
        _numBtnBackColor = [UIColor colorWithHex:0x27384b];
    }
    return _numBtnBackColor;
}

- (UIColor *)numBtnTextColor {
    if (!_numBtnTextColor) {
        _numBtnTextColor = [UIColor whiteColor];
    }
    return _numBtnTextColor;
}

- (NSArray<UIButton *> *)numberBtnList {
    if (!_numberBtnList) {
        NSMutableArray* btnList = [NSMutableArray array];
        for (int i = 1; i <= 12; i++) {
            UIButton* numberBtn = [UIButton new];
            
            NSString* title = [NSString stringWithFormat:@"%d", i];
            if (i == 10) {
                title = @"C";
            } else if (i == 11) {
                title = @"0";
            } else if (i == 12) {
                title = [NSString fontAwesomeIconStringForEnum:FABackward];
            } else {
            }
            numberBtn.tag = i;
            
            [numberBtn setTitle:title forState:UIControlStateNormal];
            [numberBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
            
            [numberBtn addTarget:self action:@selector(clickedNumBtnDown:) forControlEvents:UIControlEventTouchDown];
            [numberBtn addTarget:self action:@selector(clickedNumBtnUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
            [numberBtn addTarget:self action:@selector(clickedNumBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];

            [btnList addObject:numberBtn];

            if (i == 12) {
                numberBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:14];
            } else {
                numberBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            }
            
        }
        _numberBtnList = [NSArray arrayWithArray:btnList];
    }
    return _numberBtnList;
}


@end
