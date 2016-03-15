//
//  TestRACCommand.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/15.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestRACCommand.h"
#import <ReactiveCocoa.h>
#import "VMDataRequester.h"
#import "Masonry.h"

@interface TestRACCommand()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIButton* requestDataButton;
@property (nonatomic, strong) VMDataRequester* dataRequester;

@end

@implementation TestRACCommand

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"RACCommand";
    [self addSubviews];
    [self relayoutSubviews];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self viewOnDatasCommand];
    
}
- (void) addSubviews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.requestDataButton];
}
- (void) relayoutSubviews {
    CGFloat widthButton = 200;
    CGFloat heightButton = 40;
    CGRect frame = self.view.bounds;
    __weak typeof(self)wself = self;

    [self.requestDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(widthButton, heightButton));
        make.top.equalTo(wself.view.mas_top).offset(64 + 10);
        make.left.equalTo(wself.view.mas_left).offset((frame.size.width - widthButton)/2.f);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.view.mas_left);
        make.right.equalTo(wself.view.mas_right);
        make.top.equalTo(wself.requestDataButton.mas_bottom).offset(10);
        make.bottom.equalTo(wself.view.mas_bottom);
    }];
}

- (void) viewOnDatasCommand {
    RACCommand* command = self.requestDataButton.rac_command;
    __weak typeof(self)wself = self;
    
    [[command.executionSignals map:^id(RACSignal* signal) {
        return @"开始查询...";
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [[command.executionSignals flattenMap:^RACStream *(RACSignal* signal) {
        return [[signal materialize] map:^id(RACEvent* event) {
            if (event.eventType == RACEventTypeCompleted) {
                return @(YES);
            } else {
                return @(NO);
            }
        }];
    }] subscribeNext:^(id x) {
        if ([x boolValue]) {
            NSLog(@"获取数据成功");
            [wself.tableView reloadData];
        } else {
            NSLog(@"开始查询...");
        }
    }];
    
    [[command.errors map:^id(NSError* error) {
        return [error localizedDescription];
    }] subscribeNext:^(id x) {
        NSLog(@"查询数据失败:[%@]",x);
    }];
}

#pragma mask 4 getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.layer.borderColor = [UIColor grayColor].CGColor;
        _tableView.layer.borderWidth = 0.5;
        _tableView.dataSource = (id)self.dataRequester;
        _tableView.delegate = (id)self.dataRequester;
    }
    return _tableView;
}
- (UIButton *)requestDataButton {
    if (!_requestDataButton) {
        _requestDataButton = [UIButton new];
        [_requestDataButton setTitle:@"刷新" forState:UIControlStateNormal];
        _requestDataButton.backgroundColor = [UIColor orangeColor];
        [_requestDataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_requestDataButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _requestDataButton.rac_command = self.dataRequester.commandDataRequesting;
    }
    return _requestDataButton;
}
- (VMDataRequester *)dataRequester {
    if (!_dataRequester) {
        _dataRequester = [[VMDataRequester alloc] init];
    }
    return _dataRequester;
}

@end
