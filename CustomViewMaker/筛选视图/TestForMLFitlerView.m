//
//  TestForMLFitlerView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/8.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForMLFitlerView.h"
#import "MLFilterView2Section.h"
#import "MLFilterView1Section.h"
#import "PublicHeader.h"




@interface TestForMLFitlerView ()

@property (nonatomic, strong) MLFilterView2Section* filterView;
@property (nonatomic, strong) MLFilterView1Section* filterView1;


@property (nonatomic, strong) UIBarButtonItem* showBarItem;


@property (nonatomic, strong) UIBarButtonItem* showBarItem3;



@end

@implementation TestForMLFitlerView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"MLFilter筛选器";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[self.showBarItem, self.showBarItem3];
    
}

# pragma mask 2 IBAction 

- (IBAction) clickedShowBarItem1:(id)sender {
    NSArray* mainitems = @[@"2017-01-01", @"2017-01-02", @"2017-01-03", @"2017-01-04"];
    self.filterView1.selectedIndex = 2;
    if (self.filterView1.isSpread) {
        [self.filterView1 hideOnCompletion:nil];
    } else {
        [self.filterView1 showWithItems:mainitems onCompletion:^(NSInteger selectedIndex) {
            
        } onCancel:^{
            
        }];
    }
}


- (IBAction) clickedShowBarItem:(id)sender {
    if (!self.filterView.isSpread) {
        NSArray* mainitems = @[@"日期", @"卡号", @"交易类型", @"金额"];
        NSArray* subitems = @[@[@"2016年12月01日", @"2016年12月02日",@"2016年12月03日",@"2016年12月04日",@"2016年12月05日"],
                              @[@"623738372623",@"623738372623",@"623738372623",@"623738372623"],
                              @[@"消费",@"消费冲正",@"撤销"],
                              @[@"￥100.00", @"￥10032.00",@"￥1030.00",@"￥120.00",@"￥300.00"]
                              ];
        
        [self.filterView resetData];
        [self.filterView showWithMainItems:mainitems
                                  subItems:subitems
                              onCompletion:^(NSArray<NSNumber *> *subSelectedArray) {
                                  NSLog(@"确定了筛选组[%@]", subSelectedArray);
                              }
                                  onCancel:^{
                                  }];
    } else {
        [self.filterView hideOnCompletion:^{
            
        }];
    }
}



# pragma mask 3 dataSource maker




# pragma mask 4 getter


- (MLFilterView2Section *)filterView {
    if (!_filterView) {
        _filterView = [[MLFilterView2Section alloc] initWithSuperVC:self];
        _filterView.tintColor = [UIColor colorWithHex:0x00a1dc alpha:1];
    }
    return _filterView;
}

- (MLFilterView1Section *)filterView1 {
    if (!_filterView1) {
        _filterView1 = [[MLFilterView1Section alloc] initWithSuperVC:self];
    }
    return _filterView1;
}


- (UIBarButtonItem *)showBarItem {
    if (!_showBarItem) {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAFilter] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:25 scale:0.9]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickedShowBarItem:) forControlEvents:UIControlEventTouchUpInside];
        _showBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _showBarItem;
}
- (UIBarButtonItem *)showBarItem3 {
    if (!_showBarItem3) {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FACaretLeft] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontAwesomeFontOfSize:[NSString resizeFontAtHeight:25 scale:0.9]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickedShowBarItem1:) forControlEvents:UIControlEventTouchUpInside];
        _showBarItem3 = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _showBarItem3;
}



@end
