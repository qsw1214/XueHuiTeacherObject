//
//  XHNoticeRecipientContentView.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecipientContentView.h"


@implementation XHNoticeRecipientContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews:YES];
    }
    return self;
}



-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        
        
        for (int i = 0; i <  1; i++)
        {
            XHNoticeRecipientFrame *frame = [[XHNoticeRecipientFrame alloc]init];
            XHNoticeRecipientModel *model = [[XHNoticeRecipientModel alloc]init];
            [model setTitle:@"全选"];
            [model setModelType:XHNoticeRecipientFullSelectionType];
            [model setSelectType:XHNoticeRecipientSelectedType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        
        for (int i = 0; i <  3; i++)
        {
            XHNoticeRecipientFrame *frame = [[XHNoticeRecipientFrame alloc]init];
            XHNoticeRecipientModel *model = [[XHNoticeRecipientModel alloc]init];
            [model setTitle:@"老师"];
            [model setModelType:XHNoticeRecipientNormalType];
            [model setSelectType:XHNoticeRecipientSelectedType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        for (int i = 0; i <  3; i++)
        {
            XHNoticeRecipientFrame *frame = [[XHNoticeRecipientFrame alloc]init];
            XHNoticeRecipientModel *model = [[XHNoticeRecipientModel alloc]init];
            [model setTitle:@"二年级二班"];
            [model setTotal:23];
            [model setSelect:12];
            [model setModelType:XHNoticeRecipientNormalType];
            [model setSelectType:XHNoticeRecipientSelectedType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        for (int i = 0; i <  3; i++)
        {
            XHNoticeRecipientFrame *frame = [[XHNoticeRecipientFrame alloc]init];
            XHNoticeRecipientModel *model = [[XHNoticeRecipientModel alloc]init];
            [model setTitle:@"三年级二班"];
            [model setTotal:23];
            [model setSelect:12];
            [model setModelType:XHNoticeRecipientNormalType];
            [model setSelectType:XHNoticeRecipientSelectedType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        [self.tableView refreshReloadData];
    }
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];

}




#pragma mark - Deletage Method
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}




- (XHNoticeRecipientTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNoticeRecipientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHNoticeRecipientTableViewCell alloc]init];
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
    if ([self.deletage respondsToSelector:@selector(didSelectRowAtIndexObject:)])
    {
        [self.deletage didSelectRowAtIndexObject:[self.dataArray objectAtIndex:indexPath.row]];
    }
}













@end
