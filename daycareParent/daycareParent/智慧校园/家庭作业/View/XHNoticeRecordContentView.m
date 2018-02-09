//
//  XHNoticeRecordContentView.m
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecordContentView.h"

@interface XHNoticeRecordContentView () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,weak) id <XHNoticeRecordContentViewDeletage> deletage;

@property (nonatomic,assign) NSInteger pageNumber;



@end

@implementation XHNoticeRecordContentView

-(instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self setDeletage:deletage];
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView showRefresFooterWithTarget:self withSelector:@selector(refreshFooterAction)];
        [self.tableView beginRefreshing];
    }
    return self;
}





#pragma mark 头部刷新
-(void)refreshHeaderAction
{
    [self setPageNumber:1];
    [self getServerItemObjectWith:HeaderRefresh];
}


-(void)refreshFooterAction
{
    [self getServerItemObjectWith:FooterRefresh];
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
}

-(void)setItemArray:(NSMutableArray *)array
{
    [self.dataArray setArray:array];
    [self.tableView reloadData];
}


#pragma mark - Deletage Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}




- (XHHomeWorkTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHHomeWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHHomeWorkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    if ([self.deletage respondsToSelector:@selector(didSelectAtIndex:)])
    {
        [self.deletage didSelectAtIndex:[self.dataArray objectAtIndex:indexPath.row]];
    }
}



#pragma mark - NetWork Method
-(void)getServerItemObjectWith:(BaseRefreshType)type
{
  
    
    
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
    [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",self.pageNumber] forKey:@"pageNumber"];
    [self.netWorkConfig setObject:@"20" forKey:@"pageSize"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_notice005" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
            
             NSDictionary *itemObject = [object objectItemKey:@"object"];
             NSArray *array = [itemObject objectItemKey:@"pageResult"];
             
             
             
             switch (type)
             {
                 case HeaderRefresh:
                 {
                     [self.dataArray removeAllObjects];
                 }
                     break;
                 case FooterRefresh:
                     break;
             }
             
             
             [NSArray enumerateObjectsWithArray:array usingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
              {
                  XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
                  XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
                  [model setNoticeItemObject:obj];
                  [frame setModel:model];
                  [self.dataArray addObject:frame];
              }];
             
             
             [self.tableView refreshReloadData];
             
             if ([NSObject isArray:array])
             {
                 if ([array count] >= 20)
                 {
                     [self setPageNumber:(self.pageNumber+1)];
                 }
                 else
                 {
                     [self.tableView noMoreData];
                 }
             }
             else
             {
                 [self.tableView refreshReloadData];
             }
         }
         else
         {
             [self.tableView refreshReloadData];
         }
     } error:^(NSError *error)
     {
         [self.tableView refreshReloadData];
     }];
}











@end
