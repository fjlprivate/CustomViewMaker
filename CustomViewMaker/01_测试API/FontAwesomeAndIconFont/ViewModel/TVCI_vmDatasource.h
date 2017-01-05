//
//  TVCI_vmDatasource.h
//  CustomViewMaker
//
//  Created by jielian on 2017/1/5.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TVCI_vmDatasource : NSObject <UICollectionViewDataSource>


@property (nonatomic, assign) NSInteger curFontIndex;

@property (nonatomic, strong) NSArray* fontTypes;



@end
