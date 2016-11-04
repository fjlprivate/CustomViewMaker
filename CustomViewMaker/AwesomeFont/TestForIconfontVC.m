//
//  TestForIconfontVC.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/1.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForIconfontVC.h"
#import "VMIFDataSource.h"


@interface TestForIconfontVC ()

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) VMIFDataSource* dataSource;

@end

@implementation TestForIconfontVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AwesomeIcon";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

# pragma mask 4 getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self.dataSource;
        _tableView.dataSource = self.dataSource;
    }
    return _tableView;
}

- (VMIFDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[VMIFDataSource alloc] init];
    }
    return _dataSource;
}

@end
