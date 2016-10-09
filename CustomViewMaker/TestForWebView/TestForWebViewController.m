//
//  TestForWebViewController.m
//  CustomViewMaker
//
//  Created by jielian on 16/10/9.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForWebViewController.h"
#import "MBProgressHUD+CustomSate.h"



@interface TestForWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView* webView;

@property (nonatomic, strong) MBProgressHUD* hud;


@end

@implementation TestForWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = YES;
    self.webView.opaque = NO;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSURL* url = [NSURL URLWithString:@"http://posp.unitepay.com.cn/jlagent/tradequery/query_queryTrade.asp?mchtNo=898584054111621"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:self.hud];
}

# pragma mask UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.hud show:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.hud hide:YES];
}



# pragma mask 4 getter

- (MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hud;
}

@end
