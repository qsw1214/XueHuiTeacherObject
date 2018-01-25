//
//  XHAddressBoardViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddressBoardViewController.h"
#import "BaseMenuControl.h"


@interface XHAddressBoardViewController () <BaseMenuControlDeletage>

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
        [self.view addSubview:self.menuControl];
        [self.menuControl resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60.0)];
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        BaseMenuModel *teacherModel = [[BaseMenuModel alloc]init];
        [teacherModel setTitle:@"教师通讯录"];
        [teacherModel setTage:0];
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
        [parentModel setTage:0];
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
    
}


#pragma mark - Getter / Setter
-(BaseMenuControl *)menuControl
{
    if (!_menuControl)
    {
        _menuControl = [[BaseMenuControl alloc]init];
        [_menuControl setMenuDeletage:self];
    }
    return _menuControl;
}



@end
