//
//  NSAttributedString+FontAwesomeString.m
//  CustomViewMaker
//
//  Created by jielian on 2016/10/27.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "NSAttributedString+FontAwesomeString.h"

#import "UIColor+ColorWithHex.h"


@implementation NSAttributedString (FontAwesomeString)


+ (NSAttributedString*) stringWithAwesomeText:(NSString*)awesomeText
                                  awesomeFont:(UIFont*)awesomeFont
                                 awesomeColor:(UIColor*)awesomeColor
                                         text:(NSString*)text
                                     textFont:(UIFont*)textFont
                                    textColor:(UIColor*)textColor
{
    
    NSString* allString = [NSString stringWithFormat:@"%@ %@", awesomeText, text];
    
    NSMutableAttributedString* attriString = [[NSMutableAttributedString alloc] initWithString:allString];
    
    [attriString addAttribute:NSForegroundColorAttributeName value:awesomeColor range:NSMakeRange(0, awesomeText.length)];
    [attriString addAttribute:NSFontAttributeName value:awesomeFont range:NSMakeRange(0, awesomeText.length)];
    
    [attriString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(awesomeText.length, text.length)];
    [attriString addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(awesomeText.length, text.length)];
    
    return attriString;
}


@end
