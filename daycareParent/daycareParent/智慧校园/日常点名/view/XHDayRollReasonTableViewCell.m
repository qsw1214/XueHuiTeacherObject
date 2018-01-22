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
        _titleLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
        [self.contentView addSubview:_titleLabel];
        _reasonLabel=[[XHBackLabel alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-70, 0)];
        [_imageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"addman"]];
        [self.contentView addSubview:_imageV];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
