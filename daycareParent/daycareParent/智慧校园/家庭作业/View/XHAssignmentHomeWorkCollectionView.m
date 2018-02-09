//
//  XHAssignmentHomeWorkCollectionView.m
//  daycareParent
//
//  Created by Git on 2018/2/6.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAssignmentHomeWorkCollectionView.h"
#import "XHAssignmentHomeWorkCollectionViewCell.h"
#import "XHDynamicsPreviewControl.h"


@interface XHAssignmentHomeWorkCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource,XHAssignmentHomeWorkCollectionViewCellDeletage>



@end

@implementation XHAssignmentHomeWorkCollectionView



-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self)
    {
        [self registerClass:[XHAssignmentHomeWorkCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBounces:NO];
    }
    return self;
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
}




#pragma mark - Getter / Setter



//!< 数组指针传递，里面删除之后外面也同时删除
-(void)setItemArray:(NSMutableArray*)array
{
    [self.dataArray setArray:array];
    [self reloadData];
}



#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHAssignmentHomeWorkCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHAssignmentHomeWorkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setModel:[self.dataArray objectAtIndex:indexPath.row]];
    [cell setDeletage:self];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHDynamicsPreviewControl *dynamicsPreview = [[XHDynamicsPreviewControl alloc]init];
    [dynamicsPreview setItemArray:self.dataArray];
    [dynamicsPreview show];
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHPreviewModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(model.itemSize.width,model.itemSize.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark XHAssignmentHomeWorkCollectionViewCellDeletage
-(void)deleteControlAction:(XHPreviewModel *)object
{
    [self.dataArray removeObject:object];
    [self reloadData];
}



@end
