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
   
    
    _detailLab.text=@"2018-01-02";
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
    switch (model.bizModelType) {
        case XHBizType:
        {
            _titleLab.text=[NSString stringWithFormat:@"%@%@",model.teacherName,@"的调课"] ;
        }
            break;
            
        default:
        {
            _titleLab.text=[NSString stringWithFormat:@"%@%@",model.teacherName,@"的代课"] ;
        }
            break;
    }
    _ContentLab.text=[NSString stringWithFormat:@"等待%@的审批",model.auditor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
