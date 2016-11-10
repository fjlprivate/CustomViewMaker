//
//  TestForMLActivitorVC.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForMLActivitorVC.h"
#import "MLActivitor.h"
#import "Masonry.h"
#import "UIColor+ColorWithHex.h"
#import <NSString+FontAwesome.h>
#import <UIFont+FontAwesome.h>
#import "NSString+Custom.h"

@interface TestForMLActivitorVC () <UITableViewDataSource>

@property (nonatomic, strong) MLActivitor* activitor;
@property (nonatomic, strong) UIBarButtonItem* handleBarBtn;

@property (nonatomic, strong) UITableView* tableView;
@end



@implementation TestForMLActivitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
    [self layoutSubviews];
    [self.activitor show];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.activitor show];
}

- (void) loadSubviews {
    [self.view addSubview:self.activitor];
//    [self.view addSubview:self.tableView];
//    [self.tableView addSubview:self.activitor];
    [self.navigationItem setRightBarButtonItem:self.handleBarBtn];
}

- (void) layoutSubviews {
//    __weak typeof(self) wself = self;
//    [self.activitor mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.centerX.mas_equalTo(wself.view);
//        make.width.height.mas_equalTo(100);
//    }];
    CGRect frame = self.view.bounds;
    frame.origin.y = 64;
    frame.size.height -= 64;
    self.tableView.frame = frame;
    
    
    CGFloat heightActivitor = 60;
    frame.origin.y = 200;//- 50;
    frame.origin.x = (frame.size.width - heightActivitor)/2;
    frame.size.width = frame.size.height = heightActivitor;
    self.activitor.frame = frame;
    
}

# pragma mask 1 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"sdfs"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"sdfs"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"asdfahd[%d]", indexPath.row];
    
    return cell;
}



# pragma mask 2 IBAction

- (IBAction) clickedHandle:(id)sender {
    __weak typeof(self) wself = self;
    NSString* curTitle = [(UIButton*)self.handleBarBtn.customView titleForState:UIControlStateNormal];
    if ([curTitle isEqualToString:[NSString fontAwesomeIconStringForEnum:FAPlay]]) {
        [(UIButton*)self.handleBarBtn.customView setTitle:[NSString fontAwesomeIconStringForEnum:FAPause] forState:UIControlStateNormal];
        [self.activitor show];
        [UIView animateWithDuration:0.3 animations:^{
            wself.tableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
        }];
    } else {
        [(UIButton*)self.handleBarBtn.customView setTitle:[NSString fontAwesomeIconStringForEnum:FAPlay] forState:UIControlStateNormal];
        [self.activitor hide];
        [UIView animateWithDuration:0.3 animations:^{
            wself.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
    }
    
}


# pragma mask 4 getter
- (MLActivitor *)activitor {
    if (!_activitor) {
        _activitor = [[MLActivitor alloc] init];
    }
    return _activitor;
}

- (UIBarButtonItem *)handleBarBtn {
    if (!_handleBarBtn) {
        UIButton* handleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [handleBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAPlay] forState:UIControlStateNormal];
        [handleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        handleBtn.titleLabel.font = [UIFont fontAwesomeFontOfSize:15];
        [handleBtn addTarget:self action:@selector(clickedHandle:) forControlEvents:UIControlEventTouchUpInside];
        _handleBarBtn = [[UIBarButtonItem alloc] initWithCustomView:handleBtn];
    }
    return _handleBarBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
