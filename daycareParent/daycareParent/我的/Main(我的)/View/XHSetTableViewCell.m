//
//  XHSetTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSetTableViewCell.h"

@implementation XHSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _setImageView=[[UIImageView alloc] initWithFrame:CGRectMake(15,(60-26)/2.0, 26, 26)];
        [self.contentView addSubview:_setImageView];
        _setLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(48, 0, 100, 60)];
        [self.contentView addSubview:_setLabel];
        
        _setContentLabel=[[XHBackLabel alloc] initWithFrame:CGRectMake(150, 0, SCREEN_WIDTH-175, 60)];
        _setContentLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_setContentLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
