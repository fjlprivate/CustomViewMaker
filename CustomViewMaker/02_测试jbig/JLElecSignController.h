//
//  JLElecSignController.h
//  JLPay
//
//  Created by jielian on 2016/11/14.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElecSignFrameView.h"

@protocol ElecSignDelegate <NSObject>

- (void) doneWithEncoded;

@end

@interface JLElecSignController : UIView

+ (instancetype) sharedElecSign;

@property (nonatomic, weak) id<ElecSignDelegate> delegate;

/* 签名 */
- (void) signWithCompletion:(void (^) (void))completionBlock
                   orCancel:(void (^) (void))cancel;

/* 重写特征码 */
- (void) rewriteCharacteristicCode:(NSString*)characteristicCode;

/* 签名视图 */
@property (nonatomic, strong) ElecSignFrameView* elecSignView;

/* 签名图片JBIG数据 */
@property (nonatomic, strong) NSString* elecSignJBIGEncoded;


- (void) makeCurSignEncoded ;

@end
