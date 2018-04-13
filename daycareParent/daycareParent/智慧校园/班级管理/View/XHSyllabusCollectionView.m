//
//  XHSyllabusCollectionView.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSyllabusCollectionView.h"


@interface XHSyllabusCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) NSMutableArray *itemdataArray;
@end

@implementation XHSyllabusCollectionView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self registerClass:[XHWeekCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
}




-(void)setItemArray:(NSMutableArray *)itemArray
{
    NSInteger itemArrayCount = [itemArray count];
    [self resetHeight:(itemArrayCount ? (itemArrayCount*50.0) : 100)];
//    [self setHeight:(itemArrayCount*50.0)];
    [self.dataArray setArray:itemArray];
    [self refreshReloadData];
}



#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(BaseCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [collectionView tipViewWithArray:self.dataArray];
    return [self.dataArray count];
}




- (XHWeekCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHWeekCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
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
