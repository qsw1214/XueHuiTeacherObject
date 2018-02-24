//
//  XHNewChageTypeTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/17.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewChageTypeTableViewCell.h"

@implementation XHNewChageTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(10, 0, 70, self.contentView.bounds.size.height)];
        [self.contentView addSubview:_titleLabel];
        _selectLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 0, 52, self.contentView.bounds.size.height)];
        [self.contentView addSubview:_selectLabel];
        #pragma mark-------------调课按钮--------------
        _melodyBtn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(_titleLabel.right, 0, (_selectLabel.left-_titleLabel.right)/2.0, self.contentView.bounds.size.height)];
        _melodyBtn.tag=100;
        [_melodyBtn setNumberImageView:1];
        [_melodyBtn setImageEdgeFrame:CGRectMake(_melodyBtn.width/2.0-18, (self.contentView.bounds.size.height-10)/2.0, 10, 10) withNumberType:0 withAllType:NO];
        [_melodyBtn setImage:@"ico_yes" withNumberType:0 withAllType:NO];
          [_melodyBtn setNumberLabel:1];
        [_melodyBtn setTitleEdgeFrame:CGRectMake(_melodyBtn.width/2.0, 0, _melodyBtn.width/2.0, self.contentView.bounds.size.height) withNumberType:0 withAllType:NO];
        [_melodyBtn setText:@"调课" withNumberType:0 withAllType:NO];
        [self.contentView addSubview:_melodyBtn];
        //_melodyBtn.backgroundColor=[UIColor redColor];
        #pragma mark-------------代课按钮--------------
        _otherBtn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(_melodyBtn.right, 0, _selectLabel.left-_melodyBtn.right, self.contentView.bounds.size.height)];
         _otherBtn.tag=101;
        [_otherBtn setNumberImageView:1];
        [_otherBtn setImageEdgeFrame:CGRectMake(_otherBtn.width/2.0-18, (self.contentView.bounds.size.height-10)/2.0, 10, 10) withNumberType:0 withAllType:NO];
        [_otherBtn setImage:@"ico_no" withNumberType:0 withAllType:NO];
        [_otherBtn setNumberLabel:1];
        [_otherBtn setTitleEdgeFrame:CGRectMake(_otherBtn.width/2.0, 0, _otherBtn.width/2.0, self.contentView.bounds.size.height) withNumberType:0 withAllType:NO];
        [_otherBtn setText:@"代课" withNumberType:0 withAllType:NO];
        [self.contentView addSubview:_otherBtn];
        //_otherBtn.backgroundColor=[UIColor orangeColor];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
