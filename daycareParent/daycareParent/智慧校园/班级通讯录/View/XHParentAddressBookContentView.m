//
//  XHParentAddressBookContentView.m
//  daycareParent
//
//  Created by Git on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHParentAddressBookContentView.h"
#import "XHParentHeaderFooterView.h"
#import "XHAddressBookCell.h"




@interface XHParentAddressBookContentView () <UITableViewDelegate,UITableViewDataSource,XHParentHeaderFooterViewDeletage>



@end

@implementation XHParentAddressBookContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews:YES];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
    [self.tableView beginRefreshing];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
    }
}






#pragma mark 下拉刷新的方法
-(void)refreshHeaderAction
{
    [[XHUserInfo sharedUserInfo] getTeachersAddressBook:^(BOOL isOK, NSArray *array)
     {
         if (isOK)
         {
             [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
              {
                  obj = [obj objectItemKey:@"propValue"];
                   if ([[obj objectItemKey:@"id"] isEqualToString:[XHUserInfo sharedUserInfo].selfId])
                   {
                   [[XHUserInfo sharedUserInfo] setTeacherName:[obj objectItemKey:@"teacherName"]];
                   [[XHUserInfo sharedUserInfo] setUserPic:[obj objectItemKey:@"headPic"]];
                   }
                  
              }];
         }
         
         
     }];
    
    
    
    
    
    [[XHUserInfo sharedUserInfo] getParentsAddressBook:^(BOOL isOK, NSArray *array)
     {
         if (isOK)
         {
             NSMutableArray *sectionArray = [NSMutableArray array];
             [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
              {
                  NSString *gradeName = [obj objectItemKey:@"gradeName"]; //!< 年级
                  NSString *clazzName = [obj objectItemKey:@"clazzName"]; //!< 班级
                  
                  XHAddressBookSection *section = [[XHAddressBookSection alloc]init];
                  [section setTage:idx];
                  [section setSectionTitle:[NSString stringWithFormat:@"%@%@",gradeName,clazzName]];
                  NSArray *studnetArray = [obj objectItemKey:@"studnetList"];
                  [NSArray enumerateObjectsWithArray:studnetArray usingBlock:^(NSDictionary *itemObj, NSUInteger idx, BOOL *stop)
                  {
                      NSDictionary *object = [itemObj objectItemKey:@"propValue"];
                      NSString *studentName = [object objectItemKey:@"studentName"];
                      NSArray *guardianList = [object objectItemKey:@"guardianList"];
                      [NSArray enumerateObjectsWithArray:guardianList usingBlock:^(NSDictionary *guardianobj, NSUInteger idx, BOOL *stop)
                      {
                          XHAddressBookFrame *frame = [[XHAddressBookFrame alloc]init];
                          XHAddressBookModel *model = [[XHAddressBookModel alloc]init];
                          NSDictionary *propValue = [guardianobj objectItemKey:@"propValue"];
                          NSString *guardianName = [propValue objectItemKey:@"guardianName"];
                          
                          [model setTeacherName:[NSString stringWithFormat:@"%@(%@家长)",guardianName,studentName]];
                          [model setTage:idx];
                          [model setParentsItemObject:propValue];
                          [model setModelType:XHAddressBookParentType];
                          [model setSelectType:XHAddressBookModelNormalType];
                          [frame setModel:model];
                          [section.itemArray addObject:frame];
                          
                      }];
                      
                      
                   
                      
                  }];
                  [section setArray:section.itemArray];
                  [section setMarkType:XHAddressBookSectionNormalType];
                  [sectionArray addObject:section];
               
              }];
             [self.dataArray setArray:sectionArray];
         }
         [self.tableView refreshReloadData];
     }];
}



#pragma mark - Deletage Method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    XHAddressBookSection *bookSection = [self.dataArray objectAtIndex:section];
    switch (bookSection.markType)
    {
        case XHAddressBookSectionNormalType:
        {
            return 0;
        }
            break;
        case XHAddressBookSectionSelectType:
        {
            return [bookSection.itemArray count];
        }
            break;
    }
}


- (XHAddressBookCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHAddressBookCell alloc]init];
    }
    
    XHAddressBookSection *bookSection = [self.dataArray objectAtIndex:indexPath.section];
    [cell setItemFrame:[bookSection.itemArray objectAtIndex:indexPath.row]];
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHAddressBookSection *bookSection = [self.dataArray objectAtIndex:indexPath.section];
    return [[bookSection.itemArray objectAtIndex:indexPath.row] cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}


- (UIView *)tableView:(BaseTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XHParentHeaderFooterView *sectionBar = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderSectionIdentifier];
    
    if (sectionBar == nil)
    {
        
        sectionBar = [[XHParentHeaderFooterView alloc]initWithDeletage:self];
        [sectionBar resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60.0)];
        
    }
    [sectionBar setItemFrame:[self.dataArray objectAtIndex:section]];
    return sectionBar;

}


#pragma mark UITableViewDelegate
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(XHAddressBookSection *bookKey, NSUInteger sectionidx, BOOL * _Nonnull stop)
     {
         if (sectionidx == indexPath.section)
         {
#pragma mark 如果选中当前分组就开始遍历查询打开的是该分组下那个元素，把选中的元素打开，未选中的关闭
             [bookKey.itemArray enumerateObjectsUsingBlock:^(XHAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
              {
                  if (idx == indexPath.row)
                  {
                      switch (obj.model.selectType)
                      {
#pragma mark 如果当前行为选中状态的话就设置为未选中状态
                          case XHAddressBookSelectType:
                          {
                              [obj.model setSelectType:XHAddressBookModelNormalType];
                              [obj setModel:obj.model];
                          }
                              break;
#pragma mark 如果是未选中状态的话，就设置为选中状态
                          case XHAddressBookModelNormalType:
                          {
                              [obj.model setSelectType:XHAddressBookSelectType];
                              [obj setModel:obj.model];
                          }
                              break;
                      }
                  }
                  else
                  {
#pragma mark 未选中的元素关闭
                      [obj.model setSelectType:XHAddressBookModelNormalType];
                      [obj setModel:obj.model];
                  }
              }];
         }
         else
         {
#pragma mark 如果为选中当前分组就把该分组下所有的元素设置为未选中状态（如果之前打开过该分组的某项，在点击另一分组的时候就关闭该分组中打开的元素）
             [bookKey.itemArray enumerateObjectsUsingBlock:^(XHAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
              {
                  [obj.model setSelectType:XHAddressBookModelNormalType];
                  [obj setModel:obj.model];
              }];
         }
     }];
    [tableView refreshReloadData];
}


#pragma mark XHParentHeaderFooterViewDeletage （点击每个分组触发的方法）
-(void)sectionBarAction:(XHParentAddressBookSectionBar *)sender
{
    switch (sender.section.markType)
    {
        case XHAddressBookSectionNormalType:
        {
            [sender.section setMarkType:XHAddressBookSectionSelectType];
        }
            break;
        case XHAddressBookSectionSelectType:
        {
            [sender.section setMarkType:XHAddressBookSectionNormalType];
        }
            break;
    }
    
    [self.tableView reloadSectionsWithIndex:sender.section.tage withRowAnimation:UITableViewRowAnimationAutomatic];
}






@end
