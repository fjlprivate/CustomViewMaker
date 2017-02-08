//
//  MLPullMenu.m
//  CustomViewMaker
//
//  Created by jielian on 2017/2/6.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "MLPullMenu.h"
#import "PublicHeader.h"


# define MLPMenuTriWidth        10.f
# define MLPMenuCorner          4.f

#define MLPSuperVWidth          self.superview.frame.size.width
#define MLPSuperVHeight         self.superview.frame.size.height


# pragma mask ----------- MLPMenuView -----------

@interface MLPMenuView : UIView

@property (nonatomic, strong) UITableView* tableView;   // 表视图
@property (nonatomic, strong) CAShapeLayer* bgLayer;    // 背景图层
/* 展开三角形在本视图边框的比例: 0.0(最左or上)-1.0(最右or下) */
@property (nonatomic, assign) CGFloat ratioPullTriLocation;

@property (nonatomic, assign) MLPullMenuDirection pullDirection;    // 展开方向

@end

@implementation MLPMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.bgLayer];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    CGFloat triWidth = MLPMenuTriWidth;
    CGFloat inset = triWidth * sqrt(3.f) * 0.5;
    
    CGFloat hStart  = self.pullDirection == MLPullMenuDirectionRight ? inset : 0;
    CGFloat hEnd    = self.pullDirection == MLPullMenuDirectionLeft  ? selfWidth - inset : selfWidth;
    CGFloat vStart  = self.pullDirection == MLPullMenuDirectionDown ? inset : 0;
    CGFloat vEnd    = self.pullDirection == MLPullMenuDirectionUp ? selfHeight - inset : selfHeight;

    self.bgLayer.frame = self.bounds;
    
    [self.tableView setFrame:CGRectMake(hStart, vStart, hEnd - hStart, vEnd - vStart)];
    [self relayoutBgLayer];
    
}

