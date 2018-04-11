//
//  LXCalendarView.m
//  LXCalendar
//
//  Created by chenergou on 2017/11/2.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "XHCalendarView.h"
#import "LXCalendarHearder.h"
#import "LXCalendarWeekView.h"
#import "LXCalenderCell.h"
#import "LXCalendarMonthModel.h"
#import "LXCalendarDayModel.h"
@interface XHCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)LXCalendarHearder *calendarHeader; //头部
@property(nonatomic,strong)LXCalendarWeekView *calendarWeekView;//周
@property(nonatomic,strong)UICollectionView *collectionView;//日历
@property(nonatomic,strong)NSMutableArray *monthdataA;//当月的模型集合
@property(nonatomic,strong)NSDate *currentMonthDate;//当月的日期
@property(nonatomic,assign)BOOL isCurrentMonth;//绝对当月的日期
@property(nonatomic,strong)UISwipeGestureRecognizer *leftSwipe;//左滑手势
@property(nonatomic,strong)UISwipeGestureRecognizer *rightSwipe;//右滑手势
@property(nonatomic,strong)UIColor *currentMonthTitleColor;//!< 当前月的title颜色
@property(nonatomic,strong)UIColor *lastMonthTitleColor;//!< 上月的title颜色
@property(nonatomic,strong)UIColor *nextMonthTitleColor;//!< 下月的title颜色
@property(nonatomic,strong)UIColor *selectBackColor;//!< 选中的背景颜色
@property(nonatomic,strong)UIColor *todayTitleColor;//!< 今日的title颜色
@property(nonatomic,assign)BOOL     isHaveAnimation;//!<  选中的是否动画效果
@property(nonatomic,assign)BOOL     isCanScroll;//!< 是否禁止手势滚动
@property(nonatomic,assign)BOOL     isShowLastAndNextBtn;//!< 是否显示上月，下月的按钮
@property(nonatomic,assign)BOOL     isShowLastAndNextDate;//!< 是否显示上月，下月的的数据
@property(nonatomic,strong)ParentControl *cancleControl;//!< 取消按钮
@property(nonatomic,strong)ParentControl *sureControl;//!< 确定按钮
@property(nonatomic,strong) LXCalendarDayModel *calendarModel;


@end
@implementation XHCalendarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentMonthDate = [NSDate date];
        self.isCurrentMonth=YES;
        
        [self addSubviews];
        
        
    }
    return self;
}
-(instancetype)initWithDelegate:(id)delegate
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        [self setDelegate:delegate];
        self.currentMonthDate = [NSDate date];
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        [self addSubviews];
        
        [self dealData];
        
    }
    return self;
}
-(void)show
{
    [kWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.baseView.frame=CGRectMake((SCREEN_WIDTH-300)/2.0, (SCREEN_HEIGHT-440)/2.0, 300, 440);
        self.calendarHeader.frame = CGRectMake(0, 0, 300, 45);
    } completion:^(BOOL finished){
     
    }];
}
-(void)dismiss
{
    [UIView animateWithDuration:0.20 animations:^{
        
        self.baseView.frame=CGRectMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0, 0, 0);
        
    } completion:^(BOOL finished)
     {
         [self removeFromSuperview];
     }];
}
-(void)dealData{
    
    
    [self responData];
}
-(void)addSubviews{
    
    [self addSubview:self.baseView];
    self.baseView.layer.cornerRadius=8;
    self.baseView.layer.masksToBounds=YES;
    
    [self.baseView addSubview:self.calendarHeader];
    
    @WeakObj(self);
    self.calendarHeader.leftClickBlock = ^{
        @StrongObj(self);
        [self rightSlide];
    };
    
    self.calendarHeader.rightClickBlock = ^{
        @StrongObj(self);
        [self leftSlide];

    };
    [self.baseView addSubview:self.calendarWeekView];
    
    [self.baseView addSubview:self.collectionView];
   
    //添加左滑右滑手势
   self.leftSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
   self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.collectionView addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.collectionView addGestureRecognizer:self.rightSwipe];
    [self.baseView addSubview:self.cancleControl];
   [self.baseView addSubview:self.sureControl];
    
    self.currentMonthTitleColor =[UIColor blackColor];
    self.lastMonthTitleColor =[UIColor blackColor];
    self.nextMonthTitleColor =[UIColor blackColor];
    
    self.isHaveAnimation = YES;
    
    self.isCanScroll = YES;
    self.isShowLastAndNextBtn = YES;
    
    self.todayTitleColor =MainColor;
    
    self.selectBackColor =[UIColor redColor];
    
    self.isShowLastAndNextDate = NO;
}

