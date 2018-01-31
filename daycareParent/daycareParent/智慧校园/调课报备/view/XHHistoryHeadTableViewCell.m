//
//  XHHistoryHeadTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/18.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHHistoryHeadTableViewCell.h"

@implementation XHHistoryHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headBtn=[[UIButton alloc] initWithFrame:CGRectMake(22, 5, 50, 50)];
        self.headBtn.layer.cornerRadius=25;
        self.headBtn.layer.masksToBounds=YES;
        [self.headBtn sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
        [self.contentView addSubview:self.headBtn];
        self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.headBtn.right+5, 0, SCREEN_WIDTH-self.headBtn.right-10, 60)];
//        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}
-(void)setItemObject:(XHDayRollCallModel *)model
{
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.headPic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    _titleLabel.text=[NSString stringWithFormat:@"%@的请假",model.studentName];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
