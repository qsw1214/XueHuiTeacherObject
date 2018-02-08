//
//  BaseScrollView.m
//  daycareParent
//
//  Created by Git on 2017/12/23.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        if (@available(iOS 11.0, *))
        {
            [self setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    return self;
}



#pragma mark 是否隐藏头部刷新，不调用该方法，默认为隐藏，调用该方法后即可显示
/**
 是否隐藏头部刷新，不调用该方法，默认为隐藏，调用该方法后即可显示
 -(void)refreshHeaderAction
 */
-(void)showRefresHeaderWithTarget:(id)target withSelector:(SEL)selector
{
    self.animateHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:selector];
    [self setHeader:self.animateHeader];
}




#pragma mark 设置脚部刷新
/**
 是否隐藏头部刷新，不调用该方法，默认为隐藏，调用该方法后即可显示
 -(void)refreshFooterAction
 */
-(void)showRefresFooterWithTarget:(id)target withSelector:(SEL)selector;
{
    self.animateFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:selector];
    [self setFooter:self.animateFooter];
    
}

#pragma mark 进入刷新

/**
 开始刷新
 */
-(void)beginRefreshing
{
    [self.header beginRefreshing];
}



/**
 重新刷新数据
 */
-(void)refreshReloadData
{
    [self.header endRefreshing];
    [self.footer endRefreshing];
}

-(void)setItemColor:(BOOL)color
{
    
}

-(void)resetFrame:(CGRect)frame
{
    
}

#pragma mark - Getter / Setter
-(NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark-------------显示日历视图--------------
-(XHCustomDatePickerView *)datePickerView
{
    if (_datePickerView==nil) {
        _datePickerView=[[XHCustomDatePickerView alloc] initWithFrame:WindowScreen];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _datePickerView.view.frame=CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
    [UIView commitAnimations];
    return _datePickerView;
    
}
@end
