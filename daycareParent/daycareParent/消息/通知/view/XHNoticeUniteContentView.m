//
//  XHNoticeUniteContentView.m
//  daycareParent
//
//  Created by Git on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeUniteContentView.h"
#import "XHNoticeRecipientGroupFrame.h"
#import "XHAddressBookHelper.h"
#import "XHNoticeAllUniteContentView.h"



@interface XHNoticeUniteContentView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) XHNoticeAllUniteContentView *allSelectControl;
@property (nonatomic,assign) NSInteger selectIndex;


@property (nonatomic,strong) NSMutableArray *teachersArray;  //!< 教师数据源数组
@property (nonatomic,strong) NSMutableArray *parentsArray;   //!< 家长数据源数组
@property (nonatomic,assign) NSInteger unify;   //!< 统一处理数据源

@end



@implementation XHNoticeUniteContentView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews:YES];
        [self setUnify:0];
        [self setSelectIndex:0];
    }
    return self;
}


-(void)dealloc
{
    
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.allSelectControl resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60.0)];
        [self.allSelectControl addTarget:self action:@selector(allSelectControl:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setTableHeaderView:self.allSelectControl];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView beginRefreshing];
    }
}


-(void)reload
{
    [self.tableView refreshReload];
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
}



#pragma mark - Action Method
-(void)refreshHeaderAction
{
    __weak typeof (self) weself = self;
    [[XHUserInfo sharedUserInfo] getTeachersAddressBook:^(BOOL isOK, NSArray *array)
     {
         if (isOK)
         {
             [weself.teachersArray removeAllObjects];
             [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
              {
                  XHNoticeRecipientGroupFrame *frame = [[XHNoticeRecipientGroupFrame alloc]init];
                  XHNoticeRecipientGroupModel *model = [[XHNoticeRecipientGroupModel alloc]init];
                  [model setTeacherObject:obj];
                  [model setSelectType:XHNoticeRecipientGroupNormalityType];
                  [frame setModel:model];
                  [weself.teachersArray addObject:frame];
              }];
             
             
             [weself unifyAction:1];
             
         }
     }];
    
    [[XHUserInfo sharedUserInfo] getParentsAddressBook:^(BOOL isOK, NSArray *array)
     {
         if (isOK)
         {
             [weself.parentsArray removeAllObjects];
             [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
              {
                  
                  NSString *gradeName = [obj objectItemKey:@"gradeName"]; //!< 年级
                  NSString *clazzName = [obj objectItemKey:@"clazzName"]; //!< 班级
                  XHNoticeRecipientFrame *frame = [[XHNoticeRecipientFrame alloc]init];
                  XHNoticeRecipientModel *model = [[XHNoticeRecipientModel alloc]init];
                  [model setTitle:[NSString stringWithFormat:@"%@%@",gradeName,clazzName]];
                  [model setSelectType:XHNoticeRecipientNormalityType]; //!< 正常的选中类型
                  [frame setModel:model];
                  
                  
                  NSArray *studnetArray = [obj objectItemKey:@"studnetList"];
                  [NSArray enumerateObjectsWithArray:studnetArray usingBlock:^(NSDictionary *itemObj, NSUInteger idx, BOOL *stop)
                   {
                       NSDictionary *object = [itemObj objectItemKey:@"propValue"];
                       NSArray *guardianListArray = [object objectItemKey:@"guardianList"]; //!< 获取家属列表
                       [guardianListArray enumerateObjectsUsingBlock:^(NSDictionary *parentsObj, NSUInteger idx, BOOL *stop)
                        {
                            /**
                             如果该孩子有家属，就显示在视图中，
                             没有的话，就不显示该孩子的任何信息
                             */
                            NSDictionary *parents = [parentsObj objectItemKey:@"propValue"];
                            XHNoticeRecipientGroupFrame *groupFrame = [[XHNoticeRecipientGroupFrame alloc]init];
                            XHNoticeRecipientGroupModel *groupModel = [[XHNoticeRecipientGroupModel alloc]init];
                            [groupModel setParentsObject:parents];
                            [groupModel setSelectType:XHNoticeRecipientGroupNormalityType];
                            [groupFrame setModel:groupModel];
                            [frame.groupArray addObject:groupFrame];
                        }];
                   }];
                  
                  
                  
                  [model setSelect:0];
                  [model setTotal:[frame.groupArray count]];
                  [weself.parentsArray addObject:frame];
                  
              }];
         }
         
         [weself unifyAction:1];
     }];
    
}



