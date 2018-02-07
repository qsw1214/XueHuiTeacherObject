//
//  XHAskforLeaveViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveViewController.h"
#import "XHLeaveRecordViewController.h"
#import "XHAskforLeaveContentView.h"



@interface XHAskforLeaveViewController ()

@property (nonatomic,strong) XHAskforLeaveContentView *contentView;


@end

@implementation XHAskforLeaveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"请假"];
   
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
        [self.contentView resetFrame:CGRectMake(0, self. navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}


#pragma mark - Getter / Setter
-(XHAskforLeaveContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHAskforLeaveContentView alloc]initWithObject:self];
    }
    return _contentView;
}


@end
