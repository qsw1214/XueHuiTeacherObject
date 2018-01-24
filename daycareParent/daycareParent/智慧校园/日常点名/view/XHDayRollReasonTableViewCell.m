//
//  XHDayRollReasonTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollReasonTableViewCell.h"

@implementation XHDayRollReasonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(20, 0, 35, 50)];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.backgroundColor=[UIColor orangeColor];
        _reasonLabel=[[XHBackLabel alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-70, 0)];
        _reasonLabel.numberOfLines=0;
        _reasonLabel.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:_reasonLabel];
        _imageV=[[UIImageView alloc] init];
        [_imageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"addman"]];
        _imageV.backgroundColor=[UIColor redColor];
        _imageV.layer.cornerRadius=5;
        [self.contentView addSubview:_imageV];
    }
    return self;
}
-(void)setItemObject:(XHDayRollCallModel *)model
{
    _reasonLabel.frame=CGRectMake(60, 0, SCREEN_WIDTH-70, [self getCellHeight:model]);
    _reasonLabel.text=model.reasonStr;
    if (![model.imagPic isEqualToString:@""]) {
        _imageV.frame=CGRectMake(20, _reasonLabel.bottom+10, 50, 50);
        [_imageV sd_setImageWithURL:[NSURL URLWithString:model.imagPic] placeholderImage:[UIImage imageNamed:@"addman"]];
    }
}
-(CGFloat )getCellHeight:(XHDayRollCallModel *)model
{
//    if ([model.imagPic isEqualToString:@""]) {
        if ([NSString contentSizeWithTitle:model.reasonStr withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height<50) {
            return 50;
        }
        else
        {
            return [NSString contentSizeWithTitle:model.reasonStr withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height;
        }
        
//    }
//    else
//    {
//        return [NSString contentSizeWithTitle:model.reasonStr withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height-20+50;
//    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
