//
//  XHPunchSignRecordCell.m
//  daycareParent
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignRecordCell.h"

@interface XHPunchSignRecordCell ()


@property (nonatomic,strong) UIImageView *dotImageView; //!< 圆点
@property (nonatomic,strong) UIView *timeLine; //!< 时间轴
@property (nonatomic,strong) UILabel *titleLabel; //!< 内容标签



@end

@implementation XHPunchSignRecordCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.timeLine];
        [self.contentView addSubview:self.dotImageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}


- (void)setRecordFrame:(XHPunchSignRecordFrame *)recordFrame
{
    _recordFrame = recordFrame;
    
    [self.dotImageView setFrame:CGRectMake(10.0, (recordFrame.itemFrame.size.height-15.0)/2.0, 15.0, 15.0)];
    [self.dotImageView setLayerCornerRadius:(self.dotImageView.height/2.0)];
    [self.timeLine setFrame:CGRectMake(10+15.0/2.0, 0, 0.5, recordFrame.itemFrame.size.height)];
    [self.titleLabel setFrame:CGRectMake(self.dotImageView.right+10.0, 0, recordFrame.itemFrame.size.width - (self.dotImageView.right+20.0), recordFrame.itemFrame.size.height)];
    
    
    [self.titleLabel setText:[NSString stringWithFormat:@"%@ %@",recordFrame.model.date,recordFrame.model.title]];
}



#pragma mark - Getter /  Setter
-(UIImageView *)dotImageView
{
    if (!_dotImageView)
    {
        _dotImageView = [[UIImageView alloc]init];
        [_dotImageView setBackgroundColor:[UIColor redColor]];
    }
    return _dotImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

-(UIView *)timeLine
{
    if (!_timeLine)
    {
        _timeLine = [[UIView alloc]init];
        [_timeLine setBackgroundColor:LineViewColor];
    }
    return _timeLine;
}



@end
