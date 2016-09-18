//
//  TestForTriScrollSegVC.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/13.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForTriScrollSegVC.h"
#import "TriScrollSegmentView.h"
#import "UIColor+ColorWithHex.h"
#import "Masonry.h"



@interface TestForTriScrollSegVC()


@property (nonatomic, strong) TriScrollSegmentView* triScrollSegView;


@end

@implementation TestForTriScrollSegVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"TestForTriScrollSegVC";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.triScrollSegView];
    
    
    __weak typeof(self) wself = self;
    
    [self.triScrollSegView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(wself.view.mas_centerY);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
}


- (TriScrollSegmentView *)triScrollSegView {
    if (!_triScrollSegView) {
        
        /*
         NSDictionary<
         imgName: <NSString> 图片名
         title: <NSString> 标题
         titleColor: <UIColor>  标题色
         backColor: <UIColor>  背景色
         >
         */

        NSMutableArray* cells = [NSMutableArray array];
        
        NSMutableDictionary* node1 = [NSMutableDictionary dictionary];
        [node1 setObject:@"alipayGray" forKey:@"imgName"];
        [node1 setObject:@"支付宝" forKey:@"title"];
        [node1 setObject:[UIColor greenColor] forKey:@"backColor"];
        [node1 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node1];

        NSMutableDictionary* node2 = [NSMutableDictionary dictionary];
        [node2 setObject:@"alipayWhite" forKey:@"imgName"];
        [node2 setObject:@"支付宝-白" forKey:@"title"];
        [node2 setObject:[UIColor greenColor] forKey:@"backColor"];
        [node2 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node2];

        NSMutableDictionary* node3 = [NSMutableDictionary dictionary];
        [node3 setObject:@"cleanDarkBlue" forKey:@"imgName"];
        [node3 setObject:@"删除" forKey:@"title"];
        [node3 setObject:[UIColor orangeColor] forKey:@"backColor"];
        [node3 setObject:[UIColor colorWithHex:HexColorTypeDarkSlateBlue alpha:1] forKey:@"titleColor"];
        [cells addObject:node3];

        NSMutableDictionary* node4 = [NSMutableDictionary dictionary];
        [node4 setObject:@"wechatPayGray" forKey:@"imgName"];
        [node4 setObject:@"微信支付" forKey:@"title"];
        [node4 setObject:[UIColor colorWithHex:HexColorTypeDeepSkyBlue alpha:1] forKey:@"backColor"];
        [node4 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node4];

        
        _triScrollSegView = [[TriScrollSegmentView alloc] initWithSegInfos:cells];
    }
    return _triScrollSegView;
}



@end
