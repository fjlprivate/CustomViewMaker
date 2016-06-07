//
//  VMDataRequester.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/15.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "VMDataRequester.h"
#import <AFNetworking.h>

@interface VMDataRequester()
<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) NSArray* datas;
@end

@implementation VMDataRequester

#pragma mask 1 UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* identifier = @"identifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    NSString* money = [NSString stringWithFormat:@"￥ %.02f",];
    NSDictionary* dataNode = [self.datas objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataNode objectForKey:@"amtTrans"];
    cell.detailTextLabel.text = [dataNode objectForKey:@"pan"];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
#pragma mask 1 UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mask 4 getter 
- (RACCommand *)commandDataRequesting {
    if (!_commandDataRequesting) {
        _commandDataRequesting = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                __weak typeof(self)wself = self;
                NSString* urlString = @"http://unitepay.com.cn:80/jlagent/getMchntInfo";
                NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                [parameters setObject:@"20160310" forKey:@"queryBeginTime"];
                [parameters setObject:@"20160314" forKey:@"queryEndTime"];
                [parameters setObject:@"10006057" forKey:@"termNo"];
                [parameters setObject:@"886584000000001" forKey:@"mchntNo"];
                AFHTTPRequestOperationManager* httpManager = [AFHTTPRequestOperationManager manager];
                httpManager.responseSerializer.acceptableContentTypes = [httpManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
                [httpManager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                    wself.datas = [[responseObject objectForKey:@"MchntInfoList"] copy];
                    [subscriber sendCompleted];
                } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }] replayLazily];
        }];
    }
    return _commandDataRequesting;
}

@end
