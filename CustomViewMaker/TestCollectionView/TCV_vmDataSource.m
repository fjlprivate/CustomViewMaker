//
//  TCV_vmDataSource.m
//  CustomViewMaker
//
//  Created by jielian on 2016/12/7.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#import "TCV_vmDataSource.h"
#import "UIColor+ColorWithHex.h"
#import "CustomCollectionViewCell.h"

@implementation TCV_vmDataSource

# pragma mask 2 UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell" forIndexPath:indexPath];
    
    TCV_mItem* item = [self.items objectAtIndex:indexPath.row];
    cell.backgroundColor = item.backColor;
    cell.label.text = item.text;
    cell.label.textColor = item.textColor;
    
    return cell;
}



# pragma mask 4 getter

- (NSArray<TCV_mItem *> *)items {
    if (!_items) {
        NSMutableArray* array = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            NSInteger red = (arc4random() % 0xff) << 16;
            NSInteger green = (arc4random() % 0xff) << 8;
            NSInteger blue = (arc4random() % 0xff) << 0;

            [array addObject:[[TCV_mItem alloc] initWithBackColor:[UIColor colorWithHex:(red | green | blue) alpha:1]
                                                             text:[NSString stringWithFormat:@"item%02d", i]
                                                        textColor:[UIColor colorWithHex:0xffffff alpha:1]]];
        }
        _items = [NSArray arrayWithArray:array];
    }
    return _items;
}


@end
