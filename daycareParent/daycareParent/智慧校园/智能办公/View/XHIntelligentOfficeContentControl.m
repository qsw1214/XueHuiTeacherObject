//
//  XHIntelligentOfficeContentControl.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeContentControl.h"
#import "XHIntelligentOfficeFrame.h"


@interface XHIntelligentOfficeContentControl ()

@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *titleLabel; //!< 调课申请、请假申请
@property (nonatomic,strong) UILabel *markLabel; //!< 待审批、已审批标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 内容标签
@property (nonatomic,strong) UILabel *approverLabel; //!< 审批人标签
@property (nonatomic,strong) UIImageView *dotImageView; //!< 时间轴圆点
@property (nonatomic,strong) UIView *timeline; //!< 时间轴



@end

@implementation XHIntelligentOfficeContentControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:YES];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.timeline];
        [self addSubview:self.dateLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.markLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.approverLabel];
        [self addSubview:self.dotImageView];
        
    }
    return self;
}



-(void)setItemFrame:(XHIntelligentOfficeFrame*)frame
{
    [self setFrame:frame.itemFrame];
    
    [self.dotImageView setFrame:CGRectMake(10.0, 10.0, 20.0, 20.0)];
    [self.dotImageView setLayerCornerRadius:(self.dotImageView.height/2.0)];
    [self.dateLabel setFrame:CGRectMake((self.dotImageView.right+10.0), self.dotImageView.top, (frame.itemFrame.size.width-(self.dotImageView.right+20.0)), self.dotImageView.height)];
    [self.titleLabel setFrame:CGRectMake((self.dateLabel.left+10.0), (self.dateLabel.bottom+20.0), 70.0, 20.0)];
    [self.markLabel setFrame:CGRectMake((self.titleLabel.right+10.0), self.titleLabel.top, 50.0, 20.0)];
    [self.contentLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+10.0, (frame.itemFrame.size.width-(self.titleLabel.left+20.0)), 40.0)];
    [self.approverLabel setFrame:CGRectMake(frame.itemFrame.size.width-110.0, self.contentLabel.bottom+10.0, 100.0, 20.0)];
    [self.timeline setFrame:CGRectMake((10+((20-0.5)/2.0)),self.dotImageView.top , 0.5, frame.itemFrame.size.height)];
    
}



#pragma mark - Getter /  Setter
-(UILabel *)dateLabel
{
    if (!_dateLabel)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setText:@"2018-04-10 12:35:26"];
    }
    return _dateLabel;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
        [_titleLabel setText:@"调课申请"];
    }
    return _titleLabel;
}
-(UILabel *)markLabel
{
    if (!_markLabel)
    {
        _markLabel = [[UILabel alloc]init];
        [_markLabel setFont:FontLevel5];
        [_markLabel setTextAlignment:NSTextAlignmentCenter];
        [_markLabel setLayerBorderWidth:0.5];
        [_markLabel setBorderColor:LineViewColor];
        [_markLabel setText:@"待审批"];
        
    }
    return _markLabel;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setFont:FontLevel4];
        [_contentLabel setBackgroundColor:[UIColor purpleColor]];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setText:@"轩逸的优势主要在于舒适性，这也是日产品牌一贯的特点。轩逸的座椅是三者里对身体承托承最好的，侧围及椅背都能与身体很好的接触，且能起到不弱的支撑作用，坐在上面比较放松。行驶起来后，轩逸的CVT变速箱的表现会异常平顺，再加上较软的悬架可以将颠簸尽量过滤，会给带来较强的舒适性。还有点值得一提，轩逸的两款高配车型可以选装日产的i-SAFETY智能防碰撞系统，主动安全性方面的表现是另外两款车型无法相比的。"];
    }
    return _contentLabel;
}
-(UILabel *)approverLabel
{
    if (!_approverLabel)
    {
        _approverLabel = [[UILabel alloc]init];
        [_approverLabel setFont:FontLevel4];
        [_approverLabel setText:@"审批人：姚立志"];
    }
    return _approverLabel;
}


-(UIImageView *)dotImageView
{
    if (!_dotImageView)
    {
        _dotImageView = [[UIImageView alloc]init];
        [_dotImageView setBackgroundColor:[UIColor purpleColor]];
    }
    return _dotImageView;
}


-(UIView *)timeline
{
    if (!_timeline)
    {
        _timeline = [[UIView alloc]init];
        [_timeline setBackgroundColor:LineViewColor];
    }
    return _timeline;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.dateLabel setBackgroundColor:[UIColor redColor]];
        [self.approverLabel setBackgroundColor:[UIColor purpleColor]];
        [self.contentLabel setBackgroundColor:[UIColor orangeColor]];
        [self.titleLabel setBackgroundColor:[UIColor greenColor]];
    }
}




@end
