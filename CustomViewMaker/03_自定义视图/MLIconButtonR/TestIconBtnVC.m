//
//  TestIconBtnVC.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/30.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestIconBtnVC.h"
#import "MLIconButtonR.h"
#import "PublicHeader.h"
#import <AFNetworking.h>
#import "MBProgressHUD+CustomSate.h"


@interface TestIconBtnVC () <UITableViewDataSource>

@property (nonatomic, strong) MLIconButtonR* iconBtn;
@property (nonatomic, strong) MLIconButtonR* iconBtnTitle;
@property (nonatomic, assign) BOOL spreaded;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, copy) NSArray* dataSouce;
@property (nonatomic, strong) AFHTTPSessionManager* http;

@end

@implementation TestIconBtnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.spreaded = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.iconBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    NameWeakSelf(wself);
    [self.iconBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wself.view.mas_centerX);
        make.top.mas_equalTo(64);
        make.width.mas_equalTo(wself.view.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(44);
    }];
    self.iconBtn.layer.cornerRadius = 22;
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.iconBtn.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.navigationItem setTitleView:self.iconBtnTitle];
    
    @weakify(self);
    [RACObserve(self, spreaded) subscribeNext:^(id spreaded) {
        [UIView animateWithDuration:0.2 animations:^{
            @strongify(self);
            self.iconBtnTitle.rightIconLabel.transform = CGAffineTransformMakeRotation([spreaded boolValue] ? M_PI : 0);
            self.iconBtn.rightIconLabel.transform = CGAffineTransformMakeRotation([spreaded boolValue] ? M_PI : 0);
        }];
    }];
    
}


# pragma mask 2 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell  = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    NSDictionary* node = [self.dataSouce objectAtIndex:indexPath.row];
    cell.textLabel.text = [node objectForKey:@"retrivlRef"];
    cell.detailTextLabel.text = [node objectForKey:@"cardAccpName"];
    return cell;
}



- (IBAction) clickedSpreadBtn:(id)sender {
    self.spreaded = !self.spreaded;
}

- (IBAction) clickedJump:(id)sender {
   @weakify(self);
    NSLog(@";;准备申请数据;;");
    [self.http POST:@"http://unitepay.com.cn/jlagent/getMchntInfo"
        parameters:@{
                     @"queryBeginTime"     : @"20170101",
                     @"queryEndTime"       : @"20170131",
                     @"mchntNo"            : @"886584000000001"
                     }
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
               NSDictionary* datas = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
               NSString* code = [datas objectForKey:@"HttpResult"];
               @strongify(self);
               if (code.integerValue == 0) {
                   NSLog(@"----加载成功");
                   self.dataSouce = [[datas objectForKey:@"MchntInfoList"] copy];
                   [self.tableView reloadData];
               } else {
                   NSLog(@"----加载失败");
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----加载失败");
    }];
}



- (MLIconButtonR *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [[MLIconButtonR alloc] init];
        _iconBtn.rightIconLabel.text = [NSString fontAwesomeIconStringForEnum:FACaretDown];
        _iconBtn.rightIconLabel.font = [UIFont fontAwesomeFontOfSize:18];
        _iconBtn.rightIconLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        [_iconBtn setTitle:@"2016年12月" forState:UIControlStateNormal];
        [_iconBtn setTitleColor:[UIColor colorWithHex:0x27384b alpha:1] forState:UIControlStateNormal];
        [_iconBtn setTitleColor:[UIColor colorWithHex:0x27384b alpha:0.5] forState:UIControlStateHighlighted];
        _iconBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _iconBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
        [_iconBtn addTarget:self action:@selector(clickedJump:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconBtn;
}

- (MLIconButtonR *)iconBtnTitle {
    if (!_iconBtnTitle) {
        _iconBtnTitle = [[MLIconButtonR alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
        _iconBtnTitle.rightIconLabel.text = [NSString fontAwesomeIconStringForEnum:FACaretDown];
        _iconBtnTitle.rightIconLabel.font = [UIFont fontAwesomeFontOfSize:15];
        _iconBtnTitle.rightIconLabel.textColor = [UIColor colorWithHex:0xffffff alpha:1];
        [_iconBtnTitle setTitle:@"2016年12月" forState:UIControlStateNormal];
        [_iconBtnTitle setTitleColor:[UIColor colorWithHex:0xffffff alpha:1] forState:UIControlStateNormal];
        [_iconBtnTitle setTitleColor:[UIColor colorWithHex:0xffffff alpha:0.5] forState:UIControlStateHighlighted];
        _iconBtnTitle.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [_iconBtnTitle addTarget:self action:@selector(clickedSpreadBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconBtnTitle;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
    }return _tableView;
}

//- (AFHTTPRequestOperationManager *)http {
//    if (!_http) {
//        _http = [AFHTTPRequestOperationManager manager];
//        _http.requestSerializer = [AFJSONRequestSerializer serializer];
//        _http.requestSerializer.timeoutInterval = 20;
//        [_http.requestSerializer setValue:@"application/text,html" forHTTPHeaderField:@"Content-Type"];
//        _http.responseSerializer = [AFHTTPResponseSerializer serializer];
//    }
//    return _http;
//}
- (AFHTTPSessionManager *)http {
    if (!_http) {
        _http = [AFHTTPSessionManager manager];
        _http.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_http.requestSerializer setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        _http.responseSerializer = [AFHTTPResponseSerializer serializer];
        _http.requestSerializer.timeoutInterval = 20;
    }
    return _http;
}

@end
