//
//  XHNewTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewTableViewCell.h"

@implementation XHNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(10, 0, 90, 50)];
        [self.contentView addSubview:_titleLabel];
        _selectLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-130, 50)];
        _selectLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_selectLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
