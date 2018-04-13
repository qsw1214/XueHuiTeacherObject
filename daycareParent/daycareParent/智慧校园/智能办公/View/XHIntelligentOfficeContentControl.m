//
//  XHIntelligentOfficeContentControl.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeContentControl.h"
#import "XHIntelligentOfficeFrame.h"


@interface XHIntelligentOfficeContentControl ()

@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *titleLabel; //!< 调课申请、请假申请
@property (nonatomic,strong) UILabel *markLabel; //!< 待审批、已审批标签
@property (nonatomic,strong) UILabel *targetTeacherLabel; //!< 内容标签
@property (nonatomic,strong) UILabel *startTimeLabel; //!< 开始时间标签
@property (nonatomic,strong) UILabel *endTimeLabel; //!< 结束时间标签
@property (nonatomic,strong) UILabel *teacherLabel; //!< 老师标签


@end

@implementation XHIntelligentOfficeContentControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:NO];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.dateLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.startTimeLabel];
        [self addSubview:self.endTimeLabel];
        [self addSubview:self.markLabel];
        [self addSubview:self.targetTeacherLabel];
        [self addSubview:self.teacherLabel];
    }
    return self;
}



-(void)setItemFrame:(XHIntelligentOfficeFrame*)frame
{
    [self setFrame:frame.itemFrame];
    
    [self setItemHidden:YES];
    
    [self.titleLabel setFrame:CGRectMake(10.0, 10.0, (frame.itemFrame.size.width-20.0)/2.0, 20.0)];
    [self.dateLabel setFrame:CGRectMake(self.titleLabel.right, self.titleLabel.top, self.titleLabel.width, self.titleLabel.height)];
    
    [self.titleLabel setHidden:NO];
    [self.dateLabel setHidden:NO];
    [self.markLabel setHidden:NO];
    
    switch (frame.model.modelType)
    {
        case XHIntelligentOfficeClassSwitchingType:
        {
            [self.titleLabel setText:@"调课申请"];
            [self.startTimeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+10.0, frame.itemFrame.size.width-20.0, 20.0)];
            [self.teacherLabel setFrame:CGRectMake(self.startTimeLabel.left, self.startTimeLabel.bottom, self.startTimeLabel.width, self.startTimeLabel.height)];
            
            [self.endTimeLabel setFrame:CGRectMake(self.teacherLabel.left, self.teacherLabel.bottom+10.0, self.teacherLabel.width, self.teacherLabel.height)];
            [self.targetTeacherLabel setFrame:CGRectMake(self.endTimeLabel.left,self.endTimeLabel.bottom, self.endTimeLabel.width, self.endTimeLabel.height)];
            
            //!< 审批状态
            [self.markLabel setFrame:CGRectMake(self.targetTeacherLabel.left, self.targetTeacherLabel.bottom+5.0, 50.0, 20.0)];
            
        
            [self.startTimeLabel setText:[NSString stringWithFormat:@"调课时间:%@",frame.model.startTime]];
            [self.teacherLabel setText:[NSString stringWithFormat:@"调课老师:%@",frame.model.teacher]];
            [self.endTimeLabel setText:[NSString stringWithFormat:@"对方时间:%@",frame.model.endTime]];
            [self.targetTeacherLabel setText:[NSString stringWithFormat:@"对方老师:%@",frame.model.targetTeacher]];
            
            
         
            [self.markLabel setText:frame.model.approveMark];
            
            
            [self.startTimeLabel setHidden:NO];
            [self.teacherLabel setHidden:NO];
            [self.endTimeLabel setHidden:NO];
            [self.targetTeacherLabel setHidden:NO];
        }
            break;
            
        case XHIntelligentOfficeTakeOverClassType:
        {
            [self.titleLabel setText:@"代课申请"];
            [self.startTimeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+10.0, frame.itemFrame.size.width-20.0, 20.0)];
            [self.teacherLabel setFrame:CGRectMake(self.startTimeLabel.left, self.startTimeLabel.bottom, self.startTimeLabel.width, self.startTimeLabel.height)];
            
            //!< 审批状态
            [self.markLabel setFrame:CGRectMake(self.teacherLabel.left, self.teacherLabel.bottom+5.0, 50.0, 20.0)];
            
            
            
            [self.startTimeLabel setText:[NSString stringWithFormat:@"代课时间:%@",frame.model.startTime]];
            [self.teacherLabel setText:[NSString stringWithFormat:@"代课老师:%@",frame.model.teacher]];
            [self.markLabel setText:frame.model.approveMark];
            
            [self.startTimeLabel setHidden:NO];
            [self.teacherLabel setHidden:NO];

        }
            break;
        case XHIntelligentOfficeAskforleaveType:
        {
            [self.titleLabel setText:@"请假申请"];
            
            [self.startTimeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+10.0, frame.itemFrame.size.width-20.0, 20.0)];
            [self.endTimeLabel setFrame:CGRectMake(self.startTimeLabel.left, self.startTimeLabel.bottom, self.startTimeLabel.width, self.startTimeLabel.height)];
            
            //!< 审批状态
            [self.markLabel setFrame:CGRectMake(self.endTimeLabel.left, self.endTimeLabel.bottom+5.0, 50.0, 20.0)];
            
            [self.startTimeLabel setText:[NSString stringWithFormat:@"开始时间:%@",frame.model.startTime]];
            [self.endTimeLabel setText:[NSString stringWithFormat:@"结束时间:%@",frame.model.endTime]];
            [self.markLabel setText:frame.model.approveMark];
            
            [self.startTimeLabel setHidden:NO];
            [self.endTimeLabel setHidden:NO];
           
        }
            break;
    }
    
    
    switch (frame.model.approveType)
    {
        case XHIntelligentOfficeUnknownApproveType:
        {
            [self.markLabel setText:@"未审批"];
            [self.markLabel setTextColor:[UIColor whiteColor]];
            [self.markLabel setBackgroundColor:RGB(255,165,69)];
        }
            break;
        case XHIntelligentOfficeApproveType:
        {
            [self.markLabel setText:@"已审批"];
            [self.markLabel setTextColor:[UIColor whiteColor]];
            [self.markLabel setBackgroundColor:MainColor];
        }
            break;
        case XHIntelligentOfficeNOApproveType:
        {
            [self.markLabel setText:@"未通过"];
            [self.markLabel setTextColor:[UIColor whiteColor]];
            [self.markLabel setBackgroundColor:RGB(197,197,197)];
        }
            break;
    }
    
}



