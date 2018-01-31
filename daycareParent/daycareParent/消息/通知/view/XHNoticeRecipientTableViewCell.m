//
//  XHNoticeRecipientTableViewCell.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecipientTableViewCell.h"
#import "BaseButtonControl.h"

@interface XHNoticeRecipientTableViewCell ()


@property (nonatomic,strong) BaseButtonControl *contentControl;



@end


@implementation XHNoticeRecipientTableViewCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.contentControl];
    }
    return self;
}


-(void)setItemFrame:(XHNoticeRecipientFrame*)frame
{
    
    
    //首先设置每个Item的Frame大小
    [self.contentControl resetFrame:CGRectMake(0, 0, frame.itemFrame.size.width, frame.itemFrame.size.height)];
    [self.contentControl setImageEdgeFrame:CGRectMake(10, ((self.contentControl.height-20.0)/2.0), 20, 20) withNumberType:0 withAllType:NO];
    [self.contentControl setImageEdgeFrame:CGRectMake((self.contentControl.width-30.0), ((self.contentControl.height-20.0)/2.0), 20, 20) withNumberType:1 withAllType:NO];
    [self.contentControl setImageHidden:YES withNumberType:1 withAllType:NO];
    [self.contentControl resetLineViewFrame:CGRectMake(40.0, (self.contentControl.height-0.5), (frame.itemFrame.size.width-40.0), 0.5) withNumberType:0 withAllType:NO];
    
    switch (frame.model.modelType)
    {
        case XHNoticeRecipientFullSelectionType:
        {
            
            [self.contentControl setTitleEdgeFrame:CGRectMake(40.0, 0, ((self.contentControl.width-50.0)/2.0), self.contentControl.height) withNumberType:0 withAllType:NO];
            [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width-(((self.contentControl.width-50.0)/2.0)+10.0)), 0, ((self.contentControl.width-50.0)/2.0), self.contentControl.height) withNumberType:1 withAllType:NO];
        }
            break;
        case XHNoticeRecipientNormalType:
        case XHNoticeRecipientStudentType:
        case XHNoticeRecipientTeacherType:
        {
            [self.contentControl setTitleEdgeFrame:CGRectMake(50.0, 0, ((self.contentControl.width-60.0)/2.0), self.contentControl.height) withNumberType:0 withAllType:NO];
            [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width-(((self.contentControl.width-60.0)/2.0)+10.0)), 0, ((self.contentControl.width-60.0)/2.0), self.contentControl.height) withNumberType:1 withAllType:NO];
        }
            break;
    }
    
    
    //!< 赋值
    switch (frame.model.selectType)
    {
        case XHNoticeRecipientNormalityType:
        {
            [self.contentControl setImage:@"ico_allnoselect" withNumberType:0 withAllType:NO];
        }
            break;
        case XHNoticeRecipientSelectedType:
        {
            [self.contentControl setImage:@"ico_allselect" withNumberType:0 withAllType:NO];
        }
            break;
    }
    
    
    switch (frame.model.modelType)
    {
        case XHNoticeRecipientFullSelectionType:
        {
            [self.contentControl setImageHidden:YES withNumberType:1 withAllType:NO];
            [self.contentControl setText:[NSString stringWithFormat:@"%zd/%zd",frame.model.select,frame.model.total] withNumberType:1 withAllType:NO];
        }
            break;
        case XHNoticeRecipientNormalType:
        {
            [self.contentControl setImageHidden:NO withNumberType:1 withAllType:NO];
            [self.contentControl setText:[NSString stringWithFormat:@"%zd/%zd",frame.model.select,frame.model.total] withNumberType:1 withAllType:NO];
        }
            break;
        case XHNoticeRecipientStudentType:
        {
            
        }
            break;
        case XHNoticeRecipientTeacherType:
        {
            
        }
            break;
    }
    
    
    
    
    
    
}


#pragma mark -
-(BaseButtonControl*)contentControl
{
    if (!_contentControl)
    {
        _contentControl = [[BaseButtonControl alloc]init];
        [_contentControl setNumberImageView:2];
        [_contentControl setNumberLabel:2];
        [_contentControl setNumberLineView:1];
        [_contentControl setImage:@"ico_allnoselect" withNumberType:0 withAllType:NO];
    }
    return _contentControl;
}



@end
