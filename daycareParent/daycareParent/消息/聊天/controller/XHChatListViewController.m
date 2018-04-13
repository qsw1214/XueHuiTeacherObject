//
//  XHChatListViewController.m
//  TestRongCloud
//
//  Created by 钧泰科技 on 2018/4/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XHChatListViewController.h"
#import "XHChatManager.h"
#import "XHChatViewController.h"
#import "XHRCTableViewCell.h"
#import "XHMessageUserInfo.h"
#import "XHTeacherAddressBookViewController.h"
#import "XHHomeWorkViewController.h"
#import "XHNoticeListViewController.h"
#import "XHRCModel.h"
#import "AppDelegate.h"
#define kTitleList @[@"给老师留言",@"家庭作业",@"通知公告"]
#define kTitlePic @[@"im_message",@"im_book",@"im_notice"]
@interface XHChatListViewController ()<UITableViewDelegate,UITableViewDataSource,XHChatManagerDelegate>
@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,assign)CGFloat tabbarBottom;
@property(nonatomic,strong)XHNetWorkConfig *net;
@end

@implementation XHChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[XHHelper sharedHelper] isIphoneX])
    {
        self.tabbarBottom=34;
    }
    else
    {
        self.tabbarBottom=0;
    }
    self.view.backgroundColor=RGB(239, 239, 239);
    [self setNavtionTitle:@"消息"];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.frame=CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.navigationView.bottom-(50.0+self.tabbarBottom)));
    [self.view addSubview:self.tableView];
    [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
    [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
    [self.tableView beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeMethod) name:@"noticeName" object:nil];
}
-(void)refreshHeaderAction
{
    [XHChatManager shareManager].delegate = self;
    [self.dataArry setArray:[[XHChatManager shareManager] getConversationList]];
    [self.tableView refreshReloadData];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.dataArry];
    
    return self.dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHRCTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItemObject:self.dataArry[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCConversation *model=self.dataArry[indexPath.row];
   
    XHChatViewController *chat=[[XHChatViewController alloc] initHiddenWhenPushHidden];
    
    chat.targetID=model.targetId;
    
    XHMessageUserInfo *info=[[XHChatManager shareManager] getUserInfoTargetId:model.targetId];
    [chat setNavtionTitle:info.name];
    
    [self.navigationController pushViewController:chat animated:YES];
    
    [[XHChatManager shareManager] clearMessagesUnread:model.targetId];
    [[XHChatManager shareManager] sendUserInfo];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if (self.tableView == tableView)
    {  
        if (editingStyle == UITableViewCellEditingStyleDelete)  
        {  
            RCConversation *model=self.dataArry[indexPath.row];
            
            [[XHChatManager shareManager] removeConversation:model.targetId];//1.先移除数组中的
            
            [self.dataArry removeObject:model];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            if (![self.dataArry count])
            {
                [self.tableView refreshReloadData];
            }
      
        }  
    }  
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        [_tableView registerClass:[XHRCTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [XHChatManager shareManager].delegate = self;
        [self.dataArry setArray:[[XHChatManager shareManager] getConversationList]];
        [self.tableView refreshReloadData];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    });

}
-(void)rcManagerReceiveMsg:(RCMessage *)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dataArry setArray:[[XHChatManager shareManager] getConversationList]];
        [self.tableView refreshReloadData];
        [[XHChatManager shareManager] refreshCashRCUserInfo:msg.content.senderUserInfo];
    });
   
}
- (void)notifyUpdateUnreadMessageCount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    });
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"noticeName" object:nil];
}
-(void)noticeMethod
{
    //进入刷新状态
    [self.tableView.header beginRefreshing];
}
-(XHNetWorkConfig *)net
{
    if (_net==nil) {
        _net=[[XHNetWorkConfig alloc] init];
    }
    return _net;
}

-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(22, 22) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    if (str.length==0)
    {
        return 0;
    }
    if (str.length==1)
    {
        return 15;
    }
    else
    {
        return textSize.width+8;
    }
    
}

-(NSMutableArray *)dataArry
{
    if (_dataArry==nil) {
        _dataArry=[[NSMutableArray alloc] init];
    }
    return _dataArry;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
