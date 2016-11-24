//
//  JLElecSignController.m
//  JLPay
//
//  Created by jielian on 2016/11/14.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "JLElecSignController.h"
#import "JCAlertView.h"
#import "Masonry.h"

#import "UIColor+ColorWithHex.h"
#import "BitmapMaker.h"
#import "JLJBIGEnCoder.h"
#import <ReactiveCocoa.h>

#define NameWeakSelf(weakSelf)          __weak typeof(self) weakSelf = self;


@interface JLElecSignController()

/* 承载视图 */
@property (nonatomic, strong) UIView* bearView;

@property (nonatomic, strong) UIView* titleBackView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* titleDesLabel;

@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UIButton* sureBtn;
@property (nonatomic, strong) UIButton* resignBtn;

@property (nonatomic, copy) void (^ completionBlock) (void);
@property (nonatomic, copy) void (^ cancelBlock) (void);

@end

@implementation JLElecSignController


/*
 * 1. 电签视图加载在当前的 keyWindow 上
 * 2. 并且将其置为最顶层
 * 3. 底层背景色置为 黑色：半透明
 * 4. 并将 承载视图 从0放大到1
 * 5. 点击按钮后，承载视图缩小到0
 * 6. 并将
 */



- (void) signWithCompletion:(void (^)(void))completionBlock orCancel:(void (^)(void))cancel
{
    self.completionBlock = completionBlock;
    self.cancelBlock = cancel;

    [self.elecSignView.elecSignView reSign];
    self.elecSignView.keyElementLabel.text = nil;
    
    self.elecSignView.layer.cornerRadius = 10;
    [self shownAnimationOnFinished:nil];
}

- (void) rewriteCharacteristicCode:(NSString *)characteristicCode {
    self.elecSignView.layer.cornerRadius = 0;
    self.elecSignView.keyElementLabel.text = characteristicCode;
}






+ (instancetype) sharedElecSign {
    static JLElecSignController* sharedSignC ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSignC = [[JLElecSignController alloc] init];
    });
    return sharedSignC;
}


# pragma mask 1 IBActions 
- (IBAction) clickedCancelBtn:(id)sender {
    
//    self.hidden = YES;
//    if (self.delegate) {
//        [self.delegate doneWithEncoded];
//    }

    NameWeakSelf(wself);
    [self hiddenAnimationOnFinished:^{
        if (wself.cancelBlock) {
            wself.cancelBlock();
        }
    }];
}

- (IBAction) clickedSureBtn:(id)sender {
    NameWeakSelf(wself);
    
//    [self makeCurSignEncoded];
    
    [self hiddenAnimationOnFinished:^{
        if (wself.completionBlock) {
            wself.completionBlock();
        }
    }];
}

- (IBAction) clickedResignBtn:(id)sender {
    [self.elecSignView.elecSignView reSign];
}



- (void) shownAnimationOnFinished:(void (^) (void))finishedBlock {
    NameWeakSelf(wself);
    
//    [self loadSubviews];
//    [self relayoutSubviews];

    [UIView animateWithDuration:0.3 animations:^{
        wself.hidden = NO;
//        wself.bearView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
    }];
}
- (void) hiddenAnimationOnFinished:(void (^) (void))finishedBlock {
    NameWeakSelf(wself);
    [UIView animateWithDuration:0.3 animations:^{
//        wself.bearView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        wself.hidden = YES;
//        [wself removeAllSubviews];
        if (finished) finishedBlock();
    }];
}


# pragma mask 2 布局

