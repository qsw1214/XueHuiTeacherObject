//
//  XHSyllabusHeaderBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSyllabusHeaderBoardControl.h"
#import "XHWeekFrame.h"


@interface XHSyllabusHeaderBoardControl ()

@property (nonatomic,strong) BaseButtonControl *mondayBoard;
@property (nonatomic,strong) BaseButtonControl *tuesdayBoard;
@property (nonatomic,strong) BaseButtonControl *wednesdayBoard;
@property (nonatomic,strong) BaseButtonControl *thursdayBoard;
@property (nonatomic,strong) BaseButtonControl *fridayBoard;

@end


@implementation XHSyllabusHeaderBoardControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.mondayBoard];
        [self addSubview:self.tuesdayBoard];
        [self addSubview:self.wednesdayBoard];
        [self addSubview:self.thursdayBoard];
        [self addSubview:self.fridayBoard];
    }
    return self;
}




-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    //!< 重置星期标签
    //!< 周一
    [self.mondayBoard resetFrame:CGRectMake(0, 0, ((frame.size.width)/5.0), frame.size.height)];
    [self.mondayBoard setTitleEdgeFrame:CGRectMake(0, 0, self.mondayBoard.width, self.mondayBoard.height) withNumberType:0 withAllType:NO];
    [self.mondayBoard resetLineViewFrame:CGRectMake(10.0, self.mondayBoard.height-3.0, self.mondayBoard.width-20.0, 3.0) withNumberType:0 withAllType:NO];
    //!< 周二
    [self.tuesdayBoard resetFrame:CGRectMake(self.mondayBoard.right, self.mondayBoard.top, self.mondayBoard.width, self.mondayBoard.height)];
    [self.tuesdayBoard setTitleEdgeFrame:CGRectMake(0, 0, self.mondayBoard.width, self.mondayBoard.height) withNumberType:0 withAllType:NO];
    [self.tuesdayBoard resetLineViewFrame:CGRectMake(10.0, self.mondayBoard.height-3.0, self.mondayBoard.width-20.0, 3.0) withNumberType:0 withAllType:NO];
    //!< 周三
    [self.wednesdayBoard resetFrame:CGRectMake(self.tuesdayBoard.right, self.tuesdayBoard.top, self.tuesdayBoard.width, self.tuesdayBoard.height)];
    [self.wednesdayBoard setTitleEdgeFrame:CGRectMake(0, 0, self.mondayBoard.width, self.mondayBoard.height) withNumberType:0 withAllType:NO];
    [self.wednesdayBoard resetLineViewFrame:CGRectMake(10.0, self.mondayBoard.height-3.0, self.mondayBoard.width-20.0, 3.0) withNumberType:0 withAllType:NO];
    //!< 周四
    [self.thursdayBoard resetFrame:CGRectMake(self.wednesdayBoard.right, self.wednesdayBoard.top, self.wednesdayBoard.width, self.wednesdayBoard.height)];
    [self.thursdayBoard setTitleEdgeFrame:CGRectMake(0, 0, self.mondayBoard.width, self.mondayBoard.height) withNumberType:0 withAllType:NO];
    [self.thursdayBoard resetLineViewFrame:CGRectMake(10.0, self.mondayBoard.height-3.0, self.mondayBoard.width-20.0, 3.0) withNumberType:0 withAllType:NO];
    //!< 周五
    [self.fridayBoard resetFrame:CGRectMake(self.thursdayBoard.right, self.thursdayBoard.top, self.thursdayBoard.width, self.thursdayBoard.height)];
    [self.fridayBoard setTitleEdgeFrame:CGRectMake(0, 0, self.mondayBoard.width, self.mondayBoard.height) withNumberType:0 withAllType:NO];
    [self.fridayBoard resetLineViewFrame:CGRectMake(10.0, self.mondayBoard.height-3.0, self.mondayBoard.width-20.0, 3.0) withNumberType:0 withAllType:NO];
    //!< 设置属性
}




-(void)setWeekMake:(NSInteger)weekMark
{
#pragma mark - 重新赋值


    [self.mondayBoard setlineViewHidden:YES withNumberType:0 withAllType:NO];
    [self.tuesdayBoard setlineViewHidden:YES withNumberType:0 withAllType:NO];
    [self.wednesdayBoard setlineViewHidden:YES withNumberType:0 withAllType:NO];
    [self.thursdayBoard setlineViewHidden:YES withNumberType:0 withAllType:NO];
    [self.fridayBoard setlineViewHidden:YES withNumberType:0 withAllType:NO];
    
    
    switch (weekMark)
    {
        case 1:
        {
            [self.mondayBoard resetLineViewColor:MainColor withNumberType:0 withAllType:NO];
        }
            break;
        case 2:
        {
            [self.tuesdayBoard resetLineViewColor:MainColor withNumberType:0 withAllType:NO];
        }
            break;
        case 3:
        {
            [self.wednesdayBoard resetLineViewColor:MainColor withNumberType:0 withAllType:NO];
        }
            break;
        case 4:
        {
            [self.thursdayBoard resetLineViewColor:MainColor withNumberType:0 withAllType:NO];
        }
            break;
        case 5:
        {
            [self.fridayBoard resetLineViewColor:MainColor withNumberType:0 withAllType:NO];
        }
            break;
    }
}


