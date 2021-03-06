//
//  TestForMoreSegScrollView.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/18.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForMoreSegScrollView.h"
#import "UIColor+ColorWithHex.h"
#import "MoreSegScrollView.h"
#import <ReactiveCocoa.h>


@interface TestForMoreSegScrollView()

@property (nonatomic, strong) MoreSegScrollView* moreSegScrollView;

@property (nonatomic, strong) UILabel* indexLabel;

@end


@implementation TestForMoreSegScrollView


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TestForMoreSegScrollView";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect frame = CGRectMake(0, 200, self.view.frame.size.width, 130);
    self.moreSegScrollView.frame = frame;
    self.moreSegScrollView.itemSize = CGSizeMake(self.view.frame.size.width * 0.5, 130 * 0.45);
    self.moreSegScrollView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    
    [self.view addSubview:self.moreSegScrollView];
    
    
    frame.origin.y -= 60;
    frame.size.height = 30;
    self.indexLabel.frame = frame;
    [self.view addSubview:self.indexLabel];
    RAC(self.indexLabel, text) = [RACObserve(self.moreSegScrollView, curSegIndex) map:^id(id value) {
        return [NSString stringWithFormat:@"%d", [value intValue]];
    }];
    
}


# pragma mask 4 getter

- (MoreSegScrollView *)moreSegScrollView {
    if (!_moreSegScrollView) {
        
        NSMutableArray* cells = [NSMutableArray array];
        
        NSMutableDictionary* node1 = [NSMutableDictionary dictionary];
        [node1 setObject:@"alipayGray" forKey:@"imgName"];
        [node1 setObject:@"支付宝" forKey:@"title"];
        [node1 setObject:[UIColor colorWithHex:0x01abf0] forKey:@"backColor"];
        [node1 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node1];
        
        NSMutableDictionary* node2 = [NSMutableDictionary dictionary];
        [node2 setObject:@"alipayWhite" forKey:@"imgName"];
        [node2 setObject:@"支付宝-白" forKey:@"title"];
        [node2 setObject:[UIColor colorWithHex:0xef454b] forKey:@"backColor"];
        [node2 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node2];
        
        NSMutableDictionary* node3 = [NSMutableDictionary dictionary];
        [node3 setObject:@"cleanDarkBlue" forKey:@"imgName"];
        [node3 setObject:@"删除" forKey:@"title"];
        [node3 setObject:[UIColor colorWithHex:0x2da43a] forKey:@"backColor"];
        [node3 setObject:[UIColor colorWithHex:HexColorTypeDarkSlateBlue alpha:1] forKey:@"titleColor"];
        [cells addObject:node3];
        
        NSMutableDictionary* node4 = [NSMutableDictionary dictionary];
        [node4 setObject:@"wechatPayGray" forKey:@"imgName"];
        [node4 setObject:@"微信支付" forKey:@"title"];
        [node4 setObject:[UIColor colorWithHex:0x01abf0 alpha:1] forKey:@"backColor"];
        [node4 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node4];

        NSMutableDictionary* node5 = [NSMutableDictionary dictionary];
        [node5 setObject:@"alipayWhite" forKey:@"imgName"];
        [node5 setObject:@"支付宝-白" forKey:@"title"];
        [node5 setObject:[UIColor colorWithHex:0xef454b] forKey:@"backColor"];
        [node5 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node5];

        NSMutableDictionary* node6 = [NSMutableDictionary dictionary];
        [node6 setObject:@"alipayGray" forKey:@"imgName"];
        [node6 setObject:@"支付宝" forKey:@"title"];
        [node6 setObject:[UIColor colorWithHex:0x2da43a] forKey:@"backColor"];
        [node6 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node6];

        NSMutableDictionary* node7 = [NSMutableDictionary dictionary];
        [node7 setObject:@"cleanDarkBlue" forKey:@"imgName"];
        [node7 setObject:@"删除" forKey:@"title"];
        [node7 setObject:[UIColor colorWithHex:0x01abf0] forKey:@"backColor"];
        [node7 setObject:[UIColor colorWithHex:HexColorTypeDarkSlateBlue alpha:1] forKey:@"titleColor"];
        [cells addObject:node7];

        
        _moreSegScrollView = [[MoreSegScrollView alloc] initWithSegInfos:cells];
        
    }
    return _moreSegScrollView;
}

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.textColor = [UIColor colorWithHex:HexColorTypeDarkSlateBlue];
        _indexLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _indexLabel;
}

@end