- (void) initialFrames {
    CGFloat insetHorizontal = 10;
    CGFloat insetVertical = 4;
    CGFloat screenHeight = self.bounds.size.height;
    CGFloat screenWidth = self.bounds.size.width;
    
    CGFloat widthSignView = screenWidth - insetHorizontal * 2;
    widthSignView = widthSignView > 600 ? 600 : widthSignView;
    CGFloat heightSignView = widthSignView * 0.5;
    
    CGFloat heightTitleBack = heightSignView * 0.4;
    CGFloat heightTitle = (heightTitleBack - insetVertical * 2) * 0.56;
    
    CGFloat heightBtn = 45;
    CGFloat widthBtn = widthSignView * 0.35;
    
    self.cancelBtn.layer.cornerRadius = heightBtn * 0.5;
    self.sureBtn.layer.cornerRadius = heightBtn * 0.5;
    self.resignBtn.layer.cornerRadius = heightBtn * 2/3.f * 0.5;

    CGRect frame = CGRectMake(insetHorizontal, (screenHeight - heightSignView)/2, widthSignView, heightSignView);
    self.elecSignView.frame = frame;
    
    frame.origin.y -= insetVertical + heightTitleBack;
    frame.size.height = heightTitleBack;
    self.titleBackView.frame = frame;
    
    frame.origin.y += insetVertical;
    frame.size.height = heightTitle;
    self.titleLabel.frame = frame;
    
    frame.origin.y += frame.size.height;
    frame.size.height = heightTitleBack - heightTitle - insetVertical * 2;
    self.titleDesLabel.frame = frame;
    
    frame = self.titleDesLabel.frame ;
    frame.origin.y -= insetHorizontal * 1.4;
    frame.size.height = insetHorizontal * 1.4;
    frame.size.width = widthBtn * 2/3.f;
    frame.origin.x = (screenWidth - frame.size.width)/2.f;
    self.resignBtn.frame = frame;
    
    frame = self.elecSignView.frame;
    frame.origin.y += frame.size.height + insetHorizontal * 1.5;
    frame.size.width = widthBtn;
    frame.size.height = heightBtn;
    self.cancelBtn.frame = frame;
    
    frame.origin.x += widthSignView - widthBtn;
    self.sureBtn.frame = frame;
    
}

- (void) relayoutSubviews {
    NameWeakSelf(wself);
    
    CGFloat insetHorizontal = 10;
    CGFloat insetVertical = 4;
    
    CGFloat widthSignView = [UIScreen mainScreen].bounds.size.width - insetHorizontal * 2;
    widthSignView = widthSignView > 600 ? 600 : widthSignView;
    CGFloat heightSignView = widthSignView * 0.5;
    
    CGFloat heightTitleBack = heightSignView * 0.4;
    CGFloat heightTitle = (heightTitleBack - insetVertical * 2) * 0.56;
    
    CGFloat heightBtn = 45;
    CGFloat widthBtn = widthSignView * 0.35;
    
    self.cancelBtn.layer.cornerRadius = heightBtn * 0.5;
    self.sureBtn.layer.cornerRadius = heightBtn * 0.5;
    self.resignBtn.layer.cornerRadius = heightBtn * 2/3.f * 0.5;
    
    [self.elecSignView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(wself.bearView);
        make.width.mas_equalTo(widthSignView);
        make.height.mas_equalTo(heightSignView);
    }];
    
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.elecSignView.mas_left);
        make.width.mas_equalTo(widthBtn);
        make.top.mas_equalTo(wself.elecSignView.mas_bottom).offset(insetHorizontal * 1.5);
        make.height.mas_equalTo(heightBtn);
    }];
    
    [self.sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wself.elecSignView.mas_right);
        make.width.mas_equalTo(widthBtn);
        make.top.mas_equalTo(wself.elecSignView.mas_bottom).offset(insetHorizontal * 1.5);
        make.height.mas_equalTo(heightBtn);
    }];
    
    [self.titleBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(wself.elecSignView.mas_top).offset(- insetVertical);
        make.height.mas_equalTo(heightTitleBack);
        make.left.right.mas_equalTo(wself.elecSignView);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.titleBackView.mas_top).offset(insetVertical);
        make.left.right.mas_equalTo(wself.titleBackView);
        make.height.mas_equalTo(heightTitle);
    }];
    [self.titleDesLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.titleLabel.mas_bottom);
        make.left.right.mas_equalTo(wself.titleLabel);
        make.bottom.mas_equalTo(wself.titleBackView.mas_bottom).offset(- insetVertical);
    }];
    
    [self.resignBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(wself.titleBackView.mas_top).offset(- insetHorizontal * 1.4);
        make.height.mas_equalTo(heightBtn * 2/3.f);
        make.centerX.mas_equalTo(wself.elecSignView.mas_centerX);
        make.width.mas_equalTo(widthBtn * 2/3.f);
    }];
}

# pragma mask 3 初始化

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self loadSubviews];

        
//        @weakify(self);
//        [[[RACObserve(self.elecSignView.keyElementLabel, text) filter:^BOOL(NSString* value) {
//            return value && value.length > 0 ? YES : NO;
//        }] deliverOnMainThread] subscribeNext:^(id x) {
//            @strongify(self);
//            /* 对签名视图进行编码 */
//            
//        }];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self relayoutSubviews];
}

