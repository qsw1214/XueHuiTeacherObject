//
//  XHIntelligentOfficeContentControl.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeContentControl.h"


@interface XHIntelligentOfficeContentControl ()

@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *titleLabel; //!< 调课申请、请假申请
@property (nonatomic,strong) UILabel *markLabel; //!< 待审批、已审批标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 内容标签
@property (nonatomic,strong) UILabel *approverLabel; //!< 审批人标签
@property (nonatomic,strong) UIImageView *dotImageView; //!< 时间轴圆点
@property (nonatomic,strong) UIView *timeline; //!< 时间轴



@end

@implementation XHIntelligentOfficeContentControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}




#pragma mark - Getter /  Setter
-(UILabel *)dateLabel
{
    if (!_dateLabel)
    {
        _dateLabel = [[UILabel alloc]init];
    }
    return _dateLabel;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}
-(UILabel *)markLabel
{
    if (!_markLabel)
    {
        _markLabel = [[UILabel alloc]init];
    }
    return _markLabel;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc]init];
    }
    return _contentLabel;
}
-(UILabel *)approverLabel
{
    if (!_approverLabel)
    {
        _approverLabel = [[UILabel alloc]init];
    }
    return _approverLabel;
}


-(UIImageView *)dotImageView
{
    if (!_dotImageView)
    {
        _dotImageView = [[UIImageView alloc]init];
    }
    return _dotImageView;
}


-(UIView *)timeline
{
    if (!_timeline)
    {
        _timeline = [[UIView alloc]init];
    }
    return _timeline;
}




@end
