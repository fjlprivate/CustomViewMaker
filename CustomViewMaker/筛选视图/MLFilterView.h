//
//  MLFilterView.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/8.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MLFilterView : NSObject

/* 特征色 */
@property (nonatomic, copy) UIColor* tintColor;

/* 默认色 */
@property (nonatomic, copy) UIColor* normalColor;



/* 显示筛选器: 带2个输入回调和3个响应回调
 * @param sectionInputBlock: 回调:
 * @param itemsInputBlock:
 * @param completionBlock:
 * @param resetBlock:
 * @param cancelBlock:

 */
- (void) showFilterWithSectionInput:(void (^) (NSInteger numberOfSection)) sectionInputBlock
                         itemsInput:(void (^) (NSArray* items)) itemsInputBlock
                       onCompletion:(void (^) (NSInteger numberOfSection, NSArray* itemsSelected)) completionBlock
                            onReset:(void (^) (void)) resetBlock
                           onCancel:(void (^) (void)) cancelBlock;



@end
