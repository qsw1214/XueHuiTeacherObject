//
//  XHLeaveRecordTableViewCell.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLeaveRecordTableViewCell.h"



@interface XHLeaveRecordTableViewCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签

@property (nonatomic,strong) UILabel *backLabel; //!< 审核状态标签

@property (nonatomic,strong) UIView *lineView; //!< 分割线



@end




@implementation XHLeaveRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}


-(void)layoutSubviews
{
   
}



-(void)setItemFrame:(XHLeaveRecordFrame*)frame
{
    [self.titleLabel setFrame:CGRectMake(10.0, 10.0, frame.contentSize.width-50, frame.contentSize.height)];
   [self.backLabel setFrame:CGRectMake(self.titleLabel.right, self.titleLabel.top, frame.contentSize.width-self.titleLabel.height, frame.contentSize.height)];
    
    [self.lineView setFrame:CGRectMake(0, frame.itemFrame.size.height-0.5, frame.itemFrame.size.width, 0.5)];
    [self.titleLabel setText:frame.model.title];
    [self.backLabel setText:@"已审核"];
}





#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (_titleLabel  == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:RGB(3, 3, 3)];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setFont:FontLevel3];
    }
    return _titleLabel;
}
-(UILabel *)backLabel
{
    if (_backLabel  == nil)
    {
        _backLabel = [[UILabel alloc]init];
        [_backLabel setTextColor:[UIColor lightGrayColor]];
        [_backLabel setNumberOfLines:0];
        [_backLabel setFont:FontLevel3];
    }
    return _backLabel;
}
-(UIView *)lineView
{
    if (_lineView == nil)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}






@end
