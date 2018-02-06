//
//  XHAchievementViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园->成绩



#import "XHAchievementViewController.h"
#import "XHAchievementContentView.h"
#import "XHChildListModel.h"
@interface XHAchievementViewController ()<XHCustomViewDelegate>

@property (nonatomic,strong) XHAchievementContentView *contentView; //!< 内容视图
@end

@implementation XHAchievementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"成绩"];
    [self.view addSubview:self.contentView];
    [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    [self.contentView setItemArray:self.dataArray];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [[XHUserInfo sharedUserInfo] getClassList:^(BOOL isOK, NSMutableArray *classListArry) {
        if (isOK)
        {
            [self setClassListArry:classListArry];
            XHClassListModel *model=classListArry.firstObject;
            [self.contentView getModel:model withIndex:0];
        }
        [self.contentView.tableView beginRefreshing];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter / Setter
-(XHAchievementContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHAchievementContentView alloc]init];
    }
    return _contentView;
}
-(void)getClassListModel:(XHClassListModel *)classListModel withIndex:(NSInteger)index
{
    
     [self setRightItemTitle:[classListModel clazz]];
    [self.contentView getModel:classListModel withIndex:index];
}
#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    if (self.classListView.isExist==NO) {
        self.classListView.delegate=self;
        [self.view addSubview:self.classListView];
        self.classListView.isExist=YES;
    }
    else
    {
        [self.classListView removeFromSuperview];
        self.classListView.isExist=NO;
    }
}

@end
