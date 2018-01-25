//
//  XHAddressBoardViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddressBoardViewController.h"
#import "BaseMenuControl.h"
#import "XHAddressBookContentView.h"   //!< 教师通讯录
#import "XHParentAddressBookContentView.h" //!< 家长通讯录



@interface XHAddressBoardViewController () <BaseMenuControlDeletage>

@property (nonatomic,strong) XHAddressBookContentView *teacherAddressBookContentView;
@property (nonatomic,strong) XHParentAddressBookContentView *parentAddressBookContentView;




@property (nonatomic,strong) BaseMenuControl *menuControl; //!< 操作菜单

@end

@implementation XHAddressBoardViewController

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
        
        
        //添加菜单控件
        [self.view addSubview:self.menuControl];
        [self.menuControl resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60.0)];
        
        //添加教师端通讯录
        [self.view addSubview:self.teacherAddressBookContentView];
        [self.teacherAddressBookContentView resetFrame:CGRectMake(0, self.menuControl.bottom, SCREEN_WIDTH,SCREEN_HEIGHT-self.menuControl.bottom)];
        [self.view addSubview:self.parentAddressBookContentView];
        [self.parentAddressBookContentView resetFrame:CGRectMake(0, self.teacherAddressBookContentView.top, self.teacherAddressBookContentView.width, self.teacherAddressBookContentView.height)];
        
        //为菜单控件赋值
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        BaseMenuModel *teacherModel = [[BaseMenuModel alloc]init];
        [teacherModel setTitle:@"教师通讯录"];
        [teacherModel setTage:1];
        [teacherModel setItemSize:CGSizeMake((SCREEN_WIDTH/2.0), 60.0)];
        [teacherModel  setLineSize:CGSizeMake(((SCREEN_WIDTH/2.0)-40.0), 0.5)];
        [teacherModel setFont:FontLevel4];
        [teacherModel setSelectColor:MainColor];
        [teacherModel setNormalColor:RGB(4, 4, 4)];
        [teacherModel setMarkColor:MainColor];
        [teacherModel setSelectType:BaseMenuSelectType];
        [dataArray addObject:teacherModel];
        BaseMenuModel *parentModel = [[BaseMenuModel alloc]init];
        [parentModel setTitle:@"家长通讯录"];
        [parentModel setTage:2];
        [parentModel setItemSize:CGSizeMake((SCREEN_WIDTH/2.0), 60.0)];
        [parentModel setLineSize:CGSizeMake(((SCREEN_WIDTH/2.0)-40.0), 0.5)];
        [parentModel setFont:FontLevel4];
        [parentModel setSelectColor:MainColor];
        [parentModel setNormalColor:RGB(4, 4, 4)];
        [parentModel setMarkColor:MainColor];
        [parentModel setSelectType:BaseMenuNormalType];
        [dataArray addObject:parentModel];
        [self.menuControl setItemSelectArray:dataArray];
    }
}



#pragma mark - Deletage Method
#pragma mark BaseMenuControlDeletage
-(void)didSelectItem:(BaseMenuModel*)object
{
    [self.teacherAddressBookContentView setHidden:YES];
    [self.parentAddressBookContentView setHidden:YES];
    switch (object.tage)
    {
#pragma mark case 1
        case 1:
        {
            [self.teacherAddressBookContentView setHidden:NO];
        }
            break;
        case 2:
        {
            [self.parentAddressBookContentView setHidden:NO];
        }
            break;
    }
}


#pragma mark - Getter / Setter
-(BaseMenuControl *)menuControl
{
    if (!_menuControl)
    {
        _menuControl = [[BaseMenuControl alloc]init];
        [_menuControl setLineViewType:BaseMenuLineViewBottomType];
        [_menuControl setMenuDeletage:self];
    }
    return _menuControl;
}


-(XHAddressBookContentView *)teacherAddressBookContentView
{
    if (!_teacherAddressBookContentView)
    {
        _teacherAddressBookContentView = [[XHAddressBookContentView alloc]init];
    }
    return _teacherAddressBookContentView;
}


-(XHParentAddressBookContentView *)parentAddressBookContentView
{
    if (!_parentAddressBookContentView)
    {
        _parentAddressBookContentView = [[XHParentAddressBookContentView alloc]init];
        [_parentAddressBookContentView setBackgroundColor:[UIColor blueColor]];
    }
    return _parentAddressBookContentView;
}




@end
