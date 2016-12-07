//
//  TCV_mItem.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/7.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TCV_mItem : NSObject

- (instancetype) initWithBackColor:(UIColor*)backColor
                              text:(NSString*)text
                         textColor:(UIColor*)textColor;

@property (nonatomic, copy) UIColor* backColor;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) UIColor* textColor;

@end
