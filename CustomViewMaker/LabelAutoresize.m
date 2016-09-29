//
//  LabelAutoresize.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/12.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "LabelAutoresize.h"
#import <ReactiveCocoa.h>
#import "Masonry.h"
#import "UIColor+ColorWithHex.h"
#import <UIFont+FontAwesome.h>
#import <NSString+FontAwesome.h>



@interface LabelAutoresize() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel* testLabel;

@property (nonatomic, strong) UITextView* testTextField;

@property (nonatomic, strong) UITableView* tableView;

@end




@implementation LabelAutoresize


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LabelAutoresize";
    self.view.backgroundColor = [UIColor whiteColor];
   // [self.view addSubview:self.testLabel];
    //[self.view addSubview:self.testTextField];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    //[self addKVOs];
    
}


- (void) addKVOs {
    RAC(self.testLabel, text) = self.testTextField.rac_textSignal;
    @weakify(self);
    [RACObserve(self.testLabel, text) subscribeNext:^(id x) {
        @strongify(self);
        [self.testLabel sizeToFit];
    }];
}


- (void)updateViewConstraints {
    
    __weak typeof(self) wself = self;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.view.mas_top).offset(64);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    /*
    [self.testTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.mas_equalTo(0);
        make.height.mas_equalTo(210);
    }];
    
    [self.testLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.view.mas_top).offset(64);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
     */
    
    [super updateViewConstraints];
}


# pragma mask 3 UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"FAviacoin[%d] - FAGlass[%d]", FAviacoin , FAGlass);
    return FAviacoin - FAGlass + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"tsett"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tsett"];
        cell.textLabel.font = [UIFont fontAwesomeFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithHex:0x27384b];
    }
    cell.textLabel.text = [NSString fontAwesomeIconStringForEnum:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}



# pragma maks : getter

- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [UILabel new];
        _testLabel.backgroundColor = [UIColor orangeColor];
        
        _testLabel.layer.masksToBounds = YES;
        _testLabel.layer.cornerRadius = 5;
        
//        _testLabel.adjustsFontSizeToFitWidth = 
        
    }
    return _testLabel;
}

- (UITextView *)testTextField {
    if (!_testTextField) {
        _testTextField = [UITextView new];
        _testTextField.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
//        _testTextField.placeholder = @"inputs words..";
        _testTextField.font = [UIFont systemFontOfSize:15];
    }
    return _testTextField;
}


- (UITableView *)tableView {
    if (!_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
