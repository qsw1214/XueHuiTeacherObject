//
//  XHSignCollectionViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSignCollectionViewCell.h"


@interface XHSignCollectionViewCell()

@property(nonatomic,strong) UIView *timeLine;  //!< 时间轴分割线
@property(nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property(nonatomic,strong) UIView *dotView;  //!< 圆点视图
@property(nonatomic,strong) UIImageView *imageView;  //!< 对号图标

@end

@implementation XHSignCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.timeLine];
        [self.contentView addSubview:self.dotView];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.imageView];
        
        
        [self.timeLine setFrame:CGRectMake(0, 10.0, frame.size.width, 0.5)];
        [self.dotView setFrame:CGRectMake(((frame.size.width-5.0)/2.0), 6.25, 8.0, 8.0)];
        [self.dotView setLayerCornerRadius:(self.dotView.height/2.0)];
        [self.imageView setFrame:CGRectMake(((frame.size.width-15.0)/2.0), 2.5, 15.0, 15.0)];
        [self.dateLabel setFrame:CGRectMake(0.0, 25.0, frame.size.width, 25.0)];
        [self.dateLabel setBackgroundColor:[UIColor orangeColor]];
       
        
//        [self.contentView setBackgroundColor:[UIColor orangeColor]];
    }
    return self;
}
-(void)setItemObject:(XHIntelligentOfficeSignModel*)object
{
    if (object.date)
    {
        [self.imageView setHidden:NO];
        [self.dateLabel setText:object.date];
    }
    else
    {
        [self.imageView setHidden:YES];
        [self.dateLabel setText:@""];
    }
    
}



#pragma mark - Getter /  Setter

- (UIView *)timeLine
{
    if (!_timeLine)
    {
        _timeLine = [[UIView alloc]init];
        [_timeLine setBackgroundColor:RGB(208,208,208)];
    }
    return _timeLine;
}


- (UIView *)dotView
{
    if (!_dotView)
    {
        _dotView = [[UIView alloc]init];
        [_dotView setBackgroundColor:MainColor];
    }
    return _dotView;
}

-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setImage:[UIImage imageNamed:@"ico_dui"]];
    }
    return _imageView;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setTextColor:RGB(51,51,51)];
        [_dateLabel setFont:FontLevel3];
    }
    return _dateLabel;
}


@end
