//
//  XHDynamicsContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsContentView.h"



@interface XHDynamicsContentView () <XHDynamicsCellContentViewDeletage,XHDynamicsCollectionViewDeletage>

@property (nonatomic,assign) NSInteger pageNumber; //!< 分页数




@end


@implementation XHDynamicsContentView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tableView];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView showRefresFooterWithTarget:self withSelector:@selector(refreshFooterAction)];
        [self.tableView beginRefreshing];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeaderAction) name:@"noticeName" object:nil];
    }
    return self;
}


-(void)dealloc
{
    [[XHVideoControl sharedVideo] dismiss];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}




#pragma mark - Action Method
-(void)refreshHeaderAction
{
    [self setPageNumber:1];
    [self getDynamicsWithGuardianId:[XHUserInfo sharedUserInfo].selfId withRefreshType:HeaderRefresh];
}

-(void)refreshFooterAction
{
    [self getDynamicsWithGuardianId:[XHUserInfo sharedUserInfo].selfId withRefreshType:FooterRefresh];
}



#pragma mark 获取班级动态的网络请求
-(void)getDynamicsWithGuardianId:(NSString*)guardianId withRefreshType:(BaseRefreshType)type
{
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
    [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",self.pageNumber] forKey:@"pageNumber"];
    [self.netWorkConfig setObject:@"10" forKey:@"pageSize"];
    [self.netWorkConfig postWithUrl:@"pmschool-teacher-api_/teacher/notice/listNotice" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             NSArray *itemObject = [object objectItemKey:@"object"];
             if (itemObject)
             {
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
                 [itemObject enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                  {
                      NSInteger inddexTage = [self.dataArray count];
                      XHDynamicsFrame *frame = [[XHDynamicsFrame alloc]init];
                      XHDynamicsModel *model = [[XHDynamicsModel alloc]init];
                      [model setTage:inddexTage];
                      [model setItemObject:obj];
                      [model.playModel setScrollView:self.tableView];
                      [frame setModel:model];
                      [self.dataArray addObject:frame];
                  }];
                 
                 
                 if ([itemObject count] >= 10)
                 {
                     [self.tableView refreshReloadData];
                     [self setPageNumber:(self.pageNumber+1)];
                 }
                 else
                 {
                     [self.tableView refreshReloadData];
                     [self.tableView noMoreData];
                 }
             }
             else
             {
                 [self.tableView refreshReloadData];
                 [self.tableView noMoreData];
             }
         }
     } error:^(NSError *error)
     {
         [self.tableView refreshReloadData];
     }];
}


#pragma mark - 回执已读状态
-(void)isreadWithNoticeActorId:(NSString *)noticeActorId withIndexPath:(NSIndexPath*)indexPath
{
    XHDynamicsFrame *frame = [self.dataArray objectAtIndex:indexPath.row];
    //先回执已读状态
    [self.netWorkConfig setObject:noticeActorId forKey:@"id"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
    [self.netWorkConfig postWithUrl:@"pmschool-teacher-api_/teacher/notice/update" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             [frame.model setUnreadType:@"1"];
         }
     } error:^(NSError *error){}];
}








#pragma mark - Deletage Method
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHDynamicsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHDynamicsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHDynamicsCell alloc]initWithDeletage:self];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row] withIndexPath:indexPath];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHDynamicsFrame *frame = self.dataArray[indexPath.row];
    [self isreadWithNoticeActorId:frame.model.noticeActorId withIndexPath:indexPath];
}

#pragma mark XHDynamicsCellContentViewDeletage Method
-(void)videoPlayerAction:(XHDynamicsFrame *)frame
{
    [[XHVideoControl sharedVideo] playerWithModel:frame.model.playModel];
    //先回执已读状态
    [frame.model setPlayType:XHDynamicsPlayerType];
    [self.netWorkConfig setObject:frame.model.noticeActorId forKey:@"noticeActorId"];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:frame.model.tage inSection:0];
    [self isreadWithNoticeActorId:frame.model.noticeActorId withIndexPath:indexPath];
}

#pragma mark XHDynamicsCollectionViewDeletage
-(void)didselectItemModel:(XHPreviewModel*)model
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:model.indexTage inSection:0];
    [self isreadWithNoticeActorId:model.noticeActorId withIndexPath:indexPath];
}
















@end
