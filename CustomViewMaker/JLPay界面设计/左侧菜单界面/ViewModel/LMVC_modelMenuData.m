//
//  LMVC_modelMenuData.m
//  CustomViewMaker
//
//  Created by jielian on 16/10/10.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "LMVC_modelMenuData.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "NSString+Custom.h"
#import "LMVC_menuCell.h"


@interface LMVC_modelMenuData()

@property (nonatomic, strong) NSArray* iconTypeList;

@property (nonatomic, strong) NSArray* titleList;


@end

@implementation LMVC_modelMenuData




# pragma mask  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.iconTypeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LMVC_menuCell* cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    if (!cell) {
        cell = [[LMVC_menuCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"menuCell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.iconLabel.text = [NSString fontAwesomeIconStringForEnum:[[self.iconTypeList objectAtIndex:indexPath.row] integerValue]];
    cell.titleLabel.text = [self.titleList objectAtIndex:indexPath.row];
    
    cell.iconLabel.font = [UIFont fontAwesomeFontOfSize:20];
    cell.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    return cell;
}


# pragma mask 4 getter

- (NSArray *)iconTypeList {
    return @[@(FALink),//FArecycle FALink
             @(FAUsers), //FASitemap FAUsers
             @(FACreditCard),
             @(FAUnlockAlt),
             @(FAQuestionCircle)];
}

- (NSArray *)titleList {
    return @[@"绑定设备",
             @"商户切换",
             @"我的卡包",
             @"修改密码",
             @"帮助与关于"];
}

@end