- (void) loadSubviews {
    [self addSubview:self.bearView];
    [self.bearView addSubview:self.titleBackView];
    [self.bearView addSubview:self.titleLabel];
    [self.bearView addSubview:self.titleDesLabel];
    [self.bearView addSubview:self.elecSignView];
    [self.bearView addSubview:self.cancelBtn];
    [self.bearView addSubview:self.sureBtn];
    [self.bearView addSubview:self.resignBtn];
    
//    self.bearView.transform = CGAffineTransformMakeScale(0, 0);
    self.hidden = YES;
}



- (void) makeCurSignEncoded {
    BitmapMaker* bmpMaker = [BitmapMaker new];
    size_t len = 0;
    NSLog(@"--=--=-  正在编码签名图片......");
    
    UILabel * testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 256)];
    testLabel.backgroundColor = [UIColor whiteColor];
    testLabel.text = @"sldfjlajsdlf";
    
    
    unsigned char* bmpStr = [bmpMaker bmpFromView:self.elecSignView];
    
    unsigned char* jbigEncoded = JLJBIGEncode(bmpStr,
                                              bmpMaker.bmpWidth,
                                              bmpMaker.bmpHeight,
                                              &len);
    
    NSLog(@"--=--=-  编码签名图片完成!");
    NSMutableString* jbigString = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        [jbigString appendFormat:@"%02x", jbigEncoded[i]];
    }
    free(bmpStr);
    //            free(jbigEncoded);
    self.elecSignJBIGEncoded = [NSString stringWithString:jbigString];
}


# pragma mask 4 getter


- (UIView *)bearView {
    if (!_bearView) {
        _bearView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bearView.backgroundColor = [UIColor clearColor];
    }
    return _bearView;
}

- (ElecSignFrameView *)elecSignView {
    if (!_elecSignView) {
        _elecSignView = [[ElecSignFrameView alloc] init];
        _elecSignView.backgroundColor = [UIColor whiteColor];
        _elecSignView.layer.masksToBounds = YES;
        _elecSignView.layer.shadowOpacity = 1;
        _elecSignView.layer.shadowOffset = CGSizeMake(0, 3);
    }
    return _elecSignView;
}

- (UIView *)titleBackView {
    if (!_titleBackView) {
        _titleBackView = [UIView new];
        _titleBackView.backgroundColor = [UIColor whiteColor];
        _titleBackView.layer.cornerRadius = 10.f;
    }
    return _titleBackView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"签名";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHex:0x27384b alpha:1];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _titleLabel;
}

- (UILabel *)titleDesLabel {
    if (!_titleDesLabel) {
        _titleDesLabel = [UILabel new];
        _titleDesLabel.text = @"请在下方空白框内签名";
        _titleDesLabel.textAlignment = NSTextAlignmentCenter;
        _titleDesLabel.textColor = [UIColor colorWithHex:0x999999 alpha:0.9];
        _titleDesLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleDesLabel;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_cancelBtn setTitleColor:[UIColor colorWithHex:0xef454b alpha:1] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHex:0xef454b alpha:0.5] forState:UIControlStateHighlighted];
        [_cancelBtn addTarget:self action:@selector(clickedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.layer.shadowOffset = CGSizeMake(0, 3);
        _cancelBtn.layer.shadowOpacity = 1;
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton new];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_sureBtn setTitleColor:[UIColor colorWithHex:0xffffff alpha:1] forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithHex:0xffffff alpha:0.5] forState:UIControlStateHighlighted];
        [_sureBtn addTarget:self action:@selector(clickedSureBtn:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.backgroundColor = [UIColor colorWithHex:0x00bb9c alpha:1];
        _sureBtn.layer.shadowOpacity = 1;
        _sureBtn.layer.shadowOffset = CGSizeMake(0, 3);
    }
    return _sureBtn;
}

- (UIButton *)resignBtn {
    if (!_resignBtn) {
        _resignBtn = [UIButton new];
        [_resignBtn setTitle:@"重签" forState:UIControlStateNormal];
        _resignBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_resignBtn setTitleColor:[UIColor colorWithHex:0xffffff alpha:1] forState:UIControlStateNormal];
        [_resignBtn setTitleColor:[UIColor colorWithHex:0xffffff alpha:0.5] forState:UIControlStateHighlighted];
        [_resignBtn addTarget:self action:@selector(clickedResignBtn:) forControlEvents:UIControlEventTouchUpInside];
        _resignBtn.backgroundColor = [UIColor colorWithHex:0x27384b alpha:0.9];
    }
    return _resignBtn;
}

@end
