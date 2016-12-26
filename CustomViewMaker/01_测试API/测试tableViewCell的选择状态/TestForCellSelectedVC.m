//
//  TestForCellSelectedVC.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/26.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForCellSelectedVC.h"
#import "PublicHeader.h"
#import "TLVC_vCell.h"
#import "TLVC_vHeadView.h"

@interface TestForCellSelectedVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;


@property (nonatomic, assign) BOOL spreaded;

@property (nonatomic, strong) NSArray<NSArray*>* dataSource;
@property (nonatomic, strong) NSMutableArray<NSArray*>* shownDatas;


@end



@implementation TestForCellSelectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试cell的被选状态";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadSubviews];
    [self makeMasonries];
    //[self addKVO];
}

- (void) addKVO {
    @weakify(self);
    [RACObserve(self, spreaded) subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"---------变换了展开状态");
        [self.tableView reloadData];
    }];
}

- (void) loadSubviews {
    [self.view addSubview:self.tableView];
}

- (void) makeMasonries {
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
}

# pragma mask 2 UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"------------点击了cell[%d]", indexPath.row);
}



# pragma mask 2 UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shownDatas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.shownDatas objectAtIndex:section].count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLVC_vCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TLVC_vCell"];
    if (!cell) {
        cell = [[TLVC_vCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TLVC_vCell"];
    }
    
    NSDictionary* node = [[self.shownDatas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.titleLabel.text = node[@"titleLabel"];
    cell.subTitleLabel.text = node[@"subTitleLabel"];
    cell.contextLabel.text = node[@"contextLabel"];
    cell.subContextLabel.text = node[@"subContextLabel"];
    cell.stateLabel.text = node[@"stateLabel"];
    cell.stateLabel.hidden = [[node objectForKey:@"stateLabel.hidden"] boolValue];
    cell.contextLabel.textColor = node[@"contextLabel.color"];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TLVC_vHeadView* headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLVC_vHeadView"];
    if (!headView) {
        headView = [[TLVC_vHeadView alloc] initWithReuseIdentifier:@"TLVC_vHeadView"];
        
        @weakify(self);
        [[[headView.spreadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:headView.rac_prepareForReuseSignal] subscribeNext:^(UIButton* spreadBtn) {
            TLVC_vHeadView* headv = (TLVC_vHeadView*)[spreadBtn superview];
            NSLog(@"===-=-=-=-=点击了第[%d]个spreadBtn, 是否展开:[%@]",spreadBtn.tag, headv.spreaded ? @"是": @"否");
            
        }];
    }
    headView.spreadBtn.tag = section;
    NSArray* items = [self.shownDatas objectAtIndex:section];
    NSInteger minDay = 20;
    headView.titleLabel.text = [NSString stringWithFormat:@"12月%02d日", minDay + section];
    headView.stateLabel.text = [NSString stringWithFormat:@"%d笔", items.count];
    return headView;
}




# pragma mask 4 getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 60;
        _tableView.sectionHeaderHeight = 44;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (NSArray<NSArray *> *)dataSource {
    if (!_dataSource) {
        NSMutableArray* sections = [NSMutableArray array];
        
        /*
        @property (nonatomic, strong) UILabel* titleLabel;
        @property (nonatomic, strong) UILabel* subTitleLabel;
        @property (nonatomic, strong) UILabel* contextLabel;
        @property (nonatomic, strong) UILabel* subContextLabel;
        @property (nonatomic, strong) UILabel* stateLabel;
         */
        NSMutableArray* sec1 = [NSMutableArray array];
        NSMutableDictionary* item1 = [NSMutableDictionary dictionary];
        [item1 setObject:@"消费" forKey:@"titleLabel"];
        [item1 setObject:@"633224******2735" forKey:@"subTitleLabel"];
        [item1 setObject:@"￥23.09" forKey:@"contextLabel"];
        [item1 setObject:@"13:32:06" forKey:@"subContextLabel"];
        [item1 setObject:@"已撤销" forKey:@"stateLabel"];
        [item1 setObject:@(NO) forKey:@"stateLabel.hidden"];
        [item1 setObject:[UIColor colorWithHex:0xef454b alpha:1] forKey:@"contextLabel.color"];
        [sec1 addObject:item1];
        NSMutableDictionary* item2 = [NSMutableDictionary dictionary];
        [item2 setObject:@"消费" forKey:@"titleLabel"];
        [item2 setObject:@"633224******2735" forKey:@"subTitleLabel"];
        [item2 setObject:@"￥232.00" forKey:@"contextLabel"];
        [item2 setObject:@"13:32:33" forKey:@"subContextLabel"];
        [item2 setObject:@"已撤销" forKey:@"stateLabel"];
        [item2 setObject:@(YES) forKey:@"stateLabel.hidden"];
        [item2 setObject:[UIColor colorWithHex:0x00a1ac alpha:1] forKey:@"contextLabel.color"];
        [sec1 addObject:item2];

        NSMutableArray* sec2 = [NSMutableArray array];
        NSMutableDictionary* item21 = [NSMutableDictionary dictionary];
        [item21 setObject:@"微信支付" forKey:@"titleLabel"];
        [item21 setObject:@"" forKey:@"subTitleLabel"];
        [item21 setObject:@"￥100.00" forKey:@"contextLabel"];
        [item21 setObject:@"08:32:55" forKey:@"subContextLabel"];
        [item21 setObject:@"已撤销" forKey:@"stateLabel"];
        [item21 setObject:@(YES) forKey:@"stateLabel.hidden"];
        [item21 setObject:[UIColor colorWithHex:0x00a1ac alpha:1] forKey:@"contextLabel.color"];
        [sec2 addObject:item21];
        NSMutableDictionary* item22 = [NSMutableDictionary dictionary];
        [item22 setObject:@"微信支付" forKey:@"titleLabel"];
        [item22 setObject:@"" forKey:@"subTitleLabel"];
        [item22 setObject:@"￥100.00" forKey:@"contextLabel"];
        [item22 setObject:@"08:32:55" forKey:@"subContextLabel"];
        [item22 setObject:@"已撤销" forKey:@"stateLabel"];
        [item22 setObject:@(YES) forKey:@"stateLabel.hidden"];
        [item22 setObject:[UIColor colorWithHex:0x00a1ac alpha:1] forKey:@"contextLabel.color"];
        [sec2 addObject:item22];
        NSMutableDictionary* item23 = [NSMutableDictionary dictionary];
        [item23 setObject:@"微信支付" forKey:@"titleLabel"];
        [item23 setObject:@"" forKey:@"subTitleLabel"];
        [item23 setObject:@"￥100.00" forKey:@"contextLabel"];
        [item23 setObject:@"08:32:55" forKey:@"subContextLabel"];
        [item23 setObject:@"已撤销" forKey:@"stateLabel"];
        [item23 setObject:@(YES) forKey:@"stateLabel.hidden"];
        [item23 setObject:[UIColor colorWithHex:0x00a1ac alpha:1] forKey:@"contextLabel.color"];
        [sec2 addObject:item23];
        NSMutableDictionary* item24 = [NSMutableDictionary dictionary];
        [item24 setObject:@"微信支付" forKey:@"titleLabel"];
        [item24 setObject:@"" forKey:@"subTitleLabel"];
        [item24 setObject:@"￥100.00" forKey:@"contextLabel"];
        [item24 setObject:@"08:32:55" forKey:@"subContextLabel"];
        [item24 setObject:@"已撤销" forKey:@"stateLabel"];
        [item24 setObject:@(YES) forKey:@"stateLabel.hidden"];
        [item24 setObject:[UIColor colorWithHex:0x00a1ac alpha:1] forKey:@"contextLabel.color"];
        [sec2 addObject:item24];

        NSMutableArray* sec3 = [NSMutableArray array];
        NSMutableDictionary* item31 = [NSMutableDictionary dictionary];
        [item31 setObject:@"支付宝支付" forKey:@"titleLabel"];
        [item31 setObject:@"" forKey:@"subTitleLabel"];
        [item31 setObject:@"￥100.00" forKey:@"contextLabel"];
        [item31 setObject:@"08:32:55" forKey:@"subContextLabel"];
        [item31 setObject:@"已撤销" forKey:@"stateLabel"];
        [item31 setObject:@(YES) forKey:@"stateLabel.hidden"];
        [item31 setObject:[UIColor colorWithHex:0x00a1ac alpha:1] forKey:@"contextLabel.color"];
        [sec3 addObject:item31];
        NSMutableDictionary* item32 = [NSMutableDictionary dictionary];
        [item32 setObject:@"支付宝支付" forKey:@"titleLabel"];
        [item32 setObject:@"" forKey:@"subTitleLabel"];
        [item32 setObject:@"￥100.00" forKey:@"contextLabel"];
        [item32 setObject:@"08:32:55" forKey:@"subContextLabel"];
        [item32 setObject:@"已撤销" forKey:@"stateLabel"];
        [item32 setObject:@(YES) forKey:@"stateLabel.hidden"];
        [item32 setObject:[UIColor colorWithHex:0x00a1ac alpha:1] forKey:@"contextLabel.color"];
        [sec3 addObject:item32];
        
        [sections addObject:sec1];
        [sections addObject:sec2];
        [sections addObject:sec3];

        _dataSource = [NSArray arrayWithArray:sections];
    }
    return _dataSource;
}


- (NSMutableArray *)shownDatas {
    if (!_shownDatas) {
        _shownDatas = [NSMutableArray array];
        _shownDatas = [NSMutableArray arrayWithArray:self.dataSource];
    }
    return _shownDatas;
}


@end
