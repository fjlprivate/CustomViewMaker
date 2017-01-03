//
//  MLFilterView.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/8.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "MLFilterView.h"
#import "PublicHeader.h"


# pragma mask <<<<<<<<<<< [MLFV_item]

@implementation MLFV_item

- (id)initWithTitle:(NSString *)title andSubTitleItems:(NSArray *)subItems {
    self = [super init];
    if (self) {
        self.title = title;
        self.subItems = subItems;
    }
    return self;
}

@end



# pragma mask <<<<<<<<<<< [MLFilterView]

@interface MLFilterView() <UITableViewDelegate, UITableViewDataSource>

/* 承载视图 */
@property (nonatomic, strong) UIView* contenView;

/* 表视图 */
@property (nonatomic, strong) NSArray* tableViews;

/* 数据源 */
@property (nonatomic, copy) NSArray* dataSource;

/* 已选择的索引号组 */
@property (nonatomic, strong) NSArray* selectedIndexes;

/* 回调: 筛选完毕 */
@property (nonatomic, copy) void (^ finishedBlock) (NSArray* selectedIndexes);

/* 回调: 取消 */
@property (nonatomic, copy) void (^ cancelBlock) (void);

/* 承载筛选视图的父视图控制器 */
@property (nonatomic, weak) UIViewController* superVC;

/* 按钮: 重置 */
@property (nonatomic, strong) UIButton* btnReset;

/* 按钮: 确定 */
@property (nonatomic, strong) UIButton* btnDone;

@end


@implementation MLFilterView

# pragma mask 1 功能区


# pragma mask 2 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
}
# pragma mask 2 UITableViewDelegate


# pragma mask 2 tools

# pragma mask 3 初始化 & 布局

- (void) addKVO {
    @weakify(self);
}


- (instancetype)initWithSuperVC:(UIViewController *)superVC {
    self = [super init];
    if (self) {
        self.superVC = superVC;
        self.spreaded = NO;
        self.hideAfterFiltered = NO;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUpTableViews];
    [self loadSubviews];
    [self makeMasonries];
}

// 创建表格组
- (void) setUpTableViews {
    NSMutableArray* tableviews = [NSMutableArray arrayWithCapacity:self.section];
    for (int i = 0; i < self.section; i++) {
        UITableView* tbv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tbv.tag = i;
        tbv.backgroundColor = i == 0 ? [UIColor whiteColor]: [UIColor colorWithRed:(CGFloat)0xee/0xff
                                                                             green:(CGFloat)0xee/0xff
                                                                              blue:(CGFloat)0xee/0xff
                                                                             alpha:1];
        tbv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tbv.delegate = self;
        tbv.dataSource = self;
        [tableviews addObject:tbv];
    }
    self.tableViews = [NSArray arrayWithArray:tableviews];
}

// 加载所有子视图
- (void) loadSubviews {
    for (UITableView* tbv in self.tableViews) {
        [self.contenView addSubview:tbv];
    }
    [self.contenView addSubview:self.btnDone];
    [self.contenView addSubview:self.btnReset];
    self.btnDone.backgroundColor = self.tintColor;
    [self.btnReset setTitleColor:self.normalColor forState:UIControlStateNormal];
    [self addSubview:self.contenView];
}

// 设置所有子视图的布局约束
- (void) makeMasonries {
    NameWeakSelf(wself);
    CGFloat tbvWMinRateMax = 0.382/0.618;
    CGFloat tbvHRate = 0.618;
    CGFloat heightBtn = ScreenWidth * 44/320.f;
    
    [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    if (self.tableViews.count == 1) {
        UITableView* tbv = self.tableViews.firstObject;
        [tbv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(wself.contenView.mas_height).multipliedBy(tbvHRate);
        }];
    }
    else if (self.tableViews.count == 2) {
        UITableView* tbvM = self.tableViews.firstObject;
        UITableView* tbvS = self.tableViews.lastObject;
        [tbvM mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.height.mas_equalTo(wself.contenView.mas_height).multipliedBy(tbvHRate);
            make.width.mas_equalTo(tbvS.mas_width).multipliedBy(tbvWMinRateMax);
        }];
        [tbvS mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tbvM.mas_right);
            make.top.bottom.mas_equalTo(tbvM);
            make.right.mas_equalTo(0);
        }];
    }
    else if (self.tableViews.count > 2) {
        UITableView* lastTBV = nil;
        for (UITableView* tbv in self.tableViews) {
            NSInteger index = [self.tableViews indexOfObject:tbv];

            [tbv mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo( lastTBV != nil ? lastTBV.mas_right : 0 );
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(wself.contenView.mas_height).multipliedBy(tbvHRate);
                if (lastTBV) {
                    make.width.mas_equalTo(lastTBV.mas_width);
                }
                if (index == wself.tableViews.count - 1) {
                    make.right.mas_equalTo(0);
                }
            }];
            lastTBV = tbv;
        }
    }
    
    [self.btnReset mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(heightBtn);
        if (wself.tableViews.count > 0) {
            UITableView* tbv = self.tableViews.firstObject;
            make.top.mas_equalTo(tbv.mas_bottom);
        } else {
            make.top.mas_equalTo(0);
        }
    }];
    [self.btnDone mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.btnReset.mas_right);
        make.top.bottom.width.mas_equalTo(wself.btnReset);
        make.right.mas_equalTo(0);
    }];
}



# pragma mask 4 getter

- (UIColor *)tintColor {
    if (!_tintColor) {
        _tintColor = [UIColor colorWithRed:(CGFloat)0x00/0xff
                                     green:(CGFloat)0xa1/0xff
                                      blue:(CGFloat)0xdc/0xff
                                     alpha:1];
    }
    return _tintColor;
}
- (UIColor *)normalColor {
    if (!_normalColor) {
        _normalColor = [UIColor colorWithRed:(CGFloat)0x99/0xff
                                       green:(CGFloat)0x99/0xff
                                        blue:(CGFloat)0x99/0xff
                                       alpha:1];
    }
    return _normalColor;
}

- (UIView *)contenView {
    if (!_contenView) {
        _contenView = [UIView new];
    }
    return _contenView;
}

- (UIButton *)btnReset {
    if (!_btnReset) {
        _btnReset = [UIButton new];
        [_btnReset setTitle:@"取消" forState:UIControlStateNormal];
        [_btnReset setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        _btnReset.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _btnReset.layer.borderColor = [UIColor colorWithRed:(CGFloat)0xee/0xff
                                                      green:(CGFloat)0xee/0xff
                                                       blue:(CGFloat)0xee/0xff
                                                      alpha:1].CGColor;
        _btnReset.layer.borderWidth = 0.7;
        _btnReset.backgroundColor = [UIColor whiteColor];
    }
    return _btnReset;
}

- (UIButton *)btnDone {
    if (!_btnDone) {
        _btnDone = [UIButton new];
        [_btnDone setTitle:@"确定" forState:UIControlStateNormal];
        _btnDone.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnDone setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
    }
    return _btnDone;
}


@end
