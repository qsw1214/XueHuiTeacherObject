//
//  XHWeekCollectionViewCell.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHWeekCollectionViewCell.h"

@interface XHWeekCollectionViewCell ()

@property (nonatomic,strong) UILabel *mondayLabel; //!< 周一标签
@property (nonatomic,strong) UILabel *tuesdayLabel; //!< 周二标签
@property (nonatomic,strong) UILabel *wednesdayLabel; //!< 周三标签
@property (nonatomic,strong) UILabel *thursdayLabel; //!< 周四标签
@property (nonatomic,strong) UILabel *fridayLabel; //!< 周五标签


@end

@implementation XHWeekCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.mondayLabel];
        [self.contentView  addSubview:self.tuesdayLabel];
        [self.contentView  addSubview:self.wednesdayLabel];
        [self.contentView  addSubview:self.thursdayLabel];
        [self.contentView  addSubview:self.fridayLabel];
        
        
        
        [self.contentView  setBackgroundColor:[UIColor orangeColor]];
        [self setItemColor:YES];
    }
    return self;
}




#pragma mark - Getter /  Setter
-(void)setItemObject:(XHWeekFrame *)itemFrame
{
        #pragma mark - 重置Frame
        //!< 重置Frame
        [self.mondayLabel setFrame:CGRectMake(0, 0, ((itemFrame.itemSize.width)/5.0), 50.0)];
        [self.tuesdayLabel setFrame:CGRectMake(self.mondayLabel.right, self.mondayLabel.top, self.mondayLabel.width, self.mondayLabel.height)];
        [self.wednesdayLabel setFrame:CGRectMake(self.tuesdayLabel.right, self.mondayLabel.top, self.tuesdayLabel.width, self.mondayLabel.height)];
        [self.thursdayLabel setFrame:CGRectMake(self.wednesdayLabel.right, self.mondayLabel.top, self.wednesdayLabel.width, self.mondayLabel.height)];
        [self.fridayLabel setFrame:CGRectMake(self.thursdayLabel.right, self.mondayLabel.top, self.thursdayLabel.width, self.mondayLabel.height)];
        
        //!< 设置属性
        [self.mondayLabel setFont:FontLevel2];
        [self.tuesdayLabel setFont:FontLevel2];
        [self.wednesdayLabel setFont:FontLevel2];
        [self.thursdayLabel setFont:FontLevel2];
        [self.fridayLabel setFont:FontLevel2];
        
        [self.mondayLabel setBackgroundColor:[UIColor whiteColor]];
        [self.tuesdayLabel setBackgroundColor:[UIColor whiteColor]];
        [self.wednesdayLabel setBackgroundColor:[UIColor whiteColor]];
        [self.thursdayLabel setBackgroundColor:[UIColor whiteColor]];
        [self.fridayLabel setBackgroundColor:[UIColor whiteColor]];
        
        
        [self.mondayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
        [self.tuesdayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
        [self.wednesdayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
        [self.thursdayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
        [self.fridayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
        
#pragma mark - 重新赋值
        [self.mondayLabel setText:itemFrame.model.monday];
        [self.tuesdayLabel setText:itemFrame.model.tuesday];
        [self.wednesdayLabel setText:itemFrame.model.wednesday];
        [self.thursdayLabel setText:itemFrame.model.thursday];
        [self.fridayLabel setText:itemFrame.model.friday];
        
        
        
        switch (itemFrame.model.markType)
        {
            case 1:
            {
                [self.mondayLabel setTextColor:MainColor];
            }
                break;
            case 2:
            {
                [self.tuesdayLabel setTextColor:MainColor];
            }
                break;
            case 3:
            {
                [self.wednesdayLabel setTextColor:MainColor];
            }
                break;
            case 4:
            {
                [self.thursdayLabel setTextColor:MainColor];
            }
                break;
            case 5:
            {
                [self.fridayLabel setTextColor:MainColor];
            }
                break;
            default:
                break;
        }
    }






-(UILabel *)mondayLabel
{
    if (_mondayLabel == nil)
    {
        _mondayLabel = [[UILabel alloc]init];
        [_mondayLabel setLayerBorderWidth:0.5];
        [_mondayLabel setBorderColor:LineViewColor];
        [_mondayLabel setTextAlignment:NSTextAlignmentCenter];
        [_mondayLabel setNumberOfLines:0];
        [_mondayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
    }
    return _mondayLabel;
}

-(UILabel *)tuesdayLabel
{
    if (_tuesdayLabel == nil)
    {
        _tuesdayLabel = [[UILabel alloc]init];
        [_tuesdayLabel setLayerBorderWidth:0.5];
        [_tuesdayLabel setBorderColor:LineViewColor];
        [_tuesdayLabel setTextAlignment:NSTextAlignmentCenter];
        [_tuesdayLabel setNumberOfLines:0];
        [_tuesdayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
    }
    return _tuesdayLabel;
}


-(UILabel *)wednesdayLabel
{
    if (_wednesdayLabel == nil)
    {
        _wednesdayLabel = [[UILabel alloc]init];
        [_wednesdayLabel setLayerBorderWidth:0.5];
        [_wednesdayLabel setBorderColor:LineViewColor];
        [_wednesdayLabel setTextAlignment:NSTextAlignmentCenter];
        [_wednesdayLabel setNumberOfLines:0];
        [_wednesdayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
    }
    return _wednesdayLabel;
}


-(UILabel *)thursdayLabel
{
    if (_thursdayLabel == nil)
    {
        _thursdayLabel = [[UILabel alloc]init];
        [_thursdayLabel setLayerBorderWidth:0.5];
        [_thursdayLabel setBorderColor:LineViewColor];
        [_thursdayLabel setTextAlignment:NSTextAlignmentCenter];
        [_thursdayLabel setNumberOfLines:0];
        [_thursdayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
    }
    return _thursdayLabel;
}


-(UILabel *)fridayLabel
{
    if (_fridayLabel == nil)
    {
        _fridayLabel = [[UILabel alloc]init];
        [_fridayLabel setLayerBorderWidth:0.5];
        [_fridayLabel setBorderColor:LineViewColor];
        [_fridayLabel setTextAlignment:NSTextAlignmentCenter];
        [_fridayLabel setNumberOfLines:0];
        [_fridayLabel setTextColor:RGB(51.0, 51.0, 51.0)];
    }
    return _fridayLabel;
}




-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.mondayLabel setBackgroundColor:[UIColor purpleColor]];
        [self.tuesdayLabel setBackgroundColor:[UIColor yellowColor]];
        [self.wednesdayLabel setBackgroundColor:[UIColor magentaColor]];
        [self.thursdayLabel setBackgroundColor:[UIColor brownColor]];
        [self.fridayLabel setBackgroundColor:[UIColor orangeColor]];
    }
}



@end
