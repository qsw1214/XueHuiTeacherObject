//
//  XHAddNoticeRecipientGroupViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddNoticeRecipientGroupViewController.h"
#import "XHNoticeUniteItemContentView.h"


@interface XHAddNoticeRecipientGroupViewController ()

@property (nonatomic,strong) XHNoticeUniteItemContentView *contentView;
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
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.navigationView.height))];
    }
}


-(void)setItemObject:(XHNoticeRecipientFrame*)object;
{
    XHNoticeRecipientGroupFrame *groupFrame = [[XHNoticeRecipientGroupFrame alloc]init];
    XHNoticeRecipientGroupModel *groupModel = [[XHNoticeRecipientGroupModel alloc]init];
    [groupModel setTitle:@"全选"];
    [groupModel setSelect:0];
    [groupModel setTotal:[object.groupArray count]];
    [groupModel setModelType:XHNoticeRecipientGroupFullSelectionType];
    [groupFrame setModel:groupModel];
    [self.dataArray addObject:groupFrame];
    [self.dataArray addObjectsFromArray:object.groupArray];
    [self.contentView setItemArray:self.dataArray];
}



#pragma mark - Getter / Setter
-(XHNoticeUniteItemContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHNoticeUniteItemContentView alloc]init];
    }
    return _contentView;
}









@end
