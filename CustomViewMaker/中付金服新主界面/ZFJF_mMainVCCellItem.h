//
//  ZFJF_mMainVCCellItem.h
//  CustomViewMaker
//
//  Created by jielian on 2016/12/2.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFJF_mMainVCCellItem : NSObject

@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, copy) NSString* itemTitle;


- (instancetype) initWithImgName:(NSString*)imgName title:(NSString*)title;

@end