#pragma mark 统一处理数据
/**
 用于统一处理数据
 */
-(void)unifyAction:(NSInteger)unify
{

    [self.dataArray removeAllObjects];
    [self setUnify:(self.unify+unify)];

    if (self.unify == 2)
    {
        //!< 添加教师组
        XHNoticeRecipientFrame *teacherFrame = [[XHNoticeRecipientFrame alloc]init];
        XHNoticeRecipientModel *teacherModel = [[XHNoticeRecipientModel alloc]init];
        [teacherModel setTitle:@"教师组"];
        [teacherModel setTotal:[self.teachersArray count]];
        [teacherModel setSelect:0];
        [teacherModel setSelectType:XHNoticeRecipientNormalityType];
        [teacherFrame setModel:teacherModel];
        if ([self.teachersArray count])
        {

        }
        else
        {
            [teacherFrame.groupArray setArray:self.teachersArray];
        }

        [self.dataArray addObject:teacherFrame];



        //添加家长联系人
        [self.dataArray addObjectsFromArray:self.parentsArray];

        [self.tableView refreshReloadData];
        [self setUnify:0];
    }
}







-(void)allSelectControl:(XHNoticeAllUniteContentView*)sender
{
    if (sender.isAction)
    {
        [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHNoticeRecipientFrame *obj, NSUInteger idx, BOOL *stop)
         {
             [obj.model setSelectType:XHNoticeRecipientNormalityType];
         }];
    }
    else
    {
        [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHNoticeRecipientFrame *obj, NSUInteger idx, BOOL *stop)
         {
             [obj.model setSelectType:XHNoticeRecipientSelectedType];
         }];
    }
    [self cyclicTraversal:self.dataArray];
}

#pragma mark 用于循环遍历已选中的人数
-(void)cyclicTraversal:(NSArray*)array
{
    [self setSelectIndex:0];
    [NSArray enumerateObjectsWithArray:array usingBlock:^(XHNoticeRecipientFrame *obj, NSUInteger idx, BOOL *stop)
     {
         switch (obj.model.selectType)
         {
             case XHNoticeRecipientNormalityType:
                 break;
             case XHNoticeRecipientSelectedType:
             {
                 [self setSelectIndex:(self.selectIndex+1)];
             }
                 break;
         }
     }];
    NSInteger count = [array count];
    if (self.selectIndex == [array count])
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




- (XHNoticeRecipientTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNoticeRecipientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHNoticeRecipientTableViewCell alloc]initWithDeletage:self];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    [cell setIndexRow:indexPath.row];
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



#pragma mark XHNoticeRecipientTableViewCellDeletage
-(void)markControlAction:(BaseButtonControl*)object
{
    [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHNoticeRecipientFrame *obj, NSUInteger idx, BOOL *stop)
    {
        if (idx ==  object.tag)
        {
            switch (obj.model.selectType)
            {
                case XHNoticeRecipientSelectedType:
                {
                    [obj.model setSelectType:XHNoticeRecipientNormalityType];
                }
                    break;
                case XHNoticeRecipientNormalityType:
                {
                    [obj.model setSelectType:XHNoticeRecipientSelectedType];
                }
                    break;
            }
        }
        
    }];
    
    [self cyclicTraversal:self.dataArray];
}



#pragma mark - Getter / Setter
-(NSMutableArray *)teachersArray
{
    if (!_teachersArray)
    {
        _teachersArray = [NSMutableArray array];
    }
    return _teachersArray;
}


-(NSMutableArray *)parentsArray
{
    if (!_parentsArray)
    {
        _parentsArray = [NSMutableArray array];
    }
    return _parentsArray;
}



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

