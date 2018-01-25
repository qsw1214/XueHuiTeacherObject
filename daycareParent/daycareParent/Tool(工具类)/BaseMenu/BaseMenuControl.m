//
//  BaseMenuControl.m
//  Object
//
//  Created by XueHui on 2017/10/24.
//  Copyright © 2017年 Object. All rights reserved.
//

#import "BaseMenuControl.h"

@interface BaseMenuControl () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) UIView *markView; //!< 选中条
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) NSMutableArray *itemArrays;
@property (nonatomic,strong) UIColor *clicktColor;
@property (nonatomic,strong) UIColor *normalColor;

@end


@implementation BaseMenuControl

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        [self addSubview:self.lineView];
        [self registerClass:[BaseMenuCell class] forCellWithReuseIdentifier:CellIdentifier];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setLineHeight:0.5];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    
    
    switch (self.lineViewType)
    {
        case BaseMenuLineViewTopType:
        {
            [self.lineView setFrame:CGRectMake(0, 0.0, frame.size.width, self.lineHeight)];
        }
            break;
        case BaseMenuLineViewBottomType:
        {
            [self.lineView setFrame:CGRectMake(0, frame.size.height-self.lineHeight, frame.size.width, self.lineHeight)];
        }
            break;
    }
}




-(void)setLineViewType:(BaseMenuLineViewType)lineViewType
{
    _lineViewType = lineViewType;
    
    switch (lineViewType)
    {
        case BaseMenuLineViewTopType:
        {
            [self.lineView setFrame:CGRectMake(0, 0.0, self.frame.size.width, self.lineHeight)];
        }
            break;
        case BaseMenuLineViewBottomType:
        {
            [self.lineView setFrame:CGRectMake(0, self.frame.size.height-self.lineHeight, self.frame.size.width, self.lineHeight)];
        }
            break;
    }
}


/**
 设置数据源
 同时设置第一个为选中状态的值

 @param itemArray 数据源数组
 */
-(void)setItemArray:(nullable NSMutableArray *)itemArray
{
    [self.dataArray setArray:itemArray];
}
/**
 设置数据源
 同时设置默认为选中状态的值
 进度
 
 @param itemSelectArray 数据源数组
 */

-(void)setItemSelectArray:(nullable NSMutableArray *)itemSelectArray
{
    [self.dataArray setArray:itemSelectArray];
    [self didSelectAtIndexItem:0];
}

#pragma mark - Action Method
-(void)didSelectAtIndexItem:(NSInteger)index
{
    [self.dataArray enumerateObjectsUsingBlock:^(BaseMenuModel *obj, NSUInteger idx, BOOL *stop)
     {
         if (idx == index)
         {
            [obj setSelectType:BaseMenuSelectType];
         }
         else
         {
             [obj setSelectType:BaseMenuNormalType];
         }
     }];
    
    [self setSelectIndex:index];
    
    [self reloadData];
    
    if ([self.menuDeletage respondsToSelector:@selector(didSelectItem:)])
    {
        [self.menuDeletage didSelectItem:[self.dataArray objectAtIndex:index]];
    }
}


#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}


- (BaseMenuCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setModel:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(BaseMenuModel *obj, NSUInteger idx, BOOL *stop)
     {
         if (idx == indexPath.row)
         {
             [obj setSelectType:BaseMenuSelectType];
         }
         else
         {
             [obj setSelectType:BaseMenuNormalType];
         }
     }];
    [self reloadData];
    if ([self.menuDeletage respondsToSelector:@selector(didSelectItem:)])
    {
        [self.menuDeletage didSelectItem:[self.dataArray objectAtIndex:indexPath.row]];
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseMenuModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(model.itemSize.width,model.itemSize.height);
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


#pragma mark - Getter / Setter
-(UIView *)lineView
{
    if (_lineView == nil)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}

-(NSMutableArray*)itemArrays
{
    if (_itemArrays == nil)
    {
        _itemArrays = [NSMutableArray array];
    }
    return _itemArrays;
}

@end
