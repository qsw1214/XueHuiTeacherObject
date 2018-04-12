//
//  XHSignCollectionViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSignCollectionViewCell.h"


@interface XHSignCollectionViewCell()
@property(nonatomic,strong)UILabel *bgLabel;
@property(nonatomic,strong)UILabel *quanLabel;
@property(nonatomic,strong)ParentImageView *imageView;
@property(nonatomic,strong)ParentLabel *timeLabel;
@end

@implementation XHSignCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _bgLabel=[[UILabel alloc] init];
        _bgLabel.backgroundColor=RGB(208, 208, 208);
        [self.contentView addSubview:_bgLabel];
        _quanLabel=[[UILabel alloc] init];
        _quanLabel.backgroundColor=MainColor;
        [self.contentView addSubview:_quanLabel];
        _imageView=[[ParentImageView alloc] init];
        [self.contentView addSubview:_imageView];
        _timeLabel=[[ParentLabel alloc] init];
        _timeLabel.font=kFont(14.0);
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
       
    }
    return self;
}
-(void)setItemObject:(id)object withIndexPathRow:(NSInteger)row
{
    self.bgLabel.frame=CGRectMake(0, 10, self.contentView.frame.size.width, 1);
    self.quanLabel.frame=CGRectMake((self.contentView.frame.size.width-7)/2.0, self.bgLabel.bottom-self.bgLabel.height/2.0-7/2.0, 7, 7);
    [self.quanLabel setLayerCornerRadius:7/2.0];
    self.imageView.frame=CGRectMake((self.contentView.frame.size.width-18)/2.0, self.bgLabel.bottom-self.bgLabel.height/2.0-18/2.0, 18, 18);
     [self.imageView setLayerCornerRadius:18/2.0];
    self.timeLabel.frame=CGRectMake(0, self.imageView.bottom, self.contentView.frame.size.width, self.contentView.frame.size.height-self.imageView.height-20);
    
    if (row<3)
    {
        self.quanLabel.hidden=YES;
        self.imageView.hidden=NO;
        self.imageView.image=[UIImage imageNamed:@"ico_dui"];
        self.timeLabel.text=@"8:43";
    }
    else
    {
        self.quanLabel.hidden=NO;
        self.imageView.hidden=YES;
        self.imageView.image=[UIImage imageNamed:@""];
        self.timeLabel.text=@"";
    }
}
@end
