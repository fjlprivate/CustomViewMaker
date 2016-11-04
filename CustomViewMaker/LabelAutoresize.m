//
//  LabelAutoresize.m
//  CustomViewMaker
//
//  Created by jielian on 16/9/12.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "LabelAutoresize.h"
#import <ReactiveCocoa.h>
#import "Masonry.h"
#import "UIColor+ColorWithHex.h"
#import <UIFont+FontAwesome.h>
#import <NSString+FontAwesome.h>

#import "NSAttributedString+FontAwesomeString.h"

@interface LabelAutoresize()

@property (nonatomic, strong) UILabel* testLabel;


@end




@implementation LabelAutoresize


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LabelAutoresize";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.testLabel];
    self.testLabel.frame = CGRectMake(100, 100, 160, 40);
}







# pragma maks : getter

- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [UILabel new];
        //_testLabel.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
        
        _testLabel.layer.masksToBounds = YES;
        _testLabel.layer.cornerRadius = 5;

        _testLabel.attributedText = [NSAttributedString stringWithAwesomeText:[NSString fontAwesomeIconStringForEnum:FACheck] awesomeFont:[UIFont fontAwesomeFontOfSize:18] awesomeColor:[UIColor colorWithHex:0x00bb9c alpha:1] text:@"testAwesomeText" textFont:[UIFont boldSystemFontOfSize:16] textColor:[UIColor colorWithHex:0x27384b alpha:1]];
        
        
    }
    return _testLabel;
}



@end
