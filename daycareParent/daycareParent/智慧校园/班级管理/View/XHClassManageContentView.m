//
//  XHClassManageContentView.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassManageContentView.h"
#import "XHWeekCollectionView.h"
#import "XHSyllabusCollectionView.h"
#import "XHDayRollCallViewController.h"
#import "XHClassManageHeaderBoardControl.h"
#import "XHSyllabusBoardControl.h"


@interface XHClassManageContentView () <XHWeekCollectionViewDeletage,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *headerBoardControl;
@property (nonatomic,strong) XHClassManageHeaderBoardControl *boardControl; //!< 成绩管理、布置作业、发布通知等
@property (nonatomic,strong) XHSyllabusBoardControl *syllabusBoardControl; //!< 课程表
@property (nonatomic,strong) UILabel *weekTipLabel; //!< 星期提示标签
@property (nonatomic,strong) XHWeekCollectionView *weekCollectionView; //!< 星期滚动
@property (nonatomic,strong) XHSyllabusCollectionView *syllabusCollectionView; //!< 课程表内容






@end


@implementation XHClassManageContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:RGB(251, 251, 251)];
        [self addSubview:self.headerBoardControl];
        [self addSubview:self.boardControl];
        [self addSubview:self.syllabusBoardControl];
        [self addSubview:self.weekTipLabel];
        [self addSubview:self.weekCollectionView];
        [self addSubview:self.syllabusCollectionView];
        
        [self setItemColor:YES];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];

    //!< 头部背景
    [self.headerBoardControl setFrame:CGRectMake(0, 0, frame.size.width, 50.0)];
    //!< 添加头部信息
    [self.boardControl resetFrame:CGRectMake(15.0, 0, (frame.size.width-30.0), 500.0)];
    //!< “课程表”提示
    [self.syllabusBoardControl resetFrame:CGRectMake(self.boardControl.left, (self.boardControl.bottom+20.0), self.boardControl.width, 200.0)];
    
    //!< 星期滚动条
//    [self.weekCollectionView resetFrame:CGRectMake((self.syllabusBoardControl.right+10.0), self.syllabusBoardControl.top, (frame.size.width-(self.syllabusBoardControl.right+10.0+10.0)), self.weekTipLabel.height)];
    [self.syllabusCollectionView resetFrame:CGRectMake(self.syllabusBoardControl.left,self.syllabusBoardControl.bottom+20.0, (frame.size.width-20.0), 100.0)];
    
    //!< 重置当前滚动视图的高度
    [self setContentSize:CGSizeMake(frame.size.width, self.syllabusCollectionView.bottom+200.0)];
}


#pragma mark - Delegate Method
#pragma mark XHWeekCollectionViewDeletage 代理方法
-(void)didSelectItemObjectAtIndexPath:(XHWeekFrame*)object
{
    [self.syllabusCollectionView setItemArray:object.model.syllabusArray];
}

-(void)handleTap:(UIGestureRecognizer *)gesture
{
    XHDayRollCallViewController *day=[[XHDayRollCallViewController alloc] initHiddenWhenPushHidden];
    
    [DCURLRouter pushViewController:day animated:YES];
}

#pragma mark - Getter /  Setter
-(UIView *)headerBoardControl
{
    if (!_headerBoardControl)
    {
        _headerBoardControl = [[UIView alloc]init];
        [_headerBoardControl setBackgroundColor:MainColor];
    }
    return _headerBoardControl;
}
-(XHClassManageHeaderBoardControl *)boardControl
{
    if (!_boardControl)
    {
        _boardControl = [[XHClassManageHeaderBoardControl alloc]init];
    }
    return _boardControl;
}

-(XHSyllabusBoardControl *)syllabusBoardControl
{
    if (!_syllabusBoardControl)
    {
        _syllabusBoardControl = [[XHSyllabusBoardControl alloc]init];
    }
    return _syllabusBoardControl;
}


-(UILabel *)weekTipLabel
{
    if (!_weekTipLabel)
    {
        _weekTipLabel = [[UILabel alloc]init];
        [_weekTipLabel setText:@"课程表"];
        [_weekTipLabel setBackgroundColor:[UIColor grayColor]];
        [_weekTipLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _weekTipLabel;
}


-(XHWeekCollectionView *)weekCollectionView
{
    if (!_weekCollectionView)
    {

        _weekCollectionView = [[XHWeekCollectionView alloc]init];
        [_weekCollectionView setWeekDeletage:self];
    }
    return _weekCollectionView;
}


-(XHSyllabusCollectionView *)syllabusCollectionView
{
    if (!_syllabusCollectionView)
    {
        
        _syllabusCollectionView = [[XHSyllabusCollectionView alloc]init];
    }
    return _syllabusCollectionView;
}


#pragma mark - setItemColor:(BOOL)color
-(void)setItemColor:(BOOL)color
{
    if (color)
    {
    }
}




@end

