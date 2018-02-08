//
//  XHNoticeUniteItemContentView.m
//  daycareParent
//
//  Created by Git on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeUniteItemContentView.h"
#import "XHNoticeAllUniteContentView.h"
#import "XHNoticeRecipientGroupFrame.h"
#import "XHAddressBookHelper.h"


@interface XHNoticeUniteItemContentView () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) XHNoticeAllUniteContentView *allSelectControl;
@property (nonatomic,assign) NSInteger selectIndex;


@end



@implementation XHNoticeUniteItemContentView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setSelectIndex:0];
        [self addSubViews:YES];
    
    }
    return self;
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.allSelectControl resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60.0)];
        [self.allSelectControl addTarget:self action:@selector(allSelectControl:) forControlEvents:UIControlEventTouchUpInside];
      
        [self addSubview:self.tableView];
        [self.tableView setTableHeaderView:self.allSelectControl];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
      
    }
}



-(void)setItemArray:(NSMutableArray *)array
{
    [self cyclicTraversal:array];
    [self setDataArray:array];
    [self.tableView refreshReloadData];
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
  
    
}


-(void)allSelectControl:(XHNoticeAllUniteContentView*)sender
{
    if (sender.isAction)
    {
        [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHNoticeRecipientGroupFrame *obj, NSUInteger idx, BOOL *stop)
        {
            
            [obj.model setSelectType:XHNoticeRecipientGroupNormalityType];
            
        }];
        
        [self cyclicTraversal:self.dataArray];
    }
    else
    {
        [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHNoticeRecipientGroupFrame *obj, NSUInteger idx, BOOL *stop)
         {
             
             [obj.model setSelectType:XHNoticeRecipientGroupSelectedType];
             
         }];
        
        [self cyclicTraversal:self.dataArray];
    }
}



#pragma mark 用于循环遍历已选中的人数
-(void)cyclicTraversal:(NSArray*)array
{
    [self setSelectIndex:0];
    [NSArray enumerateObjectsWithArray:array usingBlock:^(XHNoticeRecipientGroupFrame *obj, NSUInteger idx, BOOL *stop)
    {
        switch (obj.model.selectType)
        {
            case XHNoticeRecipientGroupNormalityType:
                break;
            case XHNoticeRecipientGroupSelectedType:
            {
                [self setSelectIndex:(self.selectIndex+1)];
            }
                break;
        }
    }];
    
    NSInteger count = [array count];
    if (self.selectIndex == count)
    {
        [self.allSelectControl setIsAction:YES];
    }
    else
    {
        [self.allSelectControl setIsAction:NO];
    }
    
    [self.allSelectControl setDescribe:[NSString stringWithFormat:@"%zd/%zd",self.selectIndex,count]];
    
    [self.tableView refreshReload];
}

#pragma mark - Deletage Method
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}




- (XHNoticeRecipientGroupTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNoticeRecipientGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHNoticeRecipientGroupTableViewCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHNoticeRecipientGroupFrame *obj, NSUInteger idx, BOOL *stop)
    {
        if (idx == indexPath.row)
        {
            switch (obj.model.selectType)
            {
                case XHNoticeRecipientGroupNormalityType:
                {
                    [obj.model setSelectType:XHNoticeRecipientGroupSelectedType];
                }
                    break;
                case XHNoticeRecipientGroupSelectedType:
                {
                    [obj.model setSelectType:XHNoticeRecipientGroupNormalityType];
                }
                    break;
            }
        }
    }];
    
    [self cyclicTraversal:self.dataArray];
}





#pragma mark - Getter / Setter
-(XHNoticeAllUniteContentView *)allSelectControl
{
    if (!_allSelectControl)
    {
        _allSelectControl = [[XHNoticeAllUniteContentView alloc]init];
        [_allSelectControl setBackgroundColor:[UIColor whiteColor]];
    }
    return _allSelectControl;
}



@end

