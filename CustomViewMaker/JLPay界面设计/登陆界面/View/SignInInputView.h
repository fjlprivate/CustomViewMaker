//
//  SignInInputView.h
//  CustomViewMaker
//
//  Created by 冯金龙 on 16/3/14.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SignInInputViewDirecitionUp,
    SignInInputViewDirecitionDown
}SignInInputViewDirecition;

@interface SignInInputView : UIView

@property (nonatomic, strong) UIColor* leftTintColor;
@property (nonatomic, strong) UIColor* rightTintColor;
@property (nonatomic, strong) UILabel* leftIconLabel;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, copy) NSString* placeHold;

@property (nonatomic, assign) SignInInputViewDirecition direction;

@property (nonatomic, assign) BOOL* inputed;

@property (nonatomic, copy) NSString* textInputed;

@end
