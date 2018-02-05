//
//  XHAddNoticeRecipientViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddNoticeRecipientViewController.h"
#import "XHAddNoticeRecipientGroupViewController.h"
#import "XHNoticeUniteContentView.h"


@interface XHAddNoticeRecipientViewController () <XHNoticeUniteDeletage>

@property (nonatomic,strong) XHNoticeUniteContentView *contentView;



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
    switch (object.model.modelType)
    {
        case XHNoticeRecipientNormalType:
        {
            XHAddNoticeRecipientGroupViewController *recipient = [[XHAddNoticeRecipientGroupViewController alloc]init];
            [recipient setItemObject:object];
            [self.navigationController pushViewController:recipient animated:YES];
        }
        case XHNoticeRecipientFullSelectionType:
            break;
    }
    
}


#pragma mark - Getter / Setter
-(XHNoticeUniteContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHNoticeUniteContentView alloc]init];
        [_contentView setDeletage:self];
    }
    return _contentView;
}

@end
