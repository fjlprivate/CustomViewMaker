//
//  TestForJBIG.m
//  CustomViewMaker
//
//  Created by jielian on 2016/11/21.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TestForJBIG.h"
#import "PublicHeader.h"
#import "JLJBIGEnCoder.h"
#import <ReactiveCocoa.h>
#import "ElecSignFrameView.h"
#import "ImageHelper.h"
#import "JLElecSignController.h"


@interface TestForJBIG ()

@property (nonatomic, strong) UILabel* stateLabel;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UIButton* encodingBtn;

@property (nonatomic, strong) UIButton* showSignV;

@property (nonatomic, strong) ElecSignFrameView* elecSignView;


@property (nonatomic, strong) RACCommand* cmd_showTimeOut;


@end

@implementation TestForJBIG


# pragma mask 2 IBAction
- (IBAction) clickedEncodingBtn:(id)sender {
//    [self makeSignViewEncoding];
    
}
- (IBAction) clickedShowV:(id)sender {
//    [self.elecSignView.elecSignView reSign];
    NSLog(@"-------显示签名");
    NameWeakSelf(wself);
    JLElecSignController* signCtrl = [JLElecSignController sharedElecSign];
    [signCtrl signWithCompletion:^{
        signCtrl.characteristicCode = @"2016-11-28";
        [wself makeSignViewEncoding];
    } orCancel:^{
        
    }];
}

- (void) makeSignViewEncoding {
    static int count;
    self.elecSignView.keyElementLabel.text = [NSString stringWithFormat:@"count%d", count++];
    size_t len = 0;
    UIImage* image = [ImageHelper elecSignImgWithView:[JLElecSignController sharedElecSign].elecSignView];
    unsigned char* bmpStr = [ImageHelper convertUIImageToBitmapRGBA8:image];
    
    unsigned char* jbigStr = JLJBIGEncode(bmpStr, image.size.width, image.size.height, &len);
    NSMutableString* ttt = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        [ttt appendFormat:@"%02x", jbigStr[i]];
    }
    free(jbigStr);
    self.stateLabel.text = ttt;
    NSLog(@"------完成编码[%@]",ttt);
    free(bmpStr);
    
    
    self.imageView.image = image;
}







- (void) addKVO {
    

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
    [self.view addSubview:self.imageView];
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
    frame.origin.x = self.view.frame.size.width * 0.5 + 10;
    self.encodingBtn.frame = frame;
    self.encodingBtn.layer.cornerRadius = frame.size.height * 0.5;
    
    frame.origin.x = self.view.frame.size.width * 0.5 - 10 - frame.size.width;
    self.showSignV.frame = frame;
    self.showSignV.layer.cornerRadius = frame.size.height * 0.5;
    
    frame.origin.y += frame.size.height + 40;
    CGFloat lastHeight = self.view.frame.size.height - frame.origin.y - 20;
    
    frame.size.height = (lastHeight - 10) / 2;
    frame.origin.x = inset;
    frame.size.width = width;
    self.stateLabel.frame = frame;
    
    frame.origin.y += frame.size.height + 10;
    frame.size.width = frame.size.height;
    frame.origin.x = (ScreenWidth - frame.size.width)/2 ;
    self.imageView.frame = frame;
    
    
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
        [_showSignV setTitle:@"重签" forState:UIControlStateNormal];
        [_showSignV setTitleColor:[UIColor colorWithHex:0xffffff alpha:1] forState:UIControlStateNormal];
        [_showSignV setTitleColor:[UIColor colorWithHex:0xffffff alpha:0.5] forState:UIControlStateHighlighted];
        _showSignV.backgroundColor = [UIColor colorWithHex:0x00bb9c alpha:1];
        [_showSignV addTarget:self action:@selector(clickedShowV:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showSignV;
}


- (ElecSignFrameView *)elecSignView {
    if (!_elecSignView) {
        _elecSignView = [[ElecSignFrameView alloc] init];
        _elecSignView.backgroundColor = [UIColor whiteColor];
    }
    return _elecSignView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor orangeColor];
    }
    return _imageView;
}


- (RACCommand *)cmd_showTimeOut {
    if (!_cmd_showTimeOut) {
        _cmd_showTimeOut = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                static NSInteger timecount = 0;
                self.stateLabel.text = [NSString stringWithFormat:@"%ld", timecount++];
                return nil;
            }] repeat];
        }];
    }
    return _cmd_showTimeOut;
}



@end
