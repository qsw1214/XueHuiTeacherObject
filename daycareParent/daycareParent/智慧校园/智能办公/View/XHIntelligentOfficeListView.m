//
//  XHIntelligentOfficeListView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeListView.h"
#import "XHAddressBoardViewController.h" //通讯录
#import "XHCookBookViewController.h" //食谱
#import "XHNewBulidViewController.h"//调代课

#define kTitle @[@"通讯录",@"调代课",@"今日课程",@"请假",@"食谱管理"]
#define kTitlePic @[@"ico_txl",@"ico_daike",@"ico_kec",@"ico_qingjia",@"ico_shipu"]

@implementation XHIntelligentOfficeListView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        for (int i=0 ; i<5; i++)
        {
            ParentControl *control=[[ParentControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5.0*i, 0, SCREEN_WIDTH/5.0, 85)];
            control.backgroundColor=[UIColor whiteColor];
            [control setNumberImageView:1];
            [control setNumberLabel:1];
            [control setImageViewCGRectMake:CGRectMake((SCREEN_WIDTH/5.0-30)/2.0, 15, 30, 30) withNumberIndex:0];
            [control setImageViewName:kTitlePic[i] withNumberIndex:0];
            [control setLabelCGRectMake:CGRectMake(0, 45, SCREEN_WIDTH/5.0, 25) withNumberIndex:0];
            [control setLabelFont:kFont(15) withNumberIndex:0];
            [control setLabelTextColor:RGB(51, 51, 51) withNumberIndex:0];
            [control setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
            [control setLabelText:kTitle[i] withNumberIndex:0];
            [control setTag:i+1];
            [control addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:control];
        }
    }
    return self;
}
-(void)controlMethod:(UIControl *)control
{
    switch (control.tag)
    {
#pragma mark case 1 通讯录
        case 1:
        {
            XHAddressBoardViewController *address=[[XHAddressBoardViewController alloc] initHiddenWhenPushHidden];
            [address setNavtionTitle:@"通讯录"];
            [DCURLRouter pushViewController:address animated:YES];
        }
            break;
#pragma mark case 2 调代课
        case 2:
        {
            XHNewBulidViewController *new=[[XHNewBulidViewController alloc] initHiddenWhenPushHidden];
            [DCURLRouter pushViewController:new animated:YES];
        }
            break;
#pragma mark case 3 今日课程
            case 3:
        {
            
        }
            break;
#pragma mark case 4 请假
            case 4:
        {
            
        }
            break;
#pragma mark case 5 食谱管理
        case 5:
        {
            XHCookBookViewController *cookBook = [[XHCookBookViewController alloc]initHiddenWhenPushHidden];
            [cookBook setNavtionTitle:@"食谱管理"];
            [DCURLRouter pushViewController:cookBook animated:YES];
        }
            break;
    }
}
@end