#pragma mark - Getter /  Setter
-(BaseButtonControl *)mondayBoard
{
    if (_mondayBoard == nil)
    {
        _mondayBoard = [[BaseButtonControl alloc]init];
        [_mondayBoard setNumberLabel:1];
        [_mondayBoard setNumberLineView:1];
        [_mondayBoard setFont:FontLevel4 withNumberType:0 withAllType:NO];
        [_mondayBoard setTextColor:MainColor withTpe:0 withAllType:NO];
        [_mondayBoard setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_mondayBoard setText:@"周一" withNumberType:0 withAllType:NO];
        [_mondayBoard setLayerBorderWidth:0.5];
        [_mondayBoard setBorderColor:LineViewColor];
    }
    return _mondayBoard;
}

-(BaseButtonControl *)tuesdayBoard
{
    if (_tuesdayBoard == nil)
    {
        _tuesdayBoard = [[BaseButtonControl alloc]init];
        [_tuesdayBoard setNumberLabel:1];
        [_tuesdayBoard setNumberLineView:1];
        [_tuesdayBoard setFont:FontLevel4 withNumberType:0 withAllType:NO];
        [_tuesdayBoard setTextColor:MainColor withTpe:0 withAllType:NO];
        [_tuesdayBoard setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_tuesdayBoard setText:@"周二" withNumberType:0 withAllType:NO];
        [_tuesdayBoard setLayerBorderWidth:0.5];
        [_tuesdayBoard setBorderColor:LineViewColor];
    }
    return _tuesdayBoard;
}


-(BaseButtonControl *)wednesdayBoard
{
    if (_wednesdayBoard == nil)
    {
        _wednesdayBoard = [[BaseButtonControl alloc]init];
        [_wednesdayBoard setNumberLabel:1];
        [_wednesdayBoard setNumberLineView:1];
        [_wednesdayBoard setFont:FontLevel4 withNumberType:0 withAllType:NO];
        [_wednesdayBoard setTextColor:MainColor withTpe:0 withAllType:NO];
        [_wednesdayBoard setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_wednesdayBoard setText:@"周三" withNumberType:0 withAllType:NO];
        [_wednesdayBoard setLayerBorderWidth:0.5];
        [_wednesdayBoard setBorderColor:LineViewColor];
    }
    return _wednesdayBoard;
}


-(BaseButtonControl *)thursdayBoard
{
    if (_thursdayBoard == nil)
    {
        _thursdayBoard = [[BaseButtonControl alloc]init];
        [_thursdayBoard setNumberLabel:1];
        [_thursdayBoard setNumberLineView:1];
        [_thursdayBoard setFont:FontLevel4 withNumberType:0 withAllType:NO];
        [_thursdayBoard setTextColor:MainColor withTpe:0 withAllType:NO];
        [_thursdayBoard setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_thursdayBoard setText:@"周四" withNumberType:0 withAllType:NO];
        [_thursdayBoard setLayerBorderWidth:0.5];
        [_thursdayBoard setBorderColor:LineViewColor];
    }
    return _thursdayBoard;
}


-(BaseButtonControl *)fridayBoard
{
    if (_fridayBoard == nil)
    {
        _fridayBoard = [[BaseButtonControl alloc]init];
        [_fridayBoard setNumberLabel:1];
        [_fridayBoard setNumberLineView:1];
        [_fridayBoard setFont:FontLevel4 withNumberType:0 withAllType:NO];
        [_fridayBoard setTextColor:MainColor withTpe:0 withAllType:NO];
        [_fridayBoard setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_fridayBoard setText:@"周五" withNumberType:0 withAllType:NO];
        [_fridayBoard setLayerBorderWidth:0.5];
        [_fridayBoard setBorderColor:LineViewColor];
    }
    return _fridayBoard;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.mondayBoard setBackgroundColor:[UIColor orangeColor]];
        [self.tuesdayBoard setBackgroundColor:[UIColor magentaColor]];
        [self.wednesdayBoard setBackgroundColor:[UIColor brownColor]];
        [self.thursdayBoard setBackgroundColor:[UIColor orangeColor]];
        [self.fridayBoard setBackgroundColor:[UIColor yellowColor]];
    }
}

@end
