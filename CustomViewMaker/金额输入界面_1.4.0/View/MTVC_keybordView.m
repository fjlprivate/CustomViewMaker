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



@interface MTVC_keybordView()

/* 按钮组 */
@property (nonatomic, strong) NSArray<UIButton*>* numberBtnList;

@end


@implementation MTVC_keybordView


- (instancetype)init {
    self = [super init];
    if ( self) {
        [self loadSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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
    CGFloat btnWidth = (self.bounds.size.width - self.inset * 4) / 3;
    CGFloat btnHeight = (self.bounds.size.height - self.inset * 5) / 4;
    CGRect frame = CGRectMake(self.inset, self.inset, btnWidth, btnHeight);
    
    for (int i = 0; i < self.numberBtnList.count; i++) {
        frame.origin.x = self.inset + (btnWidth + self.inset) * (i%3);
        frame.origin.y = self.inset + (btnHeight + self.inset) * (i/3);

        UIButton* numberBtn = [self.numberBtnList objectAtIndex:i];
        [numberBtn setFrame:frame];
        numberBtn.layer.cornerRadius = btnHeight * 0.5;
        [numberBtn setTitleColor:self.numBtnTextColor forState:UIControlStateNormal];
        numberBtn.backgroundColor = self.numBtnBackColor;
        
        if (i == self.numberBtnList.count - 1) {
            numberBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:14];
        } else {
            numberBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        }
    }
    
    
}

# pragma mask 2 IBAction

- (IBAction) clickedNumBtnDown:(UIButton*)numBtn {
    numBtn.alpha = 0.3;
}

- (IBAction) clickedNumBtnUpOutside:(UIButton*)numBtn {
    numBtn.alpha = 1;
}

- (IBAction) clickedNumBtnUpInside:(UIButton*)numBtn {
    numBtn.alpha = 1;
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
            }
            
            [numberBtn setTitle:title forState:UIControlStateNormal];
            [numberBtn setTitleColor:self.numBtnTextColor forState:UIControlStateNormal];
            [numberBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
            numberBtn.backgroundColor = self.numBtnBackColor;
            
            [numberBtn addTarget:self action:@selector(clickedNumBtnDown:) forControlEvents:UIControlEventTouchDown];
            [numberBtn addTarget:self action:@selector(clickedNumBtnUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
            [numberBtn addTarget:self action:@selector(clickedNumBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];

            [btnList addObject:numberBtn];
        }
        _numberBtnList = [NSArray arrayWithArray:btnList];
    }
    return _numberBtnList;
}


@end
