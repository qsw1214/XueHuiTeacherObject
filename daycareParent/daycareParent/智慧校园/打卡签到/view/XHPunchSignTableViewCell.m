//
//  XHPunchSignTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/29.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignTableViewCell.h"

@implementation XHPunchSignTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLabe=[[XHBaseLabel alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_WIDTH-20)/3.0, self.contentView.bounds.size.height)];
        [self.contentView addSubview:_timeLabe];
        
        _postionLabe=[[XHBaseLabel alloc] initWithFrame:CGRectMake(10+(SCREEN_WIDTH-20)/3.0, 0, (SCREEN_WIDTH-20)/3.0, self.contentView.bounds.size.height)];
        [self.contentView addSubview:_postionLabe];
        
        _titleLabe=[[XHBaseLabel alloc] initWithFrame:CGRectMake(10+2*(SCREEN_WIDTH-20)/3.0, 0, (SCREEN_WIDTH-20)/3.0, self.contentView.bounds.size.height)];
        [self.contentView addSubview:_titleLabe];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
