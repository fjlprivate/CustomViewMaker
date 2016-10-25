//
//  MFontAwesomeNode.m
//  CustomViewMaker
//
//  Created by jielian on 2016/10/25.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MFontAwesomeNode.h"

@implementation MFontAwesomeNode


+ (instancetype)fontAwesomeWithName:(NSString *)name key:(NSInteger)key {
    MFontAwesomeNode* node = [[MFontAwesomeNode alloc] init];
    node.name = name;
    node.key = key;
    return node;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"FontAwesome key[%d], name[%@]", self.key, self.name];
}

@end
