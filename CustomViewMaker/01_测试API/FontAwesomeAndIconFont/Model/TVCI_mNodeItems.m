//
//  TVCI_mNodeItems.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_mNodeItems.h"




@implementation TVCI_mNodeItems


+ (instancetype)nodeItemsWithTitle:(NSString *)title items:(NSArray *)items {
    TVCI_mNodeItems* nodeitems = [TVCI_mNodeItems new];
    nodeitems.title = title;
    nodeitems.items = items;
    return nodeitems;
}

- (id)copyWithZone:(NSZone *)zone {
    TVCI_mNodeItems* nodeitems = [TVCI_mNodeItems allocWithZone:zone];
    nodeitems.title = self.title;
    nodeitems.items = self.items;
    return nodeitems;
}


@end
