//
//  TVCI_mNodeItems.h
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVCI_mAwesome.h"
#import "TVCI_mIconFont.h"

@interface TVCI_mNodeItems : NSObject <NSCopying>

+ (instancetype) nodeItemsWithTitle:(NSString*)title items:(NSArray*)items;


@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSArray* items;

@end
