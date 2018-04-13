//
//  XHInfiniteRotationControl.m
//  daycareParent
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 XueHui. All rights reserved.
//




#import "XHInfiniteRotationControl.h"
#import "XHPageCollectionView.h"
#import "XHInfiniteRotationCollectionView.h"


#define PageSpace 8
#define PageItemWidth 8
#define MaxSections 100

@interface XHInfiniteRotationControl () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) XHPageCollectionView *pageView;
@property (nonatomic,strong) XHInfiniteRotationCollectionView *infiniteRotationView;
@property (nonatomic,strong) NSMutableArray *pageArray;
@property (nonatomic,strong) NSMutableArray *rotationArray;
@end

@implementation XHInfiniteRotationControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.infiniteRotationView];
        [self addSubview:self.pageView];
        
        
        [self setItemColor:NO];
    }
    return self;
}

#pragma mark - Public Method
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    switch (self.type)
    {
        case XHInfiniteRotationInsideType:
        {
            [self.infiniteRotationView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-30.0)];
            [self.pageView resetFrame:CGRectMake(0, frame.size.height-50.0, frame.size.width, 20.0)];
        }
            break;
        case XHInfiniteRotationBottomType:
        {
            [self.infiniteRotationView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-30.0)];
            [self.pageView resetFrame:CGRectMake(0, frame.size.height-25.0, frame.size.width, 20.0)];
        }
            break;
    }
    
    
   
    
  
}



-(void)setInfiniteRotationItemArray:(NSMutableArray *)array
{
    [self.rotationArray setArray:array];
    [self.infiniteRotationView reloadData];
    
     [self.infiniteRotationView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:MaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}




/**
 设置分页数组内容的

 @param array 设置分页数组数据
 */
-(void)setPageItemArray:(NSMutableArray *)array
{
    if ([array count]>1)
    {
        NSInteger pageCount = [array count];
        [self.pageArray setArray:array];
        [self.pageView setItemArray:self.pageArray];
        [self.pageView reloadData];
        
        [self.pageView resetFrame:CGRectMake((self.infiniteRotationView.width-((PageItemWidth*pageCount)+((pageCount-1)*PageSpace)))/2.0, self.pageView.y, ((PageItemWidth*pageCount)+((pageCount-1)*PageSpace)), 20.0)];
    }
    
}




#pragma mark - Delegate Method
#pragma mark UICollectionViewDataSource
#pragma mark- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.rotationArray count];
}




- (XHInfiniteRotationItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHInfiniteRotationItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setModel:[self.rotationArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark UICollectionViewDelegate
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHAlertModel *model = [self.rotationArray objectAtIndex:indexPath.row];
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


#pragma mark 设置页码
-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger count = [self.pageArray count];
    if (count)
    {
        NSInteger page = (NSInteger)(scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%count;
        NSLog(@"%zd",page);
        
        [NSArray enumerateObjectsWithArray:self.pageArray usingBlock:^(XHPageModel *obj, NSUInteger idx, BOOL *stop)
         {
             if (idx == page)
             {
                 [obj setType:XHPageModelSelectType];
             }
             else
             {
                 [obj setType:XHPageModelNormalType];
             }
         }];
        
        [self.pageView setItemArray:self.pageArray];
    }
    
    
}



#pragma mark - Getter /  Setter
-(XHPageCollectionView *)pageView
{
    if (!_pageView)
    {
        _pageView = [[XHPageCollectionView alloc]initWithType:UICollectionViewScrollDirectionHorizontal];
    }
    return _pageView;
}



-(XHInfiniteRotationCollectionView *)infiniteRotationView
{
    if (!_infiniteRotationView)
    {
        _infiniteRotationView = [[XHInfiniteRotationCollectionView alloc]initWithType:UICollectionViewScrollDirectionHorizontal];
        [_infiniteRotationView registerClass:[XHInfiniteRotationItemCell class] forCellWithReuseIdentifier:CellIdentifier];
        [_infiniteRotationView setDelegate:self];
        [_infiniteRotationView setDataSource:self];
        [_infiniteRotationView setPagingEnabled:YES];
    }
    return _infiniteRotationView;
}

-(NSMutableArray *)pageArray
{
    if (!_pageArray)
    {
        _pageArray = [NSMutableArray array];
    }
    return _pageArray;
}


-(NSMutableArray *)rotationArray
{
    if (!_rotationArray)
    {
        _rotationArray = [NSMutableArray array];
    }
    return _rotationArray;
}

-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self setBackgroundColor:[UIColor yellowColor]];
        [self.infiniteRotationView setBackgroundColor:[UIColor purpleColor]];
        [self.pageView setBackgroundColor:[UIColor orangeColor]];
    }
}
@end
