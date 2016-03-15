//
//  TextPullListViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/3/15.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TextPullListViewController.h"
#import "Masonry.h"
#import "PullListSegView.h"
#import "ChooseButton.h"

@interface TextPullListViewController()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ChooseButton* showPullList;
@property (nonatomic, strong) PullListSegView* pullListView;
@property (nonatomic, strong) NSArray* datas ;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation TextPullListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = -1;
    [self.view addSubview:self.showPullList];
    [self.view addSubview:self.pullListView];
    self.title = @"绑定设备";
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    [self relayoutSubviews];
}
- (void) relayoutSubviews {
    CGFloat widthView = 160;
    CGFloat heightButton = 40;
    __weak typeof(self)wself = self;

    [self.showPullList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(widthView, heightButton));
        make.centerX.equalTo(wself.view.mas_centerX);
        make.centerY.equalTo(wself.view.mas_centerY);
    }];
    
    [self.pullListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(wself.showPullList);
        make.centerX.equalTo(wself.view.mas_centerX);
        make.top.equalTo(wself.showPullList.mas_bottom).offset(10);
    }];
}

#pragma mask 1 UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* identifier = @"cellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    if (indexPath.row == self.selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
#pragma mask 1 UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
    [tableView reloadData];
    __weak typeof(self) wself = self;
    [self.pullListView hideWithCompletion:^{
        [wself.showPullList setTitle:[wself.datas objectAtIndex:wself.selectedIndex] forState:UIControlStateNormal];
        [wself.showPullList setDirection:ChooseDirectionDown];
    }];
}

#pragma mask 2 IBAction
- (IBAction) clickToShowPullListView:(ChooseButton*)sender {
    [sender setDirection:ChooseDirectionUp];
    [self.pullListView showAnimation];
}



#pragma mask 4 getter 
- (ChooseButton *)showPullList {
    if (!_showPullList) {
        _showPullList = [[ChooseButton alloc] init];
        [_showPullList setTitle:@"显示下拉" forState:UIControlStateNormal];
        _showPullList.backgroundColor = [UIColor orangeColor];
        [_showPullList addTarget:self action:@selector(clickToShowPullListView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPullList;
}
- (PullListSegView *)pullListView {
    if (!_pullListView) {
        _pullListView = [[PullListSegView alloc] init];
        _pullListView.tintColor = [UIColor darkGrayColor];
        _pullListView.tableView.dataSource = self;
        _pullListView.tableView.delegate = self;
    }
    return _pullListView;
}
- (NSArray *)datas {
    if (!_datas) {
        _datas = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    }
    return _datas;
}


@end
