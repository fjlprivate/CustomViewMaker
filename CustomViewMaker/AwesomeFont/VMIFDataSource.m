//
//  VMIFDataSource.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/1.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "VMIFDataSource.h"
#import "NSString+IconFont.h"


@implementation VMIFDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[NSString iconfontDictionaryList] allKeys].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"sldj"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"sldj"];
    }
    
    NSNumber* key = [[[NSString iconfontDictionaryList] allKeys] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithIconType:[key integerValue]];
    cell.textLabel.font = [UIFont fontWithName:@"iconfont" size:15];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"0x%lx", [key integerValue]];
    return cell;
}


# pragma mask 4 getter


@end
