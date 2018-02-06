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


@interface XHNoticeUniteContentView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BaseButtonControl *confirmationControl;

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
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self addSubview:self.confirmationControl];
    }
}




-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-50.0)];
    [self.confirmationControl resetFrame:CGRectMake(0, self.tableView.bottom, self.tableView.width, 50.0)];
    [self.confirmationControl setTitleEdgeFrame:CGRectMake(0, 0, self.confirmationControl.width, self.confirmationControl.height) withNumberType:0 withAllType:NO];
    
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
                  [model setModelType:XHNoticeRecipientNormalType];     //!< 数据模型的类型
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
        //!< 添加首页
        XHNoticeRecipientFrame *fullSelectionFrame = [[XHNoticeRecipientFrame alloc]init];
        XHNoticeRecipientModel *fullSelectionModel = [[XHNoticeRecipientModel alloc]init];
        [fullSelectionModel setTitle:@"全选"];
        [fullSelectionModel setModelType:XHNoticeRecipientFullSelectionType];
        [fullSelectionModel setSelectType:XHNoticeRecipientNormalityType];
        [fullSelectionFrame setModel:fullSelectionModel];
        [self.dataArray addObject:fullSelectionFrame];



        //!< 添加教师组
        XHNoticeRecipientFrame *teacherFrame = [[XHNoticeRecipientFrame alloc]init];
        XHNoticeRecipientModel *teacherModel = [[XHNoticeRecipientModel alloc]init];
        [teacherModel setTitle:@"教师组"];
        [teacherModel setTotal:[self.teachersArray count]];
        [teacherModel setSelect:0];
        [teacherModel setModelType:XHNoticeRecipientNormalType];
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

