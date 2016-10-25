//
//  MFontAwesomeNode.h
//  CustomViewMaker
//
//  Created by jielian on 2016/10/25.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFontAwesomeNode : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger key;

+ (instancetype) fontAwesomeWithName:(NSString*)name key:(NSInteger)key;

@end
