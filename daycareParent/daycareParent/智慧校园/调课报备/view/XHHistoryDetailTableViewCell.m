//
//  XHHistoryDetailTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/18.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHHistoryDetailTableViewCell.h"

@implementation XHHistoryDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headBtn.layer.cornerRadius=25;
    _headBtn.layer.masksToBounds=YES;
    [_headBtn sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    _nameLabel.font=FontLevel3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
