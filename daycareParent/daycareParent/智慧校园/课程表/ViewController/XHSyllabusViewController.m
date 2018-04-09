//
//  XHSyllabusViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusViewController.h"
#import "XHSyllabusContentView.h"
#import "XHChildListModel.h"
@interface XHSyllabusViewController ()<XHCustomViewDelegate,XHDropDownMenuControlDeletage>

@property (nonatomic,strong) XHSyllabusContentView *contentView; //!< 内容视图
@end

@implementation XHSyllabusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"课程表"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[XHUserInfo sharedUserInfo] getClassList:^(BOOL isOK, NSMutableArray *classListArry) {
        if (isOK)
        {
            [self setClassListArry:classListArry];
            XHClassListModel *model=classListArry.firstObject;
            [self.contentView getModel:model];
        }
        [self.contentView.tableView beginRefreshing];
    }];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}


#pragma mark - Getter / Setter
-(XHSyllabusContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHSyllabusContentView alloc]init];
    }
    return _contentView;
}

-(void)getClassListModel:(XHClassListModel *)classListModel withIndex:(NSInteger)index
{
     [self setRightItemTitle:classListModel.gradeAndClassName];
    
    [self.contentView getModel:classListModel];
    
}
#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    
    XHDropDownMenuControl *dorp = [[XHDropDownMenuControl alloc]initWithDeletage:self withType:DropRightType];
    
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=1; i<=10; i++)
    {
        XHDropDownMenuModel *model = [[XHDropDownMenuModel alloc]init];
        [model setTitle:[NSString stringWithFormat:@"一年级(%d)班",i]];
        [model setObjectID:@"ADSFOP1903LSW"];
        [tempArray addObject:model];
    }
    
    [dorp setDataArray:tempArray];
    [dorp show];
    
    
//    if (self.classListView.isExist==NO) {
//         self.classListView.delegate=self;
//        [self.view addSubview:self.classListView];
//        self.classListView.isExist=YES;
//    }
//    else
//    {
//        [self.classListView removeFromSuperview];
//        self.classListView.isExist=NO;
//    }
}


-(void)didSelectItemObjectAtIndexPath:(id)object
{
    
}


@end