#pragma mark - Getter /  Setter
-(UILabel *)dateLabel
{
    if (!_dateLabel)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextColor:RGB(51,51,51)];
        [_dateLabel setFont:[UIFont systemFontOfSize:13.0]];
    }
    return _dateLabel;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
        [_titleLabel setTextColor:RGB(51,51,51)];
        [_titleLabel setText:@"调课申请"];
    }
    return _titleLabel;
}
-(UILabel *)markLabel
{
    if (!_markLabel)
    {
        _markLabel = [[UILabel alloc]init];
        [_markLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_markLabel setTextAlignment:NSTextAlignmentCenter];
        [_markLabel setLayerBorderWidth:0.5];
        [_markLabel setBorderColor:LineViewColor];
        [_markLabel setText:@"待审批"];
        [_markLabel setLayerCornerRadius:4.0];
        
    }
    return _markLabel;
}
-(UILabel *)targetTeacherLabel
{
    if (!_targetTeacherLabel)
    {
        _targetTeacherLabel = [[UILabel alloc]init];
        [_targetTeacherLabel setTextColor:RGB(51,51,51)];
        [_targetTeacherLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_targetTeacherLabel setNumberOfLines:0];
        [_targetTeacherLabel setText:@"轩逸的优势主要在于舒适性，这也是日产品牌一贯的特点。轩逸的座椅是三者里对身体承托承最好的，侧围及椅背都能与身体很好的接触，且能起到不弱的支撑作用，坐在上面比较放松。行驶起来后，轩逸的CVT变速箱的表现会异常平顺，再加上较软的悬架可以将颠簸尽量过滤，会给带来较强的舒适性。还有点值得一提，轩逸的两款高配车型可以选装日产的i-SAFETY智能防碰撞系统，主动安全性方面的表现是另外两款车型无法相比的。"];
    }
    return _targetTeacherLabel;
}

-(UILabel *)startTimeLabel
{
    if (!_startTimeLabel)
    {
        _startTimeLabel = [[UILabel alloc]init];
        [_startTimeLabel setTextColor:RGB(51,51,51)];
        [_startTimeLabel setFont:[UIFont systemFontOfSize:13.0]];
    }
    return _startTimeLabel;
}

-(UILabel *)endTimeLabel
{
    if (!_endTimeLabel)
    {
        _endTimeLabel = [[UILabel alloc]init];
        [_endTimeLabel setTextColor:RGB(51,51,51)];
        [_endTimeLabel setFont:[UIFont systemFontOfSize:13.0]];
    }
    return _endTimeLabel;
}


-(UILabel *)teacherLabel
{
    if (!_teacherLabel)
    {
        _teacherLabel = [[UILabel alloc]init];
        [_teacherLabel setTextColor:RGB(51,51,51)];
        [_teacherLabel setFont:[UIFont systemFontOfSize:13.0]];
    }
    return _teacherLabel;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.dateLabel setBackgroundColor:[UIColor redColor]];
        [self.markLabel setBackgroundColor:[UIColor purpleColor]];
        [self.startTimeLabel setBackgroundColor:[UIColor orangeColor]];
        [self.endTimeLabel setBackgroundColor:[UIColor orangeColor]];
        [self.teacherLabel setBackgroundColor:[UIColor orangeColor]];
        [self.targetTeacherLabel setBackgroundColor:[UIColor orangeColor]];
        [self.titleLabel setBackgroundColor:[UIColor greenColor]];
    }
}


-(void)setItemHidden:(BOOL)hidden
{
    [self.dateLabel setHidden:hidden];
    [self.titleLabel setHidden:hidden];
    [self.startTimeLabel setHidden:hidden];
    [self.endTimeLabel setHidden:hidden];
    [self.markLabel setHidden:hidden];
    [self.targetTeacherLabel setHidden:hidden];
    [self.teacherLabel setHidden:hidden];
}




@end
