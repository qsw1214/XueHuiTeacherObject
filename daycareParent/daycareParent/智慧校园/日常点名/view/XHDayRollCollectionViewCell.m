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
        _headImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.width)];
        _headImgView.layer.cornerRadius=self.contentView.bounds.size.width/2.0;
        _headImgView.layer.masksToBounds=YES;
        [_headImgView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"studentphoto"]];
        [self.contentView addSubview:_headImgView];
         _nameLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(-5, _headImgView.bottom, self.contentView.bounds.size.width+10, self.contentView.bounds.size.width/2.0)];
        _nameLabel.text=@"完颜忍忍";
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font=FontLevel3;
        [self.contentView addSubview:_nameLabel];
        _selectImgView=[[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.bounds.size.width-10)/2.0, _nameLabel.bottom-5, 10, 10)];
        _selectImgView.image=[UIImage imageNamed:@"ico_no"];
        [self.contentView addSubview:_selectImgView];
        
    }
    return self;
}
-(void)setItemObject:(XHDayRollCallModel *)model
{
    switch (model.modelType) {
        case DayRollCallNOSignType:
        {
            _selectImgView.hidden=NO;
            if (model.IfSelect) {
               _selectImgView.image=[UIImage imageNamed:@"ico_yes"];
            }
            else
            {
                _selectImgView.image=[UIImage imageNamed:@"ico_no"];
            }
        }
            break;
            case DayRollCallOtherType:
            case DayRollCallSignType:
        {
             _selectImgView.hidden=YES;
        }
        default:
            break;
    }
}
@end
