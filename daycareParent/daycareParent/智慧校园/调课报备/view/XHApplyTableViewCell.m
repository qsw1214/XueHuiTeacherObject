//
//  XHApplyTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/18.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHApplyTableViewCell.h"

@implementation XHApplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _selectImageV=[[UIImageView alloc] initWithFrame:CGRectMake(5, 30, 20, 20)];
        //_selectImageV.backgroundColor=[UIColor redColor];
        _selectImageV.layer.cornerRadius=10;
        _selectImageV.layer.masksToBounds=YES;
        [self.contentView addSubview:_selectImageV];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(_selectImageV.right+5,10, SCREEN_WIDTH-_selectImageV.right-10, 60)];
        label.layer.borderWidth=1;
        label.layer.borderColor=RGB(224, 224, 224).CGColor;
        label.layer.cornerRadius=5;
        [self.contentView addSubview:label];
        _headBtn=[[UIButton alloc] initWithFrame:CGRectMake(label.left+5, label.top+5, 50, 50)];
        _headBtn.layer.cornerRadius=25;
        _headBtn.layer.masksToBounds=YES;
        //_headBtn.backgroundColor=[UIColor redColor];
        [_headBtn sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
        [self.contentView addSubview:_headBtn];
        _nameLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(_headBtn.right+5, label.top+5, SCREEN_WIDTH-_headBtn.right-110, 25)];
       // _nameLabel.backgroundColor=[UIColor redColor];
           [self.contentView addSubview:_nameLabel];
        _dateLabel=[[XHBackLabel alloc] initWithFrame:CGRectMake(_nameLabel.right+5, label.top+5, 90, 25)];
        _dateLabel.font=FontLevel3;
       // _dateLabel.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:_dateLabel];
        _applyLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(_headBtn.right+5, _dateLabel.bottom, SCREEN_WIDTH-_headBtn.right-15, 25)];
        _applyLabel.font=FontLevel3;
        _applyLabel.textColor=RGB(44, 118, 44);
       // _applyLabel.backgroundColor=[UIColor blueColor];
        [self.contentView addSubview:_applyLabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
