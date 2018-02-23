//
//  XHAddNoticeRecipientGroupViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddNoticeRecipientGroupViewController.h"
#import "XHNoticeUniteItemContentView.h"
#import "XHNoticeAllUniteContentView.h"



@interface XHAddNoticeRecipientGroupViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) XHNoticeRecipientFrame *transFrame;

@property (nonatomic,strong) BaseTableView *tableView;

@property (nonatomic,strong) XHNoticeAllUniteContentView *allSelectControl;
@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,strong) BaseButtonControl *confirmationControl;
@property (nonatomic,strong) NSMutableArray <XHNoticeRecipientGroupFrame*> *groupArray;

@end


@implementation XHAddNoticeRecipientGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.tableView];
        [self.allSelectControl resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60.0)];
        [self.allSelectControl addTarget:self action:@selector(allSelectControl:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView resetFrame:CGRectMake(0, self.allSelectControl.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.navigationView.height-50.0))];
        [self.tableView setTableHeaderView:self.allSelectControl];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView beginRefreshing];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        
        [self.confirmationControl resetFrame:CGRectMake(0, self.tableView.bottom, self.tableView.width, 50.0)];
        [self.confirmationControl setTitleEdgeFrame:CGRectMake(0, 0, self.confirmationControl.width, self.confirmationControl.height) withNumberType:0 withAllType:NO];
       
         [self.view addSubview:self.confirmationControl];
    }
}


-(void)setItemObject:(XHNoticeRecipientFrame*)object;
{
    switch (object.model.modelType)
    {
        case XHNoticeRecipientTeacherType:
        {
            [self setNavtionTitle:@"教师"];
        }
            break;
        case XHNoticeRecipientStudentType:
        {
            [self setNavtionTitle:object.model.title];
        }
            break;
    }
    [self setTransFrame:object];
    [self.dataArray setArray:object.groupArray];
    [self.tableView beginRefreshing];
}


#pragma mark 确认选择
-(void)confirmationControlAction:(BaseButtonControl*)sender
{
    [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHNoticeRecipientGroupFrame *obj, NSUInteger idx, BOOL *stop)
     {
         switch (obj.model.selectType)
         {
             case XHNoticeRecipientGroupNormalityType:
             {
                 [obj.model setSelectType:XHNoticeRecipientGroupNormalityType];
                 [obj.model setOptionSelectType:XHNoticeRecipientGroupOptionNormalityType];
             }
                 break;
             case XHNoticeRecipientGroupSelectedType:
             {
                 [obj.model setSelectType:XHNoticeRecipientGroupSelectedType];
                 [obj.model setOptionSelectType:XHNoticeRecipientGroupOptionSelectedType];
             }
                 break;
         }
     }];
    
    self.successBlok(YES);
    [self.navigationController popViewControllerAnimated:YES];
}





-(void)setItemArray:(NSMutableArray *)array
{
    [self cyclicTraversal:array];
    [self setDataArray:array];
    [self.tableView refreshReloadData];
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

-(void)refreshHeaderAction
{
      [self cyclicTraversal:self.dataArray];
}


#pragma mark 用于循环遍历已选中的人数
-(void)cyclicTraversal:(NSArray*)array
{
    [self setSelectIndex:0];
    [NSArray enumerateObjectsWithArray:array usingBlock:^(XHNoticeRecipientGroupFrame *obj, NSUInteger idx, BOOL *stop)
     {
         
         switch (obj.model.optionSelectType)
         {
             case XHNoticeRecipientGroupOptionNormalityType:
                 break;
             case XHNoticeRecipientGroupOptionSelectedType:
             {
                 [obj.model setSelectType:XHNoticeRecipientGroupSelectedType];
             }
                 break;
         }
         
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
    
    [self.tableView refreshReloadData];
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
-(BaseTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[BaseTableView alloc]init];
    }
    return _tableView;
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
