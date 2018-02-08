//
//  XHAddNoticeRecipientViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddNoticeRecipientViewController.h"
#import "XHAddNoticeRecipientGroupViewController.h"
#import "XHNoticeAllUniteContentView.h"
#import "XHNoticeUniteContentView.h"



@interface XHAddNoticeRecipientViewController () <XHNoticeUniteDeletage,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic,strong) BaseButtonControl *confirmationControl;
@property (nonatomic,strong) XHNoticeUniteContentView *contentView;
@property (nonatomic,strong) XHNoticeAllUniteContentView *allSelectControl;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong) NSMutableArray *teachersArray;  //!< 教师数据源数组
@property (nonatomic,strong) NSMutableArray *parentsArray;   //!< 家长数据源数组
@property (nonatomic,assign) NSInteger unify;   //!< 统一处理数据源



@end


@implementation XHAddNoticeRecipientViewController


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   [self.tableView refreshReloadData];
    //[self.tableView beginRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self setUnify:0];
        [self setSelectIndex:0];
        
        [self.view addSubview:self.tableView];
        [self.tableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.navigationView.height-50.0))];
        [self.allSelectControl resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setTableHeaderView:self.allSelectControl];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView beginRefreshing];
        
        
        [self.confirmationControl resetFrame:CGRectMake(0, self.tableView.bottom, self.tableView.width, 50.0)];
        [self.confirmationControl setTitleEdgeFrame:CGRectMake(0, 0, self.confirmationControl.width, self.confirmationControl.height) withNumberType:0 withAllType:NO];
        [self.view addSubview:self.confirmationControl];
    }
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
                  obj=[obj objectItemKey:@"propValue"];
                  XHNoticeRecipientGroupFrame *frame = [[XHNoticeRecipientGroupFrame alloc]init];
                  XHNoticeRecipientGroupModel *model = [[XHNoticeRecipientGroupModel alloc]init];
                  [model setTeacherObject:obj];
                  [model setModelType:XHNoticeRecipientGroupTeacherType];
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
                            
                            [groupModel setModelType:XHNoticeRecipientGroupStudentType];
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


#pragma mark 确定按钮触发的事件
-(void)confirmationControlAction:(BaseButtonControl*)sender
{
    
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
    XHAddNoticeRecipientGroupViewController *grou = [[XHAddNoticeRecipientGroupViewController alloc]init];
    grou.successBlok = ^(BOOL success)
                         {
                             if (YES)
                             {
                                 [self.tableView refreshReloadData];
                             }
                         };
    [grou setItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:grou animated:YES];
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
-(BaseTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[BaseTableView alloc]init];
        
    }
    return _tableView;
}
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


-(BaseButtonControl *)confirmationControl
{
    if (!_confirmationControl)
    {
        _confirmationControl = [[BaseButtonControl alloc]init];
        [_confirmationControl setBackgroundColor:MainColor];
        [_confirmationControl setNumberLabel:1];
        [_confirmationControl setText:@"确认选择" withNumberType:0 withAllType:NO];
        [_confirmationControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_confirmationControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_confirmationControl addTarget:self action:@selector(confirmationControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmationControl;
}




@end
