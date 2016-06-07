//
//  VMDataRequester.h
//  CustomViewMaker
//
//  Created by jielian on 16/3/15.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface VMDataRequester : NSObject

@property (nonatomic, strong) RACCommand* commandDataRequesting;

@end
