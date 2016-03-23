//
//  MBProgressHUD+CustomSate.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/23.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MBProgressHUD+CustomSate.h"

#import "CustomCheckView.h"


static CGFloat const fMBProgressHUDSucDuration = 1.5;   // 成功时的显示持续时间
static CGFloat const fMBProgressHUDFailDuration = 2.5;  // 失败时的显示持续时间


@implementation MBProgressHUD (CustomSate)


- (void) showNormalWithText:(NSString*)text andDetailText:(NSString*)detailText {
    self.mode = MBProgressHUDModeIndeterminate;
    self.labelText = text;
    self.detailsLabelText = detailText;
    [self show:YES];
}


- (void) showSuccessWithText:(NSString*)text andDetailText:(NSString*)detailText onCompletion:(void (^) (void))completion {
    CustomCheckView* customStateView = [self stateViewOnStyle:CustomCheckViewStyleRight];
    self.mode = MBProgressHUDModeCustomView;
    self.customView = customStateView;
    
    self.labelText = text;
    self.detailsLabelText = detailText;
    
    [self show:YES];
    [self hide:YES afterDelay:fMBProgressHUDSucDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [customStateView showAnimation];
    });
    __weak typeof(self)wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        wself.completionBlock = completion;
    });
}
- (void) showFailWithText:(NSString*)text andDetailText:(NSString*)detailText onCompletion:(void (^) (void))completion {
    CustomCheckView* customStateView = [self stateViewOnStyle:CustomCheckViewStyleWrong];
    self.mode = MBProgressHUDModeCustomView;
    self.customView = customStateView;
    
    self.labelText = text;
    self.detailsLabelText = detailText;
    
    [self show:YES];
    [self hide:YES afterDelay:fMBProgressHUDFailDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [customStateView showAnimation];
    });
    __weak typeof(self)wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        wself.completionBlock = completion;
    });
}
- (void) showWarnWithText:(NSString*)text andDetailText:(NSString*)detailText onCompletion:(void (^) (void))completion {
    CustomCheckView* customStateView = [self stateViewOnStyle:CustomCheckViewStyleWarn];
    self.mode = MBProgressHUDModeCustomView;
    self.customView = customStateView;
    
    self.labelText = text;
    self.detailsLabelText = detailText;
    
    [self show:YES];
    [self hide:YES afterDelay:fMBProgressHUDFailDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [customStateView showAnimation];
    });
    __weak typeof(self)wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        wself.completionBlock = completion;
    });
}

- (void) hideOnCompletion:(void (^) (void))completion {
    self.completionBlock = completion;
    [self hide:YES];
}
- (void) hideDelay:(NSTimeInterval)delay onCompletion:(void (^) (void))completion {
    self.completionBlock = completion;
    [self hide:YES afterDelay:delay];
}



- (CustomCheckView*) stateViewOnStyle:(CustomCheckViewStyle)style {
    CGFloat width = 37;
    CustomCheckView* stateView = [[CustomCheckView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    stateView.layer.borderColor = [UIColor whiteColor].CGColor;
    stateView.layer.borderWidth = 2.f;
    stateView.layer.cornerRadius = width/2.f;
    
    stateView.lineWidth = 2.f;
    stateView.lineColor = [UIColor whiteColor];
    
    stateView.checkViewStyle = style | CustomCheckViewStyleLineRound;
    return stateView;
}

@end