- (void) relayoutBgLayer {
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    CGFloat cornerRadius = MLPMenuCorner;
    CGFloat triWidth = MLPMenuTriWidth;
    CGFloat inset = triWidth * sqrt(3.f) * 0.5;
    
    CGFloat hStart  = self.pullDirection == MLPullMenuDirectionRight ? inset : 0;
    CGFloat hEnd    = self.pullDirection == MLPullMenuDirectionLeft  ? selfWidth - inset : selfWidth;
    CGFloat vStart  = self.pullDirection == MLPullMenuDirectionDown ? inset : 0;
    CGFloat vEnd    = self.pullDirection == MLPullMenuDirectionUp ? selfHeight - inset : selfHeight;
    
    
    CGPoint lPointUpU = CGPointMake(hStart + cornerRadius, vStart);
    CGPoint lPointUpD = CGPointMake(hStart, vStart + cornerRadius);
    CGPoint lPointCtrlUp = CGPointMake(hStart, vStart);
    
    CGPoint lPointDownU = CGPointMake(hStart, vEnd - cornerRadius);
    CGPoint lPointDownD = CGPointMake(hStart + cornerRadius, vEnd);
    CGPoint lPointCtrlDown = CGPointMake(hStart, vEnd);
    
    CGPoint rPointUpU = CGPointMake(hEnd - cornerRadius, vStart);
    CGPoint rPointUpD = CGPointMake(hEnd, vStart + cornerRadius);
    CGPoint rPointCtrlUp = CGPointMake(hEnd, vStart);
    
    CGPoint rPointDownU = CGPointMake(hEnd, vEnd - cornerRadius);
    CGPoint rPointDownD = CGPointMake(hEnd - cornerRadius, vEnd);
    CGPoint rPointCtrlDown = CGPointMake(hEnd, vEnd);

    
    CGPoint tPointStart1;
    CGPoint tPointStart2;
    CGPoint tPointCtrlStart;

    CGPoint tPointMid1;
    CGPoint tPointMid2;
    CGPoint tPointCtrlMid;

    CGPoint tPointEnd1;
    CGPoint tPointEnd2;
    CGPoint tPointCtrlEnd;

    
    CGFloat midX = cornerRadius * 2 + triWidth * 0.5 + (selfWidth - cornerRadius * 4 - triWidth) * self.ratioPullTriLocation;
    CGFloat midY = cornerRadius * 2 + triWidth * 0.5 + (selfHeight - cornerRadius * 4 - triWidth) * self.ratioPullTriLocation;

    switch (self.pullDirection) {
        case MLPullMenuDirectionDown:
        {
            tPointStart1 = CGPointMake(midX - triWidth * 0.5 - cornerRadius, inset);
            tPointStart2 = CGPointMake(midX - triWidth * 0.5 + cornerRadius * 0.5, inset - cornerRadius * sqrt(3.f) * 0.5);
            tPointCtrlStart = CGPointMake(midX - triWidth * 0.5, inset);
            
            tPointEnd1 = CGPointMake(midX + triWidth * 0.5 - cornerRadius * 0.5, inset - cornerRadius * sqrt(3.f) * 0.5);
            tPointEnd2 = CGPointMake(midX + triWidth * 0.5 + cornerRadius, inset);
            tPointCtrlEnd = CGPointMake(midX + triWidth * 0.5, inset);
            
            tPointMid1 = CGPointMake(midX - cornerRadius * 0.5, cornerRadius * sqrt(3.f) * 0.5);
            tPointMid2 = CGPointMake(midX + cornerRadius * 0.5, cornerRadius * sqrt(3.f) * 0.5);
            tPointCtrlMid = CGPointMake(midX, 0);
        }
            break;
        case MLPullMenuDirectionUp:
        {
            tPointStart1 = CGPointMake(midX + triWidth * 0.5 + cornerRadius, vEnd);
            tPointStart2 = CGPointMake(midX + triWidth * 0.5 - cornerRadius * 0.5, vEnd + cornerRadius * sqrt(3.f) * 0.5);
            tPointCtrlStart = CGPointMake(midX + triWidth * 0.5, vEnd);
            
            tPointEnd1 = CGPointMake(midX - triWidth * 0.5 + cornerRadius * 0.5, vEnd + cornerRadius * sqrt(3.f) * 0.5);
            tPointEnd2 = CGPointMake(midX - triWidth * 0.5 - cornerRadius, vEnd);
            tPointCtrlEnd = CGPointMake(midX - triWidth * 0.5, vEnd);
            
            tPointMid1 = CGPointMake(midX + cornerRadius * 0.5, selfHeight - cornerRadius * sqrt(3.f) * 0.5);
            tPointMid2 = CGPointMake(midX - cornerRadius * 0.5, selfHeight - cornerRadius * sqrt(3.f) * 0.5);
            tPointCtrlMid = CGPointMake(midX, selfHeight);
        }
            break;
        case MLPullMenuDirectionLeft:
        {
            tPointStart1 = CGPointMake(hEnd, midY - triWidth * 0.5 - cornerRadius);
            tPointStart2 = CGPointMake(hEnd + cornerRadius * sqrt(3.f) * 0.5, midY - triWidth * 0.5 + cornerRadius * 0.5);
            tPointCtrlStart = CGPointMake(hEnd, midY - triWidth * 0.5);
            
            tPointEnd1 = CGPointMake(hEnd + cornerRadius * sqrt(3.f) * 0.5, midY + triWidth * 0.5 - cornerRadius * 0.5);
            tPointEnd2 = CGPointMake(hEnd, midY + triWidth * 0.5 + cornerRadius);
            tPointCtrlEnd = CGPointMake(hEnd, midY + triWidth * 0.5);
            
            tPointMid1 = CGPointMake(selfWidth - cornerRadius * sqrt(3.f) * 0.5, midY - cornerRadius * 0.5);
            tPointMid2 = CGPointMake(selfWidth - cornerRadius * sqrt(3.f) * 0.5, midY + cornerRadius * 0.5);
            tPointCtrlMid = CGPointMake(selfWidth, midY);
        }
            break;
        case MLPullMenuDirectionRight:
        {
            tPointStart1 = CGPointMake(hStart, midY + triWidth * 0.5 + cornerRadius);
            tPointStart2 = CGPointMake(hStart - cornerRadius * sqrt(3.f) * 0.5, midY + triWidth * 0.5 - cornerRadius * 0.5);
            tPointCtrlStart = CGPointMake(hStart, midY + triWidth * 0.5);
            
            tPointEnd1 = CGPointMake(hStart - cornerRadius * sqrt(3.f) * 0.5, midY - triWidth * 0.5 + cornerRadius * 0.5);
            tPointEnd2 = CGPointMake(hStart, midY - triWidth * 0.5 - cornerRadius);
            tPointCtrlEnd = CGPointMake(hStart, midY - triWidth * 0.5);
            
            tPointMid1 = CGPointMake(cornerRadius * sqrt(3.f) * 0.5, midY + cornerRadius * 0.5);
            tPointMid2 = CGPointMake(cornerRadius * sqrt(3.f) * 0.5, midY - cornerRadius * 0.5);
            tPointCtrlMid = CGPointMake(0, midY);
        }
            break;
        default:
            break;
    }
    
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    [path moveToPoint:lPointUpD];
    [path addQuadCurveToPoint:lPointUpU controlPoint:lPointCtrlUp];
    
    if (self.pullDirection == MLPullMenuDirectionDown) {
        [path addLineToPoint:tPointStart1];
        [path addQuadCurveToPoint:tPointStart2 controlPoint:tPointCtrlStart];
        [path addLineToPoint:tPointMid1];
        [path addQuadCurveToPoint:tPointMid2 controlPoint:tPointCtrlMid];
        [path addLineToPoint:tPointEnd1];
        [path addQuadCurveToPoint:tPointEnd2 controlPoint:tPointCtrlEnd];
    }
    
    [path addLineToPoint:rPointUpU];
    [path addQuadCurveToPoint:rPointUpD controlPoint:rPointCtrlUp];
    
    if (self.pullDirection == MLPullMenuDirectionLeft) {
        [path addLineToPoint:tPointStart1];
        [path addQuadCurveToPoint:tPointStart2 controlPoint:tPointCtrlStart];
        [path addLineToPoint:tPointMid1];
        [path addQuadCurveToPoint:tPointMid2 controlPoint:tPointCtrlMid];
        [path addLineToPoint:tPointEnd1];
        [path addQuadCurveToPoint:tPointEnd2 controlPoint:tPointCtrlEnd];
    }

    [path addLineToPoint:rPointDownU];
    [path addQuadCurveToPoint:rPointDownD controlPoint:rPointCtrlDown];

    if (self.pullDirection == MLPullMenuDirectionUp) {
        [path addLineToPoint:tPointStart1];
        [path addQuadCurveToPoint:tPointStart2 controlPoint:tPointCtrlStart];
        [path addLineToPoint:tPointMid1];
        [path addQuadCurveToPoint:tPointMid2 controlPoint:tPointCtrlMid];
        [path addLineToPoint:tPointEnd1];
        [path addQuadCurveToPoint:tPointEnd2 controlPoint:tPointCtrlEnd];
    }

    [path addLineToPoint:lPointDownD];
    [path addQuadCurveToPoint:lPointDownU controlPoint:lPointCtrlDown];

    if (self.pullDirection == MLPullMenuDirectionRight) {
        [path addLineToPoint:tPointStart1];
        [path addQuadCurveToPoint:tPointStart2 controlPoint:tPointCtrlStart];
        [path addLineToPoint:tPointMid1];
        [path addQuadCurveToPoint:tPointMid2 controlPoint:tPointCtrlMid];
        [path addLineToPoint:tPointEnd1];
        [path addQuadCurveToPoint:tPointEnd2 controlPoint:tPointCtrlEnd];
    }

    [path addLineToPoint:lPointUpD];
    [path closePath];
    
    self.bgLayer.path = path.CGPath;
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (CAShapeLayer *)bgLayer {
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer layer];
    }
    return _bgLayer;
}

