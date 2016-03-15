//
//  ChooseButton.h
//  JLPay
//
//  Created by jielian on 16/3/3.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ChooseButtonTypeRect,
    ChooseButtonTypeUnderLine
} ChooseButtonType;

typedef enum {
    ChooseDirectionDown,
    ChooseDirectionUp
} ChooseDirection;

@interface ChooseButton : UIButton


@property (nonatomic, assign) ChooseButtonType chooseButtonType;
@property (nonatomic, strong) UIColor* nomalColor;
@property (nonatomic, strong) UIColor* selectedColor;

@property (nonatomic, assign) ChooseDirection direction;


@end
