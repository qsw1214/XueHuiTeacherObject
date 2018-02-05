//
//  XHNoticeRecipientGroupTableViewCell.m
//  daycareParent
//
//  Created by Git on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecipientGroupTableViewCell.h"
#import "BaseButtonControl.h"

@interface XHNoticeRecipientGroupTableViewCell ()


@property (nonatomic,strong) BaseButtonControl *contentControl;



@end


@implementation XHNoticeRecipientGroupTableViewCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.contentControl];
    }
    return self;
}


-(void)setItemFrame:(XHNoticeRecipientGroupFrame*)frame
{
    
    
    //首先设置每个Item的Frame大小
    [self.contentControl resetFrame:CGRectMake(0, 0, frame.itemFrame.size.width, frame.itemFrame.size.height)];
    
    [self.contentControl setImageEdgeFrame:CGRectMake(10, ((self.contentControl.height-20.0)/2.0), 20, 20) withNumberType:0 withAllType:NO];
    [self.contentControl setImageEdgeFrame:CGRectMake((self.contentControl.width-30.0), ((self.contentControl.height-15)/2.0), 15, 15) withNumberType:1 withAllType:NO];
    [self.contentControl resetLineViewFrame:CGRectMake(40.0, (self.contentControl.height-0.5), (frame.itemFrame.size.width-40.0), 0.5) withNumberType:0 withAllType:NO];
    
    
    //根据不同的类型设置不同Frame
    switch (frame.model.modelType)
    {
#pragma mark case XHNoticeRecipientFullSelectionType
        case XHNoticeRecipientGroupFullSelectionType:
        {
            //!< 设置Frame
            [self.contentControl setTitleEdgeFrame:CGRectMake(40.0, 0, ((self.contentControl.width-50.0)/2.0), self.contentControl.height) withNumberType:0 withAllType:NO];
            
            [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width-(((self.contentControl.width-50.0)/2.0)+10.0)), 0, ((self.contentControl.width-50.0)/2.0), self.contentControl.height) withNumberType:1 withAllType:NO];
            
            //!< 设置字体颜色
            [self.contentControl setTextColor:RGB(3, 3, 3) withTpe:0 withAllType:NO];
            [self.contentControl setTextColor:RGB(3, 3, 3) withTpe:1 withAllType:NO];
            
            //!< 设置属性
            [self.contentControl setTitleHidden:NO withNumberType:0 withAllType:NO];
            [self.contentControl setTitleHidden:NO withNumberType:1 withAllType:NO];
            [self.contentControl setImageHidden:YES withNumberType:1 withAllType:NO];
            
            
            //!< 设置内容
            [self.contentControl setText:frame.model.title withNumberType:0 withAllType:NO];
            [self.contentControl setText:frame.model.title withNumberType:1 withAllType:NO];
        }
            break;
#pragma mark case XHNoticeRecipientGroupStudentType
        case XHNoticeRecipientGroupStudentType:
        {
            //!< 设置Frame
            [self.contentControl setTitleEdgeFrame:CGRectMake(50.0, 0, ((self.contentControl.width-60.0)/2.0), self.contentControl.height) withNumberType:0 withAllType:NO];
            [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width-(((self.contentControl.width-60.0)/2.0)+10.0)), 0, ((self.contentControl.width-60.0)/2.0), self.contentControl.height) withNumberType:1 withAllType:NO];
            
            //!< 设置属性
            [self.contentControl setTextColor:RGB(3, 3, 3) withTpe:0 withAllType:NO];
            [self.contentControl setTextColor:RGB(107, 107, 107) withTpe:1 withAllType:NO];
            
            [self.contentControl setTitleHidden:NO withNumberType:0 withAllType:NO];
            [self.contentControl setTitleHidden:NO withNumberType:1 withAllType:NO];
            
            //!< 设置标题
            [self.contentControl setText:frame.model.title withNumberType:0 withAllType:NO];
            [self.contentControl setText:[NSString stringWithFormat:@"%zd/%zd",frame.model.select,frame.model.total] withNumberType:1 withAllType:NO];
        }
            break;
#pragma mark case XHNoticeRecipientGroupTeacherType
        case XHNoticeRecipientGroupTeacherType:
        {
            [self.contentControl setTitleEdgeFrame:CGRectMake(50.0, 0, ((self.contentControl.width-60.0)/2.0), self.contentControl.height) withNumberType:0 withAllType:NO];
            [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width-(((self.contentControl.width-60.0)/2.0)+10.0)), 0, ((self.contentControl.width-60.0)/2.0), self.contentControl.height) withNumberType:1 withAllType:NO];
            
            
            [self.contentControl setTextColor:RGB(3, 3, 3) withTpe:0 withAllType:NO];
            [self.contentControl setTextColor:RGB(3, 3, 3) withTpe:1 withAllType:NO];
            [self.contentControl setTitleHidden:YES withNumberType:1 withAllType:NO];
            [self.contentControl setText:frame.model.title withNumberType:0 withAllType:NO];
        }
            break;
    }
    
    //!< 设置选择状态
    switch (frame.model.selectType)
    {
        case XHNoticeRecipientGroupNormalityType:
        {
            [self.contentControl setImage:@"ico_allnoselect" withNumberType:0 withAllType:NO];
        }
            break;
        case XHNoticeRecipientGroupSelectedType:
        {
            [self.contentControl setImage:@"ico_allselect" withNumberType:0 withAllType:NO];
        }
            break;
    }
    
}



#pragma mark - Getter / Setter
-(BaseButtonControl*)contentControl
{
    if (!_contentControl)
    {
        _contentControl = [[BaseButtonControl alloc]init];
        [_contentControl setNumberImageView:2];
        [_contentControl setNumberLabel:2];
        [_contentControl setNumberLineView:1];
        [_contentControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_contentControl setImage:@"ico_allnoselect" withNumberType:0 withAllType:NO];
        [_contentControl setImage:@"ico_arrow" withNumberType:1 withAllType:NO];
        [_contentControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_contentControl setFont:FontLevel2 withNumberType:1 withAllType:NO];
        [_contentControl setBackgroundColor:[UIColor whiteColor]];
        [_contentControl setItemColor:NO];
        [_contentControl setUserInteractionEnabled:NO];
    }
    return _contentControl;
}



@end

