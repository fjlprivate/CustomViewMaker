//
//  TVCI_vmDatasource.m
//  CustomViewMaker
//
//  Created by jielian on 2017/1/5.
//  Copyright © 2017年 ShenzhenJielian. All rights reserved.
//

#import "TVCI_vmDatasource.h"
#import "TVCI_vCell.h"
#import "PublicHeader.h"

@implementation TVCI_vmDatasource

# pragma mask 2 UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString* type = [self.fontTypes objectAtIndex:self.curFontIndex];
    if ([type isEqualToString:@"FontAwesome"]) {
        return FAusb - FAGlass + 1;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TVCI_vCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TVCI_vCell" forIndexPath:indexPath];
    NSString* type = [self.fontTypes objectAtIndex:self.curFontIndex];
    if ([type isEqualToString:@"FontAwesome"]) {
        cell.iconLabel.text = [NSString fontAwesomeIconStringForEnum:indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    } else {
        
    }
    return cell;
}





# pragma mask 4 getter
- (NSArray *)fontTypes {
    if (!_fontTypes) {
        _fontTypes = @[@"FontAwesome", @"IconFont"];
    }
    return _fontTypes;
}


@end
