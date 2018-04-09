//
//  XHMessageCell.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Utils.h"

#import <RongIMLib/RongIMLib.h>
#define SMAS(x) [self.constraints addObject:x]

@interface TLMessageBubble : UIImageView

@end

@interface XHMessageCell : UITableViewCell
@property(nonatomic,strong)TLMessageBubble *bubbleImageView;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UIView *statusView;
@property(nonatomic,strong)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong)UIButton *retryBtn;
@property(nonatomic,strong)XHHeaderControl *headControl;
@property(nonatomic,strong)NSMutableArray *constraints;
@property(nonatomic,strong)UILabel *dateTimeLabel;

@property(nonatomic,strong)RCMessage *message;

@property(nonatomic, copy)void(^reSendAction)(RCMessage *message);
@property(nonatomic,strong)void(^clickAvatar)(RCMessageDirection msgDirection);

-(void)updateDirection:(RCMessageDirection)direction;
-(void)updateMessage:(RCMessage *)message showDate:(BOOL)showDate;
-(void)setMsgStatus:(RCSentStatus)msgStatus;
@end