@end


# pragma mask ----------- MLPullMenu -----------

@interface MLPullMenu() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MLPMenuView* menuView;    // 容器
@property (nonatomic, copy) NSArray* items;             // 菜单标题组
@property (nonatomic, assign) MLPullMenuDirection pullDirection;    // 展开方向
@property (nonatomic, copy) void (^ selectedMenuIndex) (NSInteger index);    // 选择菜单项回调
@property (nonatomic, assign) CGPoint startPoint;       // 展开三角顶点在superView的坐标

@end


@implementation MLPullMenu

# pragma mask 0 外部调用

- (void)showWithItems:(NSArray<NSString *> *)items
         onStartPoint:(CGPoint)startPoint
         andDirection:(MLPullMenuDirection)direction
            onClicked:(void (^)(NSInteger))clickedBlock
{
    self.items = items;
    self.pullDirection = direction;
    self.selectedMenuIndex = clickedBlock;
    self.startPoint = startPoint;
    
    // 初始化
    [self initialBeforeAnimation];
    // 执行显示动画
    self.hidden = NO;
    self.isPulled = YES;
}

- (void)hide {
    // 执行消失动画
    self.isPulled = NO;
    self.hidden = YES;
}


# pragma mask 1 动画设计

/* 初始化视图状态 */
- (void) initialBeforeAnimation {
    self.menuView.pullDirection = self.pullDirection;
    
    self.menuView.bgLayer.fillColor = self.tintColor.CGColor;
    
    if (self.enableShadow) {
        self.menuView.bgLayer.shadowColor = self.tintColor.CGColor;
        self.menuView.bgLayer.shadowOffset = CGSizeMake(3, 3);
        self.menuView.bgLayer.shadowOpacity = 1;
    } else {
        self.menuView.bgLayer.shadowColor = [UIColor clearColor].CGColor;
        self.menuView.bgLayer.shadowOffset = CGSizeZero;
        self.menuView.bgLayer.shadowOpacity = 0;
    }
    
    self.menuView.tableView.scrollEnabled = self.items.count > 5 ? YES : NO;
    
    self.menuView.tableView.rowHeight = self.rowHeight;
    
    // setup frame
    CGFloat selfWidth = [self maxTextWidthInItems];
    CGFloat cornerRadius = MLPMenuCorner;
    CGFloat triWidth = MLPMenuTriWidth;
    CGFloat triHeight = triWidth * sqrt(3.f) * 0.5;
    CGFloat selfHeight = (self.items.count > 5 ? 5 : self.items.count) * self.rowHeight + triHeight;

    CGRect frame = CGRectZero;
    frame.size.width = selfWidth;
    frame.size.height = selfHeight;
    
    switch (self.pullDirection) {
        case MLPullMenuDirectionDown:
            frame.origin.y = self.startPoint.y;
            break;
        case MLPullMenuDirectionUp:
            frame.origin.y = self.startPoint.y - frame.size.height;
            break;
        case MLPullMenuDirectionLeft:
            frame.origin.x = self.startPoint.x - frame.size.width;
            break;
        case MLPullMenuDirectionRight:
            frame.origin.x = self.startPoint.x;
            break;

        default:
            break;
    }
    
    CGFloat insetGap = 5;
    switch (self.pullDirection) {
        case MLPullMenuDirectionDown:
        case MLPullMenuDirectionUp:
        {
            if (self.startPoint.x - (cornerRadius * 2 + triWidth * 0.5) < self.edges.left) {
                self.menuView.ratioPullTriLocation = 0;
                frame.origin.x = self.edges.left + insetGap;
            }
            else if (self.startPoint.x + (cornerRadius * 2 + triWidth * 0.5) > MLPSuperVWidth - self.edges.right) {
                self.menuView.ratioPullTriLocation = 1;
                frame.origin.x = MLPSuperVWidth - self.edges.right - selfWidth - insetGap;
            }
            else if (self.startPoint.x - self.edges.left < selfWidth * 0.5) {
                self.menuView.ratioPullTriLocation = (self.startPoint.x - self.edges.left - (cornerRadius * 2 + triWidth * 0.5 + insetGap))/(selfWidth - cornerRadius * 4 - triWidth);
                frame.origin.x = self.edges.left + insetGap;
            }
            else if (MLPSuperVWidth - self.startPoint.x < selfWidth * 0.5 + self.edges.right) {
                CGFloat offsetX = MLPSuperVWidth - selfWidth - insetGap - self.edges.right;
                self.menuView.ratioPullTriLocation = (self.startPoint.x - offsetX - (cornerRadius * 2 + triWidth * 0.5))/(selfWidth - cornerRadius * 4 - triWidth);
                frame.origin.x = MLPSuperVWidth - self.edges.right - selfWidth - insetGap;
            }
            else {
                self.menuView.ratioPullTriLocation = 0.5;
                frame.origin.x = self.startPoint.x - selfWidth * 0.5;
            }
        }
            break;
        case MLPullMenuDirectionLeft:
        case MLPullMenuDirectionRight:
        {
            if (self.startPoint.y - (cornerRadius * 2 + triWidth * 0.5) < self.edges.top) {
                self.menuView.ratioPullTriLocation = 0;
                frame.origin.y = self.edges.top + insetGap;
            }
            else if (self.startPoint.y + (cornerRadius * 2 + triWidth * 0.5) > MLPSuperVHeight - self.edges.bottom) {
                self.menuView.ratioPullTriLocation = 1;
                frame.origin.y = MLPSuperVHeight - self.edges.bottom - selfHeight - insetGap;
            }
            else if (self.startPoint.y - self.edges.top < selfHeight * 0.5) {
                self.menuView.ratioPullTriLocation = (self.startPoint.y - self.edges.top - (cornerRadius * 2 + triWidth * 0.5 + insetGap))/(selfHeight - cornerRadius * 4 - triWidth);
                frame.origin.y = self.edges.top + insetGap;
            }
            else if (MLPSuperVHeight - self.startPoint.y < selfHeight * 0.5 + self.edges.bottom) {
                CGFloat offsetY = MLPSuperVHeight - selfHeight - insetGap - self.edges.bottom;
                self.menuView.ratioPullTriLocation = (self.startPoint.y - offsetY - (cornerRadius * 2 + triWidth * 0.5))/(selfHeight - cornerRadius * 4 - triWidth);
                frame.origin.y = MLPSuperVHeight - selfHeight - insetGap - self.edges.bottom;
            }
            else {
                self.menuView.ratioPullTriLocation = 0.5;
                frame.origin.y = self.startPoint.y - selfHeight * 0.5;
            }
        }
            break;

        default:
            break;
    }
    
    self.frame = frame;
    self.menuView.frame = self.bounds;
    [self.menuView.tableView reloadData];
}

