//
//  XHClassManageContentView.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassManageContentView.h"
#import "XHSyllabusBoardControl.h"
#import "XHDayRollCallViewController.h"
#import "XHClassManageHeaderBoardControl.h"



@interface XHClassManageContentView () 

@property (nonatomic,strong) UIView *headerBoardControl;
@property (nonatomic,strong) XHClassManageHeaderBoardControl *boardControl; //!< 成绩管理、布置作业、发布通知等
@property (nonatomic,strong) XHSyllabusBoardControl *syllabusBoardControl; //!< 课程表
@property (nonatomic,copy) NSString *classid;






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
        [self setBounces:YES];
        [self setItemColor:YES];
        
        [self showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self beginRefreshing];
    }
    return self;
}


-(void)setItemObject:(id)object
{
    [self setClassid:object];
    [self withClassid:object];
}


#pragma mark 网络请求数据
-(void)refreshHeaderAction
{
    [self withClassid:self.classid];
}

-(void)withClassid:(NSString*)classid
{
    @WeakObj(self);
    [self.boardControl setItemObject:classid withBlock:^(BOOL refresh)
     {
         @StrongObj(self);
         [self refreshReloadData];
     }];
    
    [self.syllabusBoardControl setItemObject:classid withBlock:^(CGFloat height, BOOL refresh)
     {
         @StrongObj(self);
         //!< 重置当前滚动视图的高度
         [self setContentSize:CGSizeMake(SCREEN_WIDTH, (self.boardControl.bottom+20.0+height))];
          [self refreshReloadData];
     }];
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];

    //!< 头部背景
    [self.headerBoardControl setFrame:CGRectMake(0, 0, frame.size.width, 50.0)];
    //!< 添加头部信息
    [self.boardControl resetFrame:CGRectMake(15.0, 0, (frame.size.width-30.0), 100.0)];
    
    [self setLayerShadowCornerRadius:5.0 withBackgroundColor:[UIColor grayColor] withShadowColor:[UIColor grayColor] withShadowOffset:CGSizeMake(10.0, 10.0) withShadowOpacity:1.0 withShadowRadius:5.0 withTarget:self.boardControl];
    
    
    
    //!< “课程表”提示
    [self.syllabusBoardControl resetFrame:CGRectMake(self.boardControl.left, (self.boardControl.bottom+20.0), self.boardControl.width, 100.0)];
    
   
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




#pragma mark - setItemColor:(BOOL)color
-(void)setItemColor:(BOOL)color
{
    if (color)
    {
    }
}




@end

