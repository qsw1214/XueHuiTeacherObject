//
//  XHAddNoticeRecipientViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddNoticeRecipientViewController.h"
#import "XHAddNoticeRecipientGroupViewController.h"
#import "XHNoticeRecipientContentView.h"


@interface XHAddNoticeRecipientViewController () <XHNoticeRecipientDeletage>

@property (nonatomic,strong) XHNoticeRecipientContentView *contentView;



@end


@implementation XHAddNoticeRecipientViewController

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



#pragma mark - Deletage Method
#pragma mark XHNoticeRecipientDeletage
-(void)didSelectRowAtIndexObject:(XHNoticeRecipientFrame*)object
{
    XHAddNoticeRecipientGroupViewController *recipient = [[XHAddNoticeRecipientGroupViewController alloc]init];
    [self.navigationController pushViewController:recipient animated:YES];
}


#pragma mark - Getter / Setter
-(XHNoticeRecipientContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHNoticeRecipientContentView alloc]init];
        [_contentView setDeletage:self];
    }
    return _contentView;
}

@end
