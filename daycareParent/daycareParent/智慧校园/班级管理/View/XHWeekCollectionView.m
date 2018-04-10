//
//  XHWeekCollectionView.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHWeekCollectionView.h"

@implementation XHWeekCollectionView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        
        
        
        for (int i = 1; i <= 5; i++)
        {
            XHWeekFrame *frame = [[XHWeekFrame alloc]init];
            XHWeekModel *model = [[XHWeekModel alloc]init];
            [model setType:XHWeekTipType];
            [model setTitle:[NSString stringWithFormat:@"周(%d)",i]];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        
        [self setDelegate:self];
        [self setDataSource:self];
        [self registerClass:[XHWeekCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        
    }
    return self;
}


- (void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self reloadData];
}


#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHWeekCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHWeekCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self.deletage respondsToSelector:@selector(didSelectItemObjectAtIndexPath:)])
//    {
//        [self.deletage didSelectItemObjectAtIndexPath:[self.dataArray objectAtIndex:indexPath.row]];
//    }
    
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHWeekFrame *frame = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(frame.itemSize.width,frame.itemSize.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



@end
