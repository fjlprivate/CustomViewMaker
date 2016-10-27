//
//  TestForSearchBarVC.m
//  CustomViewMaker
//
//  Created by jielian on 2016/10/26.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForSearchBarVC.h"
#import "TFSB_vmDataSource.h"
#import "UIColor+ColorWithHex.h"
#import <UIFont+FontAwesome.h>
#import <NSString+FontAwesome.h>


@interface TestForSearchBarVC ()

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) UISearchController* searchController;

@property (nonatomic, strong) TFSB_vmDataSource* dataSource;

@end




@implementation TestForSearchBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
}



# pragma mask 4 getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    }
    return _searchController;
}

- (TFSB_vmDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TFSB_vmDataSource alloc] init];
    }
    return _dataSource;
}


@end
