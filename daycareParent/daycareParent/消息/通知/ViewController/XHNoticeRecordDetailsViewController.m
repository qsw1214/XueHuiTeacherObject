//
//  XHNoticeRecordDetailsViewController.m
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecordDetailsViewController.h"
#import "XHHomeWorkDetailView.h"

@interface XHNoticeRecordDetailsViewController ()

@property (nonatomic,strong) XHHomeWorkDetailView *contentView;


@end

@implementation XHNoticeRecordDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"通知详情"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}


-(void)setItemObjet:(XHHomeWorkFrame*)object
{
    XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
    XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
    [model setHeaderUrl:object.model.headerUrl];
    [model setSubject:object.model.subject];
    [model setUserName:object.model.userName];
    [model setReleaseDate:object.model.releaseDate];
    [model setGradeName:object.model.gradeName];
    [model setClazzName:object.model.clazzName];
    [model.imageUrlArray setArray:object.model.imageUrlArray];
    [model setWorkContent:object.model.workContent];
    [model setHomeWorkType:HomeWorkNoticeDetailsType];
    [model setContentType:object.model.contentType];
    [frame setModel:model];
    [self.dataArray addObject:frame];
    [self.contentView setItemArray:self.dataArray];
}





#pragma mark - Getter / Setter
-(XHHomeWorkDetailView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHHomeWorkDetailView alloc]initWithDeletage:self];
    }
    return _contentView;
}


@end
