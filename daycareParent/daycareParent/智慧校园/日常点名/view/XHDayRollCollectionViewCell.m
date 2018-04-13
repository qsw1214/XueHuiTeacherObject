//
//  XHDayRollCollectionViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollCollectionViewCell.h"

@implementation XHDayRollCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _headImgViewControl=[[XHHeaderControl alloc] init];
        
        _headImgViewControl.layer.masksToBounds=YES;
        _headImgViewControl.userInteractionEnabled=NO;
        [self.contentView addSubview:_headImgViewControl];
         _nameLabel=[[XHBaseLabel alloc] init];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font=FontLevel3;
        [self.contentView addSubview:_nameLabel];
        _selectImgView=[[UIImageView alloc] init];
        _selectImgView.image=[UIImage imageNamed:@"dot_no_one"];
        [self.contentView addSubview:_selectImgView];
        
    }
    return self;
}
-(void)setItemObject:(XHDayRollCallModel *)model
{
      [_headImgViewControl resetFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.width)];
    _headImgViewControl.layer.cornerRadius=self.contentView.bounds.size.width/2.0;
    _nameLabel.frame=CGRectMake(-5, _headImgViewControl.bottom, self.contentView.bounds.size.width+10, self.contentView.bounds.size.width/2.0);
    _selectImgView.frame=CGRectMake((self.contentView.bounds.size.width-10)/2.0, _nameLabel.bottom-5, 10, 10);
    
    
    _nameLabel.text=model.studentName;
    [_headImgViewControl setHeadrUrl:ALGetFileHeadThumbnail(model.headPic) withName:model.studentName withType:XHHeaderTeacherType];
    switch (model.modelType) {
        case DayRollCallNOSignType:
        {
            _selectImgView.hidden=NO;
            if (model.IfSelect) {
               _selectImgView.image=[UIImage imageNamed:@"dot_yes_one"];
            }
            else
            {
                _selectImgView.image=[UIImage imageNamed:@"dot_no_one"];
            }
        }
            break;
            case DayRollCallOtherType:
            case DayRollCallSignType:
            case DayRollCallBeforType:
        {
             _selectImgView.hidden=YES;
        }
        default:
            break;
    }
}
@end
