//
//  XHAchievementContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAchievementContentView.h"

@interface XHAchievementContentView () <UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) XHAchievementCellContentView *headerView; //!< 头部视图


@end

@implementation XHAchievementContentView




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
        [self.tableView beginRefreshing];
        
    }
    return self;
}
-(void)refreshHead
{
    [self refreshModel:self.classListModel withIndex:0];
}

-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

-(void)setItemArray:(NSMutableArray *)array
{
    self.dataArray=array;
}
-(void)getModel:(XHClassListModel *)model withIndex:(NSInteger)index
{
    self.classListModel=model;
    
    [self refreshModel:self.classListModel withIndex:index];
}
-(void)refreshModel:(XHClassListModel *)model withIndex:(NSInteger)index
{
    if (model)
    {
        if (index%2==0)
        {
            [self.dataArray removeAllObjects];
            NSArray *titleArr=@[@"科目",@"语文",@"数学",@"英语",@"历史",@"政治",@"地理",@"思修"];
            for (int i=0; i<titleArr.count; i++) {
                XHAchievementFrame *frame = [[XHAchievementFrame alloc]init];
                XHAchievementModel *model = [[XHAchievementModel alloc]init];
                [model setSubject:titleArr[i]];
                if (i == 0)
                {
                    [model setBatch:@"开学成绩"];
                    [model setScore:@"期中成绩"];
                    [model setEnd:@"期末成绩"];
                    [model setContentType:XHAchievementTitleType];
                }
                else
                {
                    if (i==2)
                    {
                     [model setBatch:@"92"];
                      [model setScore:@"90"];
                      [model setEnd:@"93"];
                    }
                   else if (i==3)
                    {
                        [model setBatch:@"90"];
                        [model setScore:@"93"];
                        [model setEnd:@"96"];
                    }
                  else  if (i==5)
                    {
                        [model setBatch:@"97"];
                        [model setScore:@"93"];
                        [model setEnd:@"90"];
                    }
                   else if (i==7)
                    {
                        [model setBatch:@"90"];
                        [model setScore:@"98"];
                        [model setEnd:@"99"];
                    }
                    else
                    {
                        [model setBatch:@"91"];
                         [model setScore:@"95"];
                        [model setEnd:@"94"];
                    }
                    [model setContentType:XHAchievementContentType];
                }
                
                [frame setModel:model];
                [self.dataArray addObject:frame];}
        }
        else if (index%3==0)
        {
            [self.dataArray removeAllObjects];
            NSArray *titleArr=@[@"科目",@"语文",@"数学",@"英语",@"历史",@"政治",@"地理",@"思修"];
            for (int i=0; i<titleArr.count; i++) {
                XHAchievementFrame *frame = [[XHAchievementFrame alloc]init];
                XHAchievementModel *model = [[XHAchievementModel alloc]init];
                [model setSubject:titleArr[i]];
                if (i == 0)
                {
                    [model setBatch:@"开学成绩"];
                    [model setScore:@"期中成绩"];
                    [model setEnd:@"期末成绩"];
                    [model setContentType:XHAchievementTitleType];
                }
                else
                {
                    if (i==2) {
                        [model setBatch:@"99"];
                        [model setScore:@"92"];
                        [model setEnd:@"96"];
                    }
                   else if (i==3) {
                       [model setBatch:@"90"];
                        [model setScore:@"94"];
                       [model setEnd:@"92"];
                    }
                   else if (i==5) {
                       [model setBatch:@"96"];
                        [model setScore:@"97"];
                       [model setEnd:@"93"];
                    }
                   else if (i==7) {
                       [model setBatch:@"90"];
                        [model setScore:@"90"];
                       [model setEnd:@"96"];
                    }
                    else
                    {
                        [model setBatch:@"92"];
                        [model setScore:@"93"];
                        [model setEnd:@"99"];
                    }
                    [model setContentType:XHAchievementContentType];
                }
                
                [frame setModel:model];
                [self.dataArray addObject:frame];}
        }
        else
        {
            [self.dataArray removeAllObjects];
            NSArray *titleArr=@[@"科目",@"语文",@"数学",@"英语",@"历史",@"政治",@"地理",@"思修"];
            for (int i=0; i<titleArr.count; i++) {
                XHAchievementFrame *frame = [[XHAchievementFrame alloc]init];
                XHAchievementModel *model = [[XHAchievementModel alloc]init];
                [model setSubject:titleArr[i]];
                if (i == 0)
                {
                    [model setBatch:@"开学成绩"];
                    [model setScore:@"期中成绩"];
                    [model setEnd:@"期末成绩"];
                    [model setContentType:XHAchievementTitleType];
                }
                
                else
                {
                    if (i==2) {
                        [model setBatch:@"97"];
                        [model setScore:@"91"];
                        [model setEnd:@"93"];
                    }
                   else if (i==3) {
                       [model setBatch:@"98"];
                        [model setScore:@"94"];
                       [model setEnd:@"98"];
                    }
                   else if (i==5) {
                       [model setBatch:@"92"];
                        [model setScore:@"91"];
                       [model setEnd:@"96"];
                    }
                   else if (i==7) {
                       [model setBatch:@"99"];
                        [model setScore:@"90"];
                       [model setEnd:@"98"];
                    }
                    else
                    {
                        [model setBatch:@"97"];
                        [model setScore:@"95"];
                        [model setEnd:@"96"];
                    }
                    [model setContentType:XHAchievementContentType];
                }
                
                [frame setModel:model];
                [self.dataArray addObject:frame];}
        }
    }
    [self.tableView refreshReloadData];
}
/*
-(void)getAchievementWithModel:(XHChildListModel *)model
{
    if (model)
    {
        [self.netWorkConfig setObject:model.studentBaseId forKey:@"studentBaseId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus007" sucess:^(id object, BOOL verifyObject)
        {
            
            if (verifyObject)
            {
                [self.dataArray removeAllObjects];
                NSArray *itemArray = [object objectItemKey:@"object"];
                [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop)
                 {
                     NSDictionary *itemObject = [obj objectItemKey:@"propValue"];
                     XHAchievementFrame *frame = [[XHAchievementFrame alloc]init];
                     XHAchievementModel *model = [[XHAchievementModel alloc]init];
                     [model setItemObject:itemObject];
                     if (idx == 0)
                     {
                         [model setContentType:XHAchievementTitleType];
                     }
                     else
                     {
                         [model setContentType:XHAchievementContentType];
                     }
                     
                     [frame setModel:model];
                     [self.dataArray addObject:frame];
                 }];
               [self.tableView refreshReloadData];
            }
           
        } error:^(NSError *error)
        {
            [self.tableView refreshReloadData];
        }];
    }
    else
    {
        [self.tableView refreshReloadData];
    }
  
}
*/

#pragma mark - Deletage Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHXHAchievementCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHXHAchievementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHXHAchievementCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}



@end
