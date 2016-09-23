//
//  MTVC_keybordView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MTVC_keybordView.h"
#import "UIColor+ColorWithHex.h"



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
            [numberBtn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [numberBtn setTitleColor:self.numBtnTextColor forState:UIControlStateNormal];
            [numberBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
            numberBtn.backgroundColor = self.numBtnBackColor;
            [btnList addObject:numberBtn];
        }
        _numberBtnList = [NSArray arrayWithArray:btnList];
    }
    return _numberBtnList;
}


@end