#pragma mark --左滑手势--
-(void)leftSwipe:(UISwipeGestureRecognizer *)swipe{
    
    [self leftSlide];
}
#pragma mark --左滑处理--
-(void)leftSlide{
    self.currentMonthDate = [self.currentMonthDate nextMonthDate];
    
    [self performAnimations:kCATransitionFromRight];
    [self responData];
}
#pragma mark --右滑处理--
-(void)rightSlide{
    
    self.currentMonthDate = [self.currentMonthDate previousMonthDate];
    [self performAnimations:kCATransitionFromLeft];
    
    [self responData];
}
#pragma mark --右滑手势--
-(void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
   
    [self rightSlide];
}
#pragma mark--动画处理--
- (void)performAnimations:(NSString *)transition{
    CATransition *catransition = [CATransition animation];
    catransition.duration = 0.5;
    [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    catransition.type = kCATransitionPush; //choose your animation
    catransition.subtype = transition;
    [self.collectionView.layer addAnimation:catransition forKey:nil];
}

#pragma mark--数据以及更新处理--
-(void)responData{
    
    [self.monthdataA removeAllObjects];
    
    NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
    
    NSDate *nextMonthDate = [self.currentMonthDate  nextMonthDate];
    
    LXCalendarMonthModel *monthModel = [[LXCalendarMonthModel alloc]initWithDate:self.currentMonthDate];
    
    LXCalendarMonthModel *lastMonthModel = [[LXCalendarMonthModel alloc]initWithDate:previousMonthDate];
    
     LXCalendarMonthModel *nextMonthModel = [[LXCalendarMonthModel alloc]initWithDate:nextMonthDate];
    
    self.calendarHeader.dateStr = [NSString stringWithFormat:@"%ld年%ld月",monthModel.year,monthModel.month];
    
    NSInteger firstWeekday = monthModel.firstWeekday;
    
    NSInteger totalDays = monthModel.totalDays;

    for (int i = 0; i <42; i++) {
        
        LXCalendarDayModel *model =[[LXCalendarDayModel alloc]init];
        
        //配置外面属性
        [self configDayModel:model];
        
        model.firstWeekday = firstWeekday;
        model.totalDays = totalDays;
        
        model.month = monthModel.month;
        
        model.year = monthModel.year;
        
        
        //上个月的日期
        if (i < firstWeekday) {
            model.day = lastMonthModel.totalDays - (firstWeekday - i) + 1;
            model.isLastMonth = YES;
        }
        
        //当月的日期
        if (i >= firstWeekday && i < (firstWeekday + totalDays)) {
            
            model.day = i -firstWeekday +1;
            model.isCurrentMonth = YES;
            
            //标识是今天
            if ((monthModel.month == [[NSDate date] dateMonth]) && (monthModel.year == [[NSDate date] dateYear]))
            {
                if (i == [[NSDate date] dateDay] + firstWeekday - 1)
                {
                    
                    model.isToday = YES;
                    self.calendarModel=model;
                    
                }
                if (i > [[NSDate date] dateDay] + firstWeekday - 1)
                {
                    
                    model.isExceedToday = YES;
                    
                }
               
            }
            else if (((monthModel.month < [[NSDate date] dateMonth]) && (monthModel.year == [[NSDate date] dateYear]))||(monthModel.year < [[NSDate date] dateYear]))
            {
                model.isExceedToday = NO;
            }
            else
            {
                model.isExceedToday = YES;
            }
        }
         //下月的日期
        if (i >= (firstWeekday + monthModel.totalDays)) {
            
            model.day = i -firstWeekday - nextMonthModel.totalDays +1;
            model.isNextMonth = YES;
        }
        
        [self.monthdataA addObject:model];
        
    }
    
    [self.collectionView reloadData];
    
}
-(void)configDayModel:(LXCalendarDayModel *)model{
    

    //配置外面属性
    model.isHaveAnimation = self.isHaveAnimation;
    
    model.currentMonthTitleColor = self.currentMonthTitleColor;
    
    model.lastMonthTitleColor = self.lastMonthTitleColor;
    
    model.nextMonthTitleColor = self.nextMonthTitleColor;
    
    model.selectBackColor = self.selectBackColor;
    
    model.isHaveAnimation = self.isHaveAnimation;
    
    model.todayTitleColor = self.todayTitleColor;
    
    model.isShowLastAndNextDate = self.isShowLastAndNextDate;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.monthdataA.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"cell";
    LXCalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    if (!cell) {
        cell =[[LXCalenderCell alloc]init];
        
    }
    
    cell.model = self.monthdataA[indexPath.row];

    cell.backgroundColor =[UIColor whiteColor];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    LXCalendarDayModel *model = self.monthdataA[indexPath.row];

    if (!model.isExceedToday)
    {
        model.isSelected = YES;
        
        [self.monthdataA enumerateObjectsUsingBlock:^(LXCalendarDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj != model) {
                obj.isSelected = NO;
            }
        }];
        self.calendarModel=model;
        
        [collectionView reloadData];
    }
    
    
}
-(void)controlMethod:(UIControl *)control
{
    switch (control.tag) {
        case 1:
        {
              [self dismiss];
        }
            break;
            
        case 2:
        {
            if (self.calendarModel)
            {
                if ([self.delegate respondsToSelector:@selector(getCalendarDateStr:)]) {
                    [self.delegate getCalendarDateStr:kFormat(@"%ld年%ld月%ld日",self.calendarModel.year,self.calendarModel.month,self.calendarModel.day)];
                    [self dismiss];
                }
                
            }
            
        }
            break;
    }
}