/* 执行显示动画 */
- (void) showAnimationOnCompletion:(void (^) (void))completion {
    
}

/* 执行消失动画 */
- (void) hideAnimationOnCompletion:(void (^) (void))completion {
    
}

# pragma mask 1 tools

- (CGFloat) maxTextWidthInItems {
    CGFloat maxWidth = 0;
    for (NSString* text in self.items) {
        UIFont* font = [UIFont boldSystemFontOfSize:[NSString resizeFontAtHeight:self.rowHeight scale:0.45]];
        CGFloat textWidth = [text sizeWithAttributes:@{NSFontAttributeName:font}].width * 1.6;
        if (maxWidth < textWidth) maxWidth = textWidth;
    }
    return maxWidth;
}


# pragma mask 2 UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NameWeakSelf(wself);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (wself.selectedMenuIndex) {
            wself.selectedMenuIndex(indexPath.row);
        }
    });
}

# pragma mask 2 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:[NSString resizeFontAtHeight:self.rowHeight scale:0.45]];
        cell.textLabel.textColor = self.textColor;
        cell.backgroundColor = [UIColor clearColor];
        CGRect frame = [tableView rectForRowAtIndexPath:indexPath];
        frame.origin.x = frame.origin.y = 0;
        UIView* backView = [[UIView alloc] initWithFrame:frame];
        backView.backgroundColor = self.selectedColor;
        backView.layer.cornerRadius = MLPMenuCorner;
        cell.selectedBackgroundView = backView;
    }
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}


# pragma mask 3 布局&生命周期

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialDatas];
        [self loadSubviews];
    }
    return self;
}

- (void) loadSubviews {
    [self addSubview:self.menuView];
}

- (void) initialDatas {
    self.rowHeight = 35.f;
    self.isPulled = NO;
    self.tintColor = [UIColor colorWithHex:0x27384b alpha:1];
    self.selectedColor = [UIColor colorWithHex:0x000000 alpha:0.2];
    self.textColor = [UIColor colorWithHex:0xffffff alpha:1];
    self.enableShadow = YES;
    self.edges = UIEdgeInsetsZero;
    self.hidden = YES;
    self.userInteractionEnabled = YES;
}


# pragma mask 4 getter

- (MLPMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[MLPMenuView alloc] init];
        _menuView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuView.tableView.backgroundColor = [UIColor clearColor];
        _menuView.tableView.delegate = self;
        _menuView.tableView.dataSource = self;
    }
    return _menuView;
}

@end
