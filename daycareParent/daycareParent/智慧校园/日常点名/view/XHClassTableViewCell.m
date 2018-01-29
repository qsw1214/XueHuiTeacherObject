//
//  XHClassTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/29.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassTableViewCell.h"

@implementation XHClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _contentLab=[[XHBaseLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, self.contentView.bounds.size.height)];
        
        [self.contentView addSubview:_contentLab];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
