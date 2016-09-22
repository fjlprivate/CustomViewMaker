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

#import "WHScrollAndPageView.h"


@interface TestForTriScrollSegVC()


@property (nonatomic, strong) TriScrollSegmentView* triScrollSegView;

@property (nonatomic, strong) WHScrollAndPageView* whScrollView;

@property (nonatomic, strong) NSMutableArray* imgArray;


@end

@implementation TestForTriScrollSegVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"TestForTriScrollSegVC";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.triScrollSegView.frame = CGRectMake(0, (self.view.frame.size.height - 100) , self.view.frame.size.width, 100);
    self.triScrollSegView.itemSize = CGSizeMake(self.view.bounds.size.width / 2, 60);
    self.triScrollSegView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    [self.view addSubview:self.triScrollSegView];
    
    [self.view addSubview:self.whScrollView];
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
        [node1 setObject:@"标题-0" forKey:@"title"];
        [node1 setObject:[UIColor colorWithHex:0x01abf0] forKey:@"backColor"];
        [node1 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node1];
        
        NSMutableDictionary* node2 = [NSMutableDictionary dictionary];
        [node2 setObject:@"alipayWhite" forKey:@"imgName"];
        [node2 setObject:@"标题-1" forKey:@"title"];
        [node2 setObject:[UIColor colorWithHex:0xef454b] forKey:@"backColor"];
        [node2 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node2];
        
        NSMutableDictionary* node3 = [NSMutableDictionary dictionary];
        [node3 setObject:@"cleanDarkBlue" forKey:@"imgName"];
        [node3 setObject:@"标题-2" forKey:@"title"];
        [node3 setObject:[UIColor colorWithHex:0x2da43a] forKey:@"backColor"];
        [node3 setObject:[UIColor colorWithHex:HexColorTypeDarkSlateBlue alpha:1] forKey:@"titleColor"];
        [cells addObject:node3];
        
        NSMutableDictionary* node4 = [NSMutableDictionary dictionary];
        [node4 setObject:@"wechatPayGray" forKey:@"imgName"];
        [node4 setObject:@"标题-3" forKey:@"title"];
        [node4 setObject:[UIColor colorWithHex:0x01abf0 alpha:1] forKey:@"backColor"];
        [node4 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node4];
        
        NSMutableDictionary* node5 = [NSMutableDictionary dictionary];
        [node5 setObject:@"alipayWhite" forKey:@"imgName"];
        [node5 setObject:@"标题-4" forKey:@"title"];
        [node5 setObject:[UIColor colorWithHex:0xef454b] forKey:@"backColor"];
        [node5 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node5];
        
        NSMutableDictionary* node6 = [NSMutableDictionary dictionary];
        [node6 setObject:@"alipayGray" forKey:@"imgName"];
        [node6 setObject:@"标题-5" forKey:@"title"];
        [node6 setObject:[UIColor colorWithHex:0x2da43a] forKey:@"backColor"];
        [node6 setObject:[UIColor whiteColor] forKey:@"titleColor"];
        [cells addObject:node6];
        
        NSMutableDictionary* node7 = [NSMutableDictionary dictionary];
        [node7 setObject:@"cleanDarkBlue" forKey:@"imgName"];
        [node7 setObject:@"标题-6" forKey:@"title"];
        [node7 setObject:[UIColor colorWithHex:0x01abf0] forKey:@"backColor"];
        [node7 setObject:[UIColor colorWithHex:HexColorTypeDarkSlateBlue alpha:1] forKey:@"titleColor"];
        [cells addObject:node7];

        _triScrollSegView = [[TriScrollSegmentView alloc] initWithSegInfos:cells andMidItemCliecked:^{
            NSLog(@" - - - - - -[点击了序号[%d]的item]", _triScrollSegView.curSegIndex);
        }];
    }
    return _triScrollSegView;
}


- (WHScrollAndPageView *)whScrollView {
    if (!_whScrollView) {
        CGFloat width = 160;
        _whScrollView = [[WHScrollAndPageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - width)*0.5, 64, width, width)];
        
        [_whScrollView setImageViewAry:self.imgArray];
        [_whScrollView shouldAutoShow:YES];
        
    }
    return _whScrollView;
}

- (NSMutableArray *)imgArray {
    if (!_imgArray) {
        _imgArray = [NSMutableArray array];
        [_imgArray addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cleanDarkBlue"]]];
        [_imgArray addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechatPayGray"]]];
        [_imgArray addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alipayGray"]]];
        [_imgArray addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sideMenuPic"]]];
        [_imgArray addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"JLPayLogo"]]];
        [_imgArray addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppLogoImage"]]];
        [_imgArray addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backScreen04"]]];
    }
    return _imgArray;
}


@end
