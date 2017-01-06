//
//  TVCI_mDataList.h
//  CustomViewMaker
//
//  Created by jielian on 2017/1/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVCI_mNodeItems.h"

static NSString* const TVCI_FONTNAME_AWESOME = @"FontAwesome";
static NSString* const TVCI_FONTNAME_ICONFONT = @"IconFont";


@interface TVCI_mDataList : NSObject


@property (nonatomic, strong) NSArray<TVCI_mNodeItems*>* listAwesome;

@property (nonatomic, strong) NSArray<TVCI_mNodeItems*>* listIconFont;


@end
