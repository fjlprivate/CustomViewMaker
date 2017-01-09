//
//  TVCI_mIconFont.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_mIconFont.h"
#import "PublicHeader.h"

@implementation TVCI_mIconFont

+ (instancetype)fontWithName:(NSString *)name type:(NSInteger)type fontSize:(CGFloat)fontSize
{
    TVCI_mIconFont* fontItem = [TVCI_mIconFont new];
    fontItem.name = name;
    fontItem.text = [NSString stringWithIconType:type];
    fontItem.font = [UIFont fontWithName:@"iconfont" size:fontSize];
    fontItem.type = type;
    return fontItem;
}

- (id)copyWithZone:(NSZone *)zone {
    TVCI_mIconFont* fontItem = [TVCI_mIconFont allocWithZone:zone];
    fontItem.name = self.name;
    fontItem.text = self.text;
    fontItem.font = self.font;
    fontItem.type = self.type;
    return fontItem;
}




@end
