//
//  XHNotifceTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/10.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNotifceTableViewCell.h"
#import "XHApproveModel.h"
@implementation XHNotifceTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headImageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        _headImageView.layer.cornerRadius=30;
        _headImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:_headImageView];
        _smallLab=[[UILabel alloc] init];
        _smallLab.textAlignment=NSTextAlignmentCenter;
        _smallLab.font=[UIFont systemFontOfSize:14.0f];
        _smallLab.textColor=[UIColor whiteColor];
        _smallLab.layer.masksToBounds=YES;
        _smallLab.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:_smallLab];
        _titleLab=[[XHBaseLabel alloc] initWithFrame:CGRectMake(80, 0, 90, 30)];
         [self.contentView addSubview:_titleLab];
        _detailLab=[[XHBackLabel alloc] initWithFrame:CGRectMake(170, 0, SCREEN_WIDTH-180, 30)];
        _detailLab.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_detailLab];
        _ContentLab=[[XHBackLabel alloc] init];
        [self.contentView addSubview:_ContentLab];
        _myApplyLabel=[[XHBaseLabel alloc] init];
        [self.contentView addSubview:_myApplyLabel];
    }
    return self;
}
-(void)setItemObject:(XHApproveModel *)model
{
    _ContentLab.frame=CGRectMake(80, 35, SCREEN_WIDTH-180, 30);
    _ContentLab.textColor=[UIColor blackColor];
    _myApplyLabel.frame=CGRectMake(SCREEN_WIDTH-90, 40, 80, 20);
    _myApplyLabel.textAlignment=NSTextAlignmentCenter;
    _myApplyLabel.textColor=[UIColor whiteColor];
    _myApplyLabel.backgroundColor=[UIColor orangeColor];
    _myApplyLabel.layer.cornerRadius=10;
    _myApplyLabel.layer.masksToBounds=YES;
    _smallLab.frame=CGRectMake(50, 9, 8, 8);
    _smallLab.layer.cornerRadius=4;
    _titleLab.frame=CGRectMake(80, 0, SCREEN_WIDTH-180, 30);
    _titleLab.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(16.0)];
    _headImageView.image=[UIImage imageNamed:@"addman"];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.headPic)] placeholderImage:[UIImage imageNamed:@"addman"]];
    _detailLab.text=[NSDate dateStr:model.beginTime FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:YY_DEFAULT_TIME_FORM];
    switch (model.readType) {
        case XHUnReadType:
        {
            _smallLab.hidden=NO;
        }
            break;
            
        case XHReadType:
        {
            _smallLab.hidden=YES;
        }
            break;
    }
    switch (model.modelType) {
        case XHNoApproveType:
        {
            switch (model.isMeModelType) {
                case XHIsMEType:
                {
                    _myApplyLabel.text=@"我的申请";
                    _myApplyLabel.hidden=NO;
                }
                    break;
                    
                default:
                {
                    _myApplyLabel.hidden=YES;
                }
                    break;
            }
            _ContentLab.text=[NSString stringWithFormat:@"等待%@的审批",model.auditor];
        }
            break;
            
        case XHApproveType:
        {
             _myApplyLabel.hidden=YES;
            switch (model.isStatusType) {
                case XHIsStatusType:
                {
                    _ContentLab.text=[NSString stringWithFormat:@"审批完成（同意）"];
                }
                    break;
                    
                case XHNoStatusType:
                {
                    _ContentLab.text=[NSString stringWithFormat:@"审批完成（拒绝）"];
                }
                    break;
                case XHStatusType:
                {
                    _ContentLab.text=[NSString stringWithFormat:@"未审批"];
                }
                    break;
            }
        }
            break;
    }
    switch (model.historyModelType) {
        case XHCourseReportType:
        {
            switch (model.bizModelType) {
                case XHBizType:
                {
                    _titleLab.text=[NSString stringWithFormat:@"%@的调课",model.teacherName] ;
                }
                    break;
                    
                default:
                {
                    _titleLab.text=[NSString stringWithFormat:@"%@的代课",model.teacherName] ;
                }
                    break;
            }
        }
            break;
            
       case XHAskforLeaveType:
        {
            _titleLab.text=[NSString stringWithFormat:@"%@的请假",model.teacherName];
        }
            break;
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
