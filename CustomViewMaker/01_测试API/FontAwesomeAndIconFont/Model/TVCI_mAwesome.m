//
//  TVCI_mAwesome.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_mAwesome.h"
#import "PublicHeader.h"

@implementation TVCI_mAwesome


+ (instancetype)fontWithName:(NSString *)name type:(NSInteger)type fontSize:(CGFloat)fontSize
{
    TVCI_mAwesome* fontItem = [[TVCI_mAwesome alloc] init];
    fontItem.name = name;
    fontItem.text = [NSString fontAwesomeIconStringForEnum:type];
    fontItem.font = [UIFont fontAwesomeFontOfSize:fontSize];
    fontItem.type = type;
    return fontItem;
}

- (id)copyWithZone:(NSZone *)zone {
    TVCI_mAwesome* fontItem = [TVCI_mAwesome allocWithZone:zone];
    fontItem.name = self.name;
    fontItem.text = self.text;
    fontItem.font = self.font;
    fontItem.type = self.type;
    return fontItem;
}


@end
