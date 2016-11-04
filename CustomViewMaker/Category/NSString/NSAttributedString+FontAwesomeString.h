//
//  NSAttributedString+FontAwesomeString.h
//  CustomViewMaker
//
//  Created by jielian on 2016/10/27.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>

@interface NSAttributedString (FontAwesomeString)


+ (NSAttributedString*) stringWithAwesomeText:(NSString*)awesomeText
                                  awesomeFont:(UIFont*)awesomeFont
                                 awesomeColor:(UIColor*)awesomeColor
                                         text:(NSString*)text
                                     textFont:(UIFont*)textFont
                                    textColor:(UIColor*)textColor;

@end
