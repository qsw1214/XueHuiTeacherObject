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


@property (nonatomic,strong) BaseButtonControl *contentControl; //!< 内容
@property (nonatomic,strong) BaseButtonControl *markControl;  //!< 选择


@property (nonatomic,strong) id <XHNoticeRecipientTableViewCellDeletage> deletage;


@end


@implementation XHNoticeRecipientTableViewCell


-(instancetype)initWithDeletage:(<XHNoticeRecipientTableViewCellDeletage>)deletage
{
    self = [super init];
    if (self)
    {
        [self setDeletage:deletage];
        [self.contentView addSubview:self.contentControl];
        [self.contentView addSubview:self.markControl];
    }
    return self;
}


-(void)setItemFrame:(XHNoticeRecipientFrame*)frame
{
    //首先设置每个Item的Frame大小
    [self.contentControl resetFrame:CGRectMake(0, 0, frame.itemFrame.size.width, frame.itemFrame.size.height)];
    [self.markControl resetFrame:CGRectMake(0, 0, 40.0, frame.itemFrame.size.height)];
    
    [self.markControl setImageEdgeFrame:CGRectMake(10, ((self.contentControl.height-20.0)/2.0), 20, 20) withNumberType:0 withAllType:NO];
    [self.contentControl setImageEdgeFrame:CGRectMake((self.contentControl.width-30.0), ((self.contentControl.height-15)/2.0), 15, 15) withNumberType:0 withAllType:NO];
    [self.contentControl resetLineViewFrame:CGRectMake(40.0, (self.contentControl.height-0.5), (frame.itemFrame.size.width-40.0), 0.5) withNumberType:0 withAllType:NO];
    
    
    //根据不同的类型设置不同Frame
    switch (frame.model.modelType)
    {
#pragma mark case XHNoticeRecipientFullSelectionType
        case XHNoticeRecipientFullSelectionType:
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
            [self.contentControl setImageHidden:YES withNumberType:0 withAllType:NO];
          
            
            //!< 设置内容
            [self.contentControl setText:frame.model.title withNumberType:0 withAllType:NO];
            [self.contentControl setText:frame.model.title withNumberType:1 withAllType:NO];
        }
            break;
#pragma mark case XHNoticeRecipientNormalType
        case XHNoticeRecipientNormalType:
        {
            [self.contentControl setTitleEdgeFrame:CGRectMake(50.0, 0, ((self.contentControl.width-80.0)/2.0), self.contentControl.height) withNumberType:0 withAllType:NO];
            [self.contentControl setTitleEdgeFrame:CGRectMake((((self.contentControl.width-80.0)/2.0)+50.0), 0, ((self.contentControl.width-80.0)/2.0), self.contentControl.height) withNumberType:1 withAllType:NO];
            
            [self.contentControl setTextColor:RGB(3, 3, 3) withTpe:0 withAllType:NO];
            [self.contentControl setTextColor:RGB(3, 3, 3) withTpe:1 withAllType:NO];
            [self.contentControl setImageHidden:NO withNumberType:1 withAllType:NO];
            
            [self.contentControl setText:frame.model.title withNumberType:0 withAllType:NO];
            [self.contentControl setText:[NSString stringWithFormat:@"%zd/%zd",frame.model.select,frame.model.total] withNumberType:1 withAllType:NO];
            
            [self.contentControl setTitleHidden:NO withNumberType:0 withAllType:NO];
            [self.contentControl setTitleHidden:NO withNumberType:1 withAllType:NO];
        }
            break;
    }
    
    //!< 设置选择状态
    switch (frame.model.selectType)
    {
        case XHNoticeRecipientNormalityType:
        {
            [self.markControl setImage:@"ico_allnoselect" withNumberType:0 withAllType:NO];
        }
            break;
        case XHNoticeRecipientSelectedType:
        {
            [self.markControl setImage:@"ico_allselect" withNumberType:0 withAllType:NO];
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
        [_contentControl setNumberImageView:1];
        [_contentControl setNumberLabel:2];
        [_contentControl setNumberLineView:1];
        [_contentControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_contentControl setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
        [_contentControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_contentControl setFont:FontLevel2 withNumberType:1 withAllType:NO];
        [_contentControl setBackgroundColor:[UIColor whiteColor]];
        [_contentControl setItemColor:YES];
        [_contentControl setUserInteractionEnabled:NO];
    }
    return _contentControl;
}


-(BaseButtonControl *)markControl
{
    if (!_markControl)
    {
        _markControl = [[BaseButtonControl alloc]init];
        [_markControl setNumberImageView:1];
        [_markControl setImage:@"ico_allnoselect" withNumberType:0 withAllType:NO];
        [_markControl setItemColor:YES];
        [_markControl addTarget:self action:@selector(markControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _markControl;
}

-(void)markControlAction:(BaseButtonControl*)sender
{
//    if (self.deletage respondsToSelector:<#(SEL)#>) {
//        <#statements#>
//    }
    
}


@end
