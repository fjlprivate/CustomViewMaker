//
//  TestForJBIG.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/21.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForJBIG.h"
#import "PublicHeader.h"
#import "BitmapMaker.h"
#import "JLJBIGEnCoder.h"
#import <ReactiveCocoa.h>

#import "JLElecSignController.h"


@interface TestForJBIG ()

@property (nonatomic, strong) UILabel* stateLabel;
@property (nonatomic, strong) UIButton* encodingBtn;

@property (nonatomic, strong) UIButton* showSignV;

@property (nonatomic, strong) ElecSignFrameView* elecSignView;

@property (nonatomic, strong) JLElecSignController* elecSignC;


@end

@implementation TestForJBIG


# pragma mask 2 IBAction
- (IBAction) clickedEncodingBtn:(id)sender {
//    [[JLElecSignController sharedElecSign] rewriteCharacteristicCode:@"2016-11"];
//    [self.elecSignC makeCurSignEncoded];
    
    
    self.elecSignView.keyElementLabel.text = @"sdfjdlfj";

    
}
- (IBAction) clickedShowV:(id)sender {
    [self.elecSignC signWithCompletion:^{
            BitmapMaker* bmpMaker = [BitmapMaker new];
            size_t len = 0;
            unsigned char* bmpStr = [bmpMaker bmpFromView:self.elecSignC.elecSignView];
            unsigned char* jbigStr = JLJBIGEncode(bmpStr, bmpMaker.bmpWidth, bmpMaker.bmpHeight, bmpMaker.bmpTotalSize, &len);
            NSMutableString* ttt = [NSMutableString string];
            for (int i = 0; i < len; i++) {
                [ttt appendFormat:@"%02x", jbigStr[i]];
            }
            free(jbigStr);
            self.stateLabel.text = ttt;
        NSLog(@"------完成编码[%@]",ttt);
        free(bmpStr);
        
    } orCancel:^{
        
    }];
}



- (void) addKVO {
//    @weakify(self);
//    [[RACObserve(self.elecSignView.keyElementLabel, text) filter:^BOOL(NSString* value) {
//        return value && value.length > 0 ? YES : NO;
//    }] subscribeNext:^(id x) {
//        @strongify(self);
//        BitmapMaker* bmpMaker = [BitmapMaker new];
//        size_t len = 0;
//        
//        unsigned char* bmpStr = [bmpMaker bmpFromView:self.elecSignView];
//        unsigned char* jbigStr = JLJBIGEncode(bmpStr, bmpMaker.bmpWidth, bmpMaker.bmpHeight, bmpMaker.bmpTotalSize, &len);
//        NSMutableString* ttt = [NSMutableString string];
//        for (int i = 0; i < len; i++) {
//            [ttt appendFormat:@"%02x", jbigStr[i]];
//        }
//        free(jbigStr);
//        NSLog(@"------完成编码");
//        self.stateLabel.text = ttt;
//
//    }];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    [self loadSubviews];
    [self layoutSubviews];
    [self addKVO];
}

- (void) loadSubviews {
    [self.view addSubview:self.elecSignView];
    [self.view addSubview:self.stateLabel];
    [self.view addSubview:self.encodingBtn];
    [self.view addSubview:self.showSignV];
    [self.view addSubview:self.elecSignC];
}
- (void) layoutSubviews {
    CGFloat inset = 15;
    
    CGFloat width = self.view.frame.size.width - inset * 2;
    
    CGFloat widthBtn = 80;
    CGFloat heightBtn = 40;
    CGFloat heightLabel = 120;
    
    CGRect frame = CGRectMake(inset, 64 + 20, width, heightLabel);
    self.elecSignView.frame = frame;
    
    
    frame.origin.y += frame.size.height + 20;
    frame.size.height = heightBtn;
    frame.size.width = widthBtn;
//    frame.origin.x = (self.view.frame.size.width - widthBtn)/2;
    frame.origin.x = self.view.frame.size.width * 0.5 + 10;
    self.encodingBtn.frame = frame;
    self.encodingBtn.layer.cornerRadius = frame.size.height * 0.5;
    
    frame.origin.x = self.view.frame.size.width * 0.5 - 10 - frame.size.width;
    self.showSignV.frame = frame;
    self.showSignV.layer.cornerRadius = frame.size.height * 0.5;
    
    frame.origin.y += frame.size.height + 40;
    frame.size.height = self.view.frame.size.height - frame.origin.y - 20;
    frame.origin.x = inset;
    frame.size.width = width;
    self.stateLabel.frame = frame;
    
    
}



# pragma mask 4 getter

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.font = [UIFont systemFontOfSize:11];
        _stateLabel.numberOfLines = 0;
        _stateLabel.backgroundColor = [UIColor whiteColor];
    }
    return _stateLabel;
}

- (UIButton *)encodingBtn {
    if (!_encodingBtn) {
        _encodingBtn = [UIButton new];
        [_encodingBtn setTitle:@"编码" forState:UIControlStateNormal];
        [_encodingBtn setTitleColor:[UIColor colorWithHex:0xffffff alpha:1] forState:UIControlStateNormal];
        [_encodingBtn setTitleColor:[UIColor colorWithHex:0xffffff alpha:0.5] forState:UIControlStateHighlighted];
        _encodingBtn.backgroundColor = [UIColor colorWithHex:0x00bb9c alpha:1];
        [_encodingBtn addTarget:self action:@selector(clickedEncodingBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _encodingBtn;
}

- (UIButton *)showSignV {
    if (!_showSignV) {
        _showSignV = [UIButton new];
        [_showSignV setTitle:@"签名" forState:UIControlStateNormal];
        [_showSignV setTitleColor:[UIColor colorWithHex:0xffffff alpha:1] forState:UIControlStateNormal];
        [_showSignV setTitleColor:[UIColor colorWithHex:0xffffff alpha:0.5] forState:UIControlStateHighlighted];
        _showSignV.backgroundColor = [UIColor colorWithHex:0x00bb9c alpha:1];
        [_showSignV addTarget:self action:@selector(clickedShowV:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showSignV;
}

- (JLElecSignController *)elecSignC {
    if (!_elecSignC) {
        _elecSignC = [[JLElecSignController alloc] initWithFrame:self.view.bounds];
    }
    return _elecSignC;
}

- (ElecSignFrameView *)elecSignView {
    if (!_elecSignView) {
        _elecSignView = [[ElecSignFrameView alloc] init];
        _elecSignView.backgroundColor = [UIColor whiteColor];
    }
    return _elecSignView;
}


@end
