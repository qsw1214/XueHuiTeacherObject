//
//  XHHomeWorkCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkCellContentView.h"
#import "XHHomeWorkCollectionView.h"
#import "BaseButtonControl.h"



@interface XHHomeWorkCellContentView ()

@property (nonatomic,strong) XHHomeWorkCollectionView *collectionView;



@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 作业标签
@property (nonatomic,strong) UILabel *classsLael; //!< 班级标签
@property (nonatomic,strong) UILabel *detailsLabel;  //!< 查看详情标签
@property (nonatomic,strong) UIView *lineView; //!< 分割线



@end



@implementation XHHomeWorkCellContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:YES];
        [self addSubview:self.dateLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.detailsLabel];
        [self addSubview:self.classsLael];
        [self addSubview:self.lineView];
    }
    return self;
}




-(void)setItemFrame:(XHHomeWorkFrame*)itemFrame
{
    //重置Frame
    [self setFrame:itemFrame.itemFrame];
    
    switch (itemFrame.model.homeWorkType)
    {
#pragma mark case HomeWorkType
        case HomeWorkType:
        {
            //设置日期
            [self.dateLabel setFrame:CGRectMake(10.0, 10.0, 120.0, 20.0)];
            //设置内容视图
            [self.contentLabel setFrame:CGRectMake((self.dateLabel.right+10.0), self.dateLabel.top, (itemFrame.itemFrame.size.width-(self.dateLabel.right+20.0)), self.dateLabel.height)];
            //!< 查看详情
            [self.detailsLabel setFrame:CGRectMake(self.dateLabel.left, (self.dateLabel.bottom+10.0), 120.0, self.dateLabel.height)];
            //!< 班级
            [self.classsLael setFrame:CGRectMake(self.dateLabel.left, self.detailsLabel.bottom+10.0,itemFrame.itemFrame.size.width-20.0 , self.dateLabel.height)];
            //!< 分割线
            [self.lineView setFrame:CGRectMake(0, itemFrame.itemFrame.size.height-0.5, itemFrame.itemFrame.size.width, 0.5)];
            
            
            //设置属性
            
            //赋值
            [self.classsLael setText:itemFrame.model.clazzName];
            [self.dateLabel setText:itemFrame.model.releaseDate];
            [self.contentLabel setText:itemFrame.model.workContent];
            switch (itemFrame.model.homeWorkUnreadType)
            {
                case HomeWorkUnreadType:
                {
                    
                }
                    break;
                case HomeWorkAlreadyReadType:
                {
                    
                }
                    break;
            }
        }
            break;
#pragma mark case HomeWorkDetailsType
        case HomeWorkNoticeType:
        {
            //设置日期
            [self.dateLabel setFrame:CGRectMake(10.0, 10.0, 120.0, 20.0)];
            //设置内容视图
            [self.contentLabel setFrame:CGRectMake((self.dateLabel.right+10.0), self.dateLabel.top, (itemFrame.itemFrame.size.width-(self.dateLabel.right+20.0)), self.dateLabel.height)];
            //!< 查看详情
            [self.detailsLabel setFrame:CGRectMake(self.dateLabel.left, (self.dateLabel.bottom+10.0), 120.0, self.dateLabel.height)];
            //!< 班级
            [self.classsLael setFrame:CGRectMake(self.dateLabel.left, self.detailsLabel.bottom+10.0,itemFrame.itemFrame.size.width-20.0 , self.dateLabel.height)];
            //!< 分割线
            [self.lineView setFrame:CGRectMake(0, itemFrame.itemFrame.size.height-0.5, itemFrame.itemFrame.size.width, 0.5)];
            
            
            //设置属性
            
            //赋值
            [self.classsLael setText:itemFrame.model.clazzName];
            [self.dateLabel setText:itemFrame.model.releaseDate];
            [self.contentLabel setText:itemFrame.model.workContent];
            switch (itemFrame.model.homeWorkUnreadType)
            {
                case HomeWorkUnreadType:
                {
                    
                }
                    break;
                case HomeWorkAlreadyReadType:
                {
                    
                }
                    break;
            }
        }
            break;
    }
}






#pragma mark - Getter / Setter
-(UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextAlignment:NSTextAlignmentRight];
        [_dateLabel setTextColor:RGB(124, 124, 124)];
        [_dateLabel setFont:FontLevel4];
    }
    return _dateLabel;
}

-(UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setTextColor:RGB(3, 3, 3)];
        [_contentLabel setFont:FontLevel2];
    }
    return _contentLabel;
}

-(UILabel *)detailsLabel
{
    if (_detailsLabel == nil)
    {
        _detailsLabel = [[UILabel alloc]init];
        [_detailsLabel setTextColor:RGB(2, 2, 2)];
        [_detailsLabel setFont:FontLevel2];
        [_detailsLabel setText:@"查看详情"];
    }
    return _detailsLabel;
}
-(UILabel *)classsLael
{
    if (_classsLael == nil)
    {
        _classsLael = [[UILabel alloc]init];
        [_classsLael setTextAlignment:NSTextAlignmentCenter];
        [_classsLael setTextColor:[UIColor whiteColor]];
        [_classsLael setFont:FontLevel3];
    }
    return _classsLael;
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

-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.classsLael setBackgroundColor:[UIColor yellowColor]];
        [self.detailsLabel setBackgroundColor:[UIColor grayColor]];
        [self.dateLabel setBackgroundColor:[UIColor darkGrayColor]];
        [self.contentLabel setBackgroundColor:[UIColor purpleColor]];
    }
}






@end
