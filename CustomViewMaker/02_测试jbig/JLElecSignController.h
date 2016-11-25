//
//  JLElecSignController.h
//  JLPay
//
//  Created by jielian on 2016/11/14.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElecSignFrameView.h"


@interface JLElecSignController : NSObject

+ (instancetype) sharedElecSign;

/* 签名 */
- (void) signWithCompletion:(void (^) (void))completionBlock
                   orCancel:(void (^) (void))cancel;

/* 重写特征码 */
- (void) rewriteCharacteristicCode:(NSString*)characteristicCode;

/* 签名图片 */
@property (nonatomic, strong) UIImage* elecSignImage;

/* 编码后的电签串 */
@property (nonatomic, strong) NSString* elecSignEncoded;

/* 签名视图 */
@property (nonatomic, strong) ElecSignFrameView* elecSignView;

@end
