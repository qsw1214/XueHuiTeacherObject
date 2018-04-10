//
//  XHParentAddressBookToolBar.m
//  daycareParent
//
//  Created by Git on 2018/1/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHParentAddressBookToolBar.h"
#import "XHAddressBookLecturesControl.h"
#import "XHChatViewController.h"
#import "XHMessageUserInfo.h"
#import "AppDelegate.h"

@interface XHParentAddressBookToolBar ()

@property (nonatomic,strong) XHAddressBookToolBarItemControl *phoneControl; //!< 电话
@property (nonatomic,strong) XHAddressBookToolBarItemControl *messageControl; //!< 短信
@property (nonatomic,strong) XHAddressBookToolBarItemControl *imControl; //!< 发送即时通讯消息

@end

@implementation XHParentAddressBookToolBar


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.phoneControl];
        [self addSubview:self.messageControl];
        [self addSubview:self.imControl];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    
    [self.phoneControl resetFrame:CGRectMake(0, 0, (frame.size.width/3.0), frame.size.height)];
    [self.messageControl resetFrame:CGRectMake(self.phoneControl.right, self.phoneControl.top, self.phoneControl.width, self.phoneControl.height)];
    [self.imControl resetFrame:CGRectMake(self.messageControl.right, self.phoneControl.top, self.phoneControl.width, self.phoneControl.height)];
    
}



#pragma mark - Action Method
-(void)controlAction:(XHAddressBookToolBarItemControl*)sender
{
    switch (sender.tag)
    {
#pragma mark case 1 拨打电话
        case 1:
        {
            [[XHHelper sharedHelper] telephone:self.itemFrame.model.phone];
        }
            break;
#pragma mark case 2 发送短信
        case 2:
        {
            [[XHHelper sharedHelper] sendMessage:self.itemFrame.model.phone];
        }
            break;
#pragma mark case 3 发送消息
        case 3:
        {
            XHMessageUserInfo *messageInfo = [[XHMessageUserInfo alloc] init];
            messageInfo.name = [NSString stringWithFormat:@"%@",self.itemFrame.model.teacherName];
            messageInfo.headPic = [NSString stringWithFormat:@"%@",self.itemFrame.model.headerUrl];
            messageInfo.userId = [NSString stringWithFormat:@"%@",self.itemFrame.model.userID];
            [messageInfo saveOrUpdateByColumnName:@"userId" AndColumnValue:[NSString stringWithFormat:@"%@",self.itemFrame.model.userID]];
            
            [[XHChatManager shareManager] sendUserInfo];
            XHChatViewController *conversationVC = [[XHChatViewController alloc] initHiddenWhenPushHidden];
            [conversationVC setNavtionTitle:self.itemFrame.model.teacherName];
            conversationVC.targetID = [NSString stringWithFormat:@"%@", self.itemFrame.model.userID];
            [DCURLRouter pushViewController:conversationVC animated:YES];
        }
            break;
#pragma mark case 4 所授课程
        case 4:
        {
            XHAddressBookLecturesControl *lectures = [[XHAddressBookLecturesControl alloc]init];
            [lectures setItemFrame:self.itemFrame];
            [lectures show];
        }
            break;
    }
}



#pragma mark - Getter / Setter
-(XHAddressBookToolBarItemControl *)phoneControl
{
    if (_phoneControl == nil)
    {
        _phoneControl = [[XHAddressBookToolBarItemControl alloc]init];
        [_phoneControl setImageName:@"ico_call_teacher"];
        [_phoneControl setTitle:@"拨打电话"];
        [_phoneControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_phoneControl setTag:1];
    }
    return _phoneControl;
}


-(XHAddressBookToolBarItemControl *)messageControl
{
    if (_messageControl == nil)
    {
        _messageControl = [[XHAddressBookToolBarItemControl alloc]init];
        [_messageControl setImageName:@"ico_smessage_teacher"];
        [_messageControl setTitle:@"发送短信"];
        [_messageControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_messageControl setTag:2];
    }
    return _messageControl;
}

-(XHAddressBookToolBarItemControl *)imControl
{
    if (_imControl == nil)
    {
        _imControl = [[XHAddressBookToolBarItemControl alloc]init];
        [_imControl setImageName:@"ico_message_teacher"];
        [_imControl setTitle:@"发送消息"];
        [_imControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_imControl setTag:3];
    }
    return _imControl;
}








@end
