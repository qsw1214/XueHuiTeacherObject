//
//  XHNewHeardTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewHeardTableViewCell.h"

@implementation XHNewHeardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headBtn.layer.cornerRadius=25;
    self.headBtn.layer.masksToBounds=YES;
    [self.headBtn sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