#pragma mark---懒加载
-(LXCalendarHearder *)calendarHeader{
    if (!_calendarHeader) {
        _calendarHeader =[LXCalendarHearder showView];
        _calendarHeader.frame = CGRectMake(0, 0, 300, 45);
        _calendarHeader.backgroundColor =MainColor;
    }
    return _calendarHeader;
}
-(LXCalendarWeekView *)calendarWeekView{
    if (!_calendarWeekView) {
        _calendarWeekView =[[LXCalendarWeekView alloc]initWithFrame:CGRectMake(0, self.calendarHeader.bottom, 300, 50)];
        _calendarWeekView.weekTitles = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    }
    return _calendarWeekView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        
        UICollectionViewFlowLayout *flow =[[UICollectionViewFlowLayout alloc]init];
        //325*403
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        flow.sectionInset =UIEdgeInsetsMake(0 , 0, 0, 0);
        
        flow.itemSize = CGSizeMake(300/7, 50);
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.calendarWeekView.bottom, 300, 6 * 50) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        UINib *nib = [UINib nibWithNibName:@"LXCalenderCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}
-(ParentControl *)cancleControl
{
    if (_cancleControl==nil) {
        _cancleControl=[[ParentControl alloc] initWithFrame:CGRectMake(0, 400, (SCREEN_WIDTH-80)/2.0, 45)];
        [_cancleControl setNumberLabel:2];
        [_cancleControl setLabelCGRectMake:CGRectMake(0, 0, _cancleControl.width, 0.5) withNumberIndex:0];
        [_cancleControl setLabelBackgroundColor:LineViewColor withNumberIndex:0];
        [_cancleControl setLabelCGRectMake:CGRectMake(0, 0.5, _cancleControl.width, _cancleControl.height-0.5) withNumberIndex:1];
        [_cancleControl setLabelText:@"取消" withNumberIndex:1];
        [_cancleControl setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:1];
        [_cancleControl setTag:1];
        [_cancleControl addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleControl;
}
-(ParentControl *)sureControl
{
    if (_sureControl==nil) {
        _cancleControl=[[ParentControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2.0, 400, (SCREEN_WIDTH-80)/2.0, 45)];
        [_cancleControl setNumberLabel:2];
        [_cancleControl setLabelCGRectMake:CGRectMake(0, 0, _cancleControl.width, 0.5) withNumberIndex:0];
        [_cancleControl setLabelBackgroundColor:LineViewColor withNumberIndex:0];
        [_cancleControl setLabelCGRectMake:CGRectMake(0, 0.5, _cancleControl.width, _cancleControl.height-0.5) withNumberIndex:1];
        [_cancleControl setLabelText:@"确定" withNumberIndex:1];
        [_cancleControl setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:1];
        [_cancleControl setTag:2];
        [_cancleControl addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleControl;
}
-(NSMutableArray *)monthdataA{
    if (!_monthdataA) {
        _monthdataA =[NSMutableArray array];
    }
    return _monthdataA;
}

/*
 * 当前月的title颜色
 */
-(void)setCurrentMonthTitleColor:(UIColor *)currentMonthTitleColor{
    _currentMonthTitleColor = currentMonthTitleColor;
}
/*
 * 上月的title颜色
 */
-(void)setLastMonthTitleColor:(UIColor *)lastMonthTitleColor{
    _lastMonthTitleColor = lastMonthTitleColor;
}
/*
 * 下月的title颜色
 */
-(void)setNextMonthTitleColor:(UIColor *)nextMonthTitleColor{
    _nextMonthTitleColor = nextMonthTitleColor;
}

/*
 * 选中的背景颜色
 */
-(void)setSelectBackColor:(UIColor *)selectBackColor{
    _selectBackColor = selectBackColor;
}

/*
 * 选中的是否动画效果
 */

-(void)setIsHaveAnimation:(BOOL)isHaveAnimation{
    
    _isHaveAnimation  = isHaveAnimation;
}

/*
 * 是否禁止手势滚动
 */
-(void)setIsCanScroll:(BOOL)isCanScroll{
    _isCanScroll = isCanScroll;
    
    self.leftSwipe.enabled = self.rightSwipe.enabled = isCanScroll;
}

/*
 * 是否显示上月，下月的按钮
 */

-(void)setIsShowLastAndNextBtn:(BOOL)isShowLastAndNextBtn{
    _isShowLastAndNextBtn  = isShowLastAndNextBtn;
    self.calendarHeader.isShowLeftAndRightBtn = isShowLastAndNextBtn;
}


/*
 * 是否显示上月，下月的的数据
 */
-(void)setIsShowLastAndNextDate:(BOOL)isShowLastAndNextDate{
    _isShowLastAndNextDate =  isShowLastAndNextDate;
}
/*
 * 今日的title颜色
 */

-(void)setTodayTitleColor:(UIColor *)todayTitleColor{
    _todayTitleColor = todayTitleColor;
}
@end
