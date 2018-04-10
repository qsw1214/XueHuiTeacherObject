//
//  XHIntelligentOfficeCell.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeCell.h"
#import "XHIntelligentOfficeHeaderControl.h"
#import "XHApprovalControl.h"
#import "XHIntelligentOfficeContentControl.h"



@interface XHIntelligentOfficeCell ()

@property (nonatomic,strong) XHIntelligentOfficeHeaderControl *headerControl;  //!< 头部视图
@property (nonatomic,strong) XHApprovalControl *approvalControl; //!< 审批
@property (nonatomic,strong) XHIntelligentOfficeContentControl *contentControl; //!< 内容视图






@end

@implementation XHIntelligentOfficeCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.headerControl];
        [self.contentView addSubview:self.approvalControl];
        [self.contentView addSubview:self.contentControl];
    }
    return self;
}

-(void)setItemFrame:(XHIntelligentOfficeFrame*)frame
{
    [self setItemHidden:YES];
    switch (frame.model.type)
    {
        case XHIntelligentOfficeHeaderType:
        {
            [self.headerControl setHidden:NO];
            [self.headerControl setItemFrame:frame];
            
        }
            break;
        case XHIntelligentOfficeApprovalType:
        {
            [self.approvalControl setHidden:NO];
            [self.approvalControl setItemFrame:frame];
        }
            break;
        case XHIntelligentOfficeContentType:
        {
            [self.contentControl setHidden:NO];
            [self.contentControl setItemFrame:frame];
        }
            break;
    }
}








#pragma mark - Getter /  Setter
-(XHIntelligentOfficeHeaderControl *)headerControl
{
    if (!_headerControl)
    {
        _headerControl = [[XHIntelligentOfficeHeaderControl alloc]init];
    }
    return _headerControl;
}

-(XHApprovalControl *)approvalControl
{
    if (!_approvalControl)
    {
        _approvalControl = [[XHApprovalControl alloc]init];
    }
    return _approvalControl;
}


-(XHIntelligentOfficeContentControl *)contentControl
{
    if (!_contentControl)
    {
        _contentControl = [[XHIntelligentOfficeContentControl alloc]init];
    }
    return _contentControl;
}



-(void)setItemHidden:(BOOL)hidden
{
    [self.headerControl setHidden:hidden];
    [self.approvalControl setHidden:hidden];
    [self.contentControl setHidden:hidden];
}



@end
