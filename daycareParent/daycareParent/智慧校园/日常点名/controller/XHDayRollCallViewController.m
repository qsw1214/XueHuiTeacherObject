//
//  XHDayRollCallViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollCallViewController.h"
#import "XHCustomDatePickerView.h"
#import "BaseCollectionView.h"
#import "XHDayRollCallModel.h"
#import "XHDayRollCollectionViewCell.h"
#import "XHDayRollCallDetailViewController.h"
#import "XHClassListModel.h"
#import "XHDayRollCallModel.h"
#import "XHClassViewController.h"
#import "XHCalendarView.h"
#import "XHClassSignView.h"//!< 签到视图
#import "XHSignListView.h"//!< 签到列表视图
#import "XHAllSelectView.h"//!< 全选视图
#define SIGN_TITLE @[@"未签到",@"已签到",@"请假"]
@interface XHDayRollCallViewController ()<XHCalendarViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,XHAllSelectViewDelegate>
{

    NSInteger _tag;
    NSInteger _selectNumber;
    NSString *_dateStr;
    NSInteger _number;
}
@property(nonatomic,strong)XHClassSignView *classSignView;
@property(nonatomic,strong)XHSignListView *signListView;
@property(nonatomic,strong)BaseCollectionView *collectionView;
@property(nonatomic,strong)XHAllSelectView *selectAllView;//!< 全选视图
@property(nonatomic,strong)NSMutableArray *noSignArry;//!< 未签到学生数组
@property(nonatomic,strong)NSMutableArray *signArry;//!< 签到学生数组
@property(nonatomic,strong)NSMutableArray *otherArry;//!< 请假学生数组
@property(nonatomic,strong)NSMutableArray *selectArry;//!< 已选学生数组
@property(nonatomic,copy)NSMutableString *mutableStr;
@property(nonatomic,strong)XHCalendarView *calendarView;//!< 日历显示

@end

@implementation XHDayRollCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"日常点名"];
    [self setItemContentType:NavigationIconype withItemType:NavigationItemRightype withIconName:@"ico_date" withTitle:nil];
    _number=2;
    _dateStr=[NSDate getDateStrWithDateFormatter:YY_DEFAULT_TIME_FORM Date:[NSDate date]];
    [self.classSignView resetFrame:CGRectMake(15, self.navigationView.bottom+15, SCREEN_WIDTH-30, 80)];
    [self.view addSubview:self.classSignView];
    [self.signListView resetFrame:CGRectMake(0, self.classSignView.bottom, SCREEN_WIDTH, 40)];
    [self.signListView.signControlArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ParentControl *control=(ParentControl *)obj;
        _tag=1;
        [control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self.view addSubview:self.signListView];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [self.collectionView beginRefreshing];
    
    [self.collectionView setTipType:TipTitleAndTipImage withTipTitle:@"同学们都去偷懒喽" withTipImage:@"img_bad"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHead) name:@"noticeName" object:nil];
    
}
#pragma mark- 刷新表数据
-(void)refreshHead
{
    [[XHUserInfo sharedUserInfo] getClassList:^(BOOL isOK, NSMutableArray *classListArry) {
        if (isOK) {
            XHClassListModel *model=[XHUserInfo sharedUserInfo].classListArry[_number];
            [self.netWorkConfig setObject:_dateStr forKey:@"time"];
            [self.netWorkConfig setObject:model.clazzId forKey:@"clazzId"];
            [self.netWorkConfig postWithUrl:@"zzjt-app-api_attendanceSheet001" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject)
                {
                    NSDictionary *objectDic=[object objectItemKey:@"object"];
                    NSDictionary *propValueDic=[objectDic objectItemKey:@"propValue"];
                    NSArray *arr=[propValueDic objectItemKey:@"attendanceSheetList"];
                    [self.noSignArry removeAllObjects];
                    [self.signArry removeAllObjects];
                    [self.otherArry removeAllObjects];
                    for (NSDictionary *dic in arr)
                    {
                        NSDictionary *Dic=[dic objectItemKey:@"propValue"];
                        XHDayRollCallModel *model=[[XHDayRollCallModel alloc] initWithDic:Dic];
                        switch (model.modelType)
                        {
                            case DayRollCallNOSignType:
                            {
                                [self.noSignArry addObject:model];
                            }
                                break;
                            case DayRollCallSignType:
                            {
                                [self.signArry addObject:model];
                            }
                                break;
                            case DayRollCallOtherType:
                            {
                                [self.otherArry addObject:model];
                            }
                                break;
                        }
                    }
                    [self.classSignView refreshClassView:model propValueDic:propValueDic];
                    [self getDataArry];
                    
                }
                [_collectionView refreshReloadData];
            } error:^(NSError *error) {
                [_collectionView refreshReloadData];
            }];
        }
        else
        {
            [_collectionView refreshReloadData];
        }
    }];
    
}
#pragma mark- 更新数据源
-(void)getDataArry
{
    
    if (_tag==1) {
        [self.dataArray setArray:self.noSignArry];
    }
    if (_tag==2) {
        [self.dataArray setArray:self.signArry];
    }
    if (_tag==3) {
        [self.dataArray setArray:self.otherArry];
    }
    [self defaultImagView];
    [self.signListView setItemObjectArry:self.dataArray];
    [_selectArry removeAllObjects];
    _selectNumber=0;
    for (int i=0; i<self.dataArray.count; i++) {
        XHDayRollCallModel *model=self.dataArray[i];
        model.IfSelect=NO;
        [self.dataArray replaceObjectAtIndex:i withObject:model];
    }
    [self.selectAllView selectNumber:_selectNumber withDataArry:self.dataArray];
    [self getSelectAllView];
}

#pragma mark- 签到列表按钮方法
-(void)btnClick:(ParentControl *)control
{
    ParentControl *lastBtn=[self.signListView viewWithTag:_tag];
    [lastBtn setLabelTextColor:RGB(102, 102, 102) withNumberIndex:0];
    [lastBtn setLabelBackgroundColor:[UIColor clearColor] withNumberIndex:1];
    
    [control setLabelTextColor:MainColor withNumberIndex:0];
    [control setLabelBackgroundColor:MainColor withNumberIndex:1];
    
    _tag=control.tag;
    [self getDataArry];
    [_collectionView refreshReloadData];
    
}
#pragma mark- 是否显示全选视图
-(void)getSelectAllView
{
    if (_tag==1) {
        self.collectionView.frame=CGRectMake(0, self.navigationView.bottom+175, SCREEN_WIDTH,SCREEN_HEIGHT-(self.navigationView.bottom+175)-50);
    }
    else if (_tag==2)
    {
        self.collectionView.frame=CGRectMake(0, self.navigationView.bottom+175, SCREEN_WIDTH,SCREEN_HEIGHT-(self.navigationView.bottom+175));
    }
    else
    {
        self.collectionView.frame=CGRectMake(0, self.navigationView.bottom+175, SCREEN_WIDTH,SCREEN_HEIGHT-(self.navigationView.bottom+175));
    }
    if ([self.dataArray count]&&_tag==1&&[NSDate isSameDay:[NSDate getDateWithDateStr:_dateStr formatter:YY_DEFAULT_TIME_FORM] twoDate:[NSDate getDate:[NSDate date] formatter:YY_DEFAULT_TIME_FORM]])
    {
        [self.view addSubview:self.selectAllView];
    }
    else
    {
        [self.selectAllView  removeFromSuperview];
    }
}

#pragma mark- 点击显示日历按钮
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    [self.calendarView show];
}
#pragma mark- delegate

#pragma mark- calendarDelegate
-(void)getCalendarDateStr:(NSString *)dateStr
{
    if (dateStr)
    {
        _dateStr=dateStr;
        [_collectionView beginRefreshing];
    }
}
#pragma mark- allSelectViewDelegate
-(void)getSelectControl:(ParentControl *)control
{
    if (control.tag==50)
    {
        control.selected=!control.selected;
        if (control.selected==YES)
        {
            [control setImageViewName:@"dot_all" withNumberIndex:0];
            _selectNumber=self.dataArray.count;
            for (int i=0; i<self.dataArray.count; i++)
            {
                XHDayRollCallModel *model=self.dataArray[i];
                model.IfSelect=YES;
                [self.dataArray replaceObjectAtIndex:i withObject:model];
            }
            [self.selectArry setArray:self.dataArray];
        }
        else
        {
            _selectNumber=0;
            [self.selectArry removeAllObjects];
            [control setImageViewName:@"dot_no_all" withNumberIndex:0];
            for (int i=0; i<self.dataArray.count; i++) {
                XHDayRollCallModel *model=self.dataArray[i];
                model.IfSelect=NO;
                [self.dataArray replaceObjectAtIndex:i withObject:model];
            }
        }
        [self.selectAllView selectNumber:_selectNumber withDataArry:self.dataArray];
        [self.collectionView refreshReloadData];
    }
    else
    {
        if (_selectNumber!=0)
        {
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].schoolId forKey:@"schoolId"];
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
            [self.mutableStr setString:@""];
            for (XHDayRollCallModel *model in self.selectArry) {
                [self.mutableStr appendFormat:@"%@,",model.ID];
            }
            [self.netWorkConfig setObject:self.mutableStr forKey:@"studentBaseIds"];
            [self.netWorkConfig postWithUrl:control.tag==52?@"zzjt-app-api_bizInfo006":@"zzjt-app-api_attendanceSheet002" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject)
                {
                    [XHShowHUD hideHud];
                    ParentControl *lastBtn=[self.view viewWithTag:_tag];
                    [lastBtn setLabelTextColor:RGB(102, 102, 102) withNumberIndex:0];
                    [lastBtn setLabelBackgroundColor:[UIColor clearColor] withNumberIndex:1];
                    
                    [control setLabelTextColor:MainColor withNumberIndex:0];
                    [control setLabelBackgroundColor:MainColor withNumberIndex:1];
                    _tag=control.tag==52?3:2;
                }
                [self.collectionView beginRefreshing];
            } error:^(NSError *error) {
                [self.collectionView beginRefreshing];
            }];
        }
    }
}
#pragma mark- collectionDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [self.collectionView tipViewWithArray:self.dataArray];
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHDayRollCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    [cell setItemObject:self.dataArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHDayRollCollectionViewCell *cell=[_collectionView cellForItemAtIndexPath:indexPath];
    XHDayRollCallModel *model=self.dataArray[indexPath.row];
    if (_tag==1)
    {
       model.IfSelect=!model.IfSelect;
        [cell setItemObject:model];
        if (model.IfSelect)
        {
            _selectNumber++;
            [self.selectArry addObject:model];
        }
        else
        {
            _selectNumber--;
            [self.selectArry removeObject:model];
        }
       [self.selectAllView selectNumber:_selectNumber withDataArry:self.dataArray];
    }
    if (_tag==2) {
        XHDayRollCallDetailViewController *detail=[[XHDayRollCallDetailViewController alloc] init];
        detail.model=self.dataArray[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}
#pragma mark- 数据源视图
-(BaseCollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/5.0-10, SCREEN_WIDTH/5.0+SCREEN_WIDTH/10.0-5);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _collectionView = [[BaseCollectionView alloc]initWithFrame:CGRectMake(0, self.navigationView.bottom+175, SCREEN_WIDTH,SCREEN_HEIGHT-(self.navigationView.bottom+175)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XHDayRollCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
    
}
#pragma mark- 日历视图
-(XHCalendarView *)calendarView
{
    if (_calendarView==nil)
    {
        _calendarView=[[XHCalendarView alloc] initWithDelegate:self];
    }
    return _calendarView;
}
#pragma mark- 班级视图
-(XHClassSignView *)classSignView
{
    if (_classSignView==nil) {
        _classSignView=[[XHClassSignView alloc] init];
    }
    return _classSignView;
}
#pragma mark- 未签到列表视图
-(XHSignListView *)signListView
{
    if (_signListView==nil) {
        
        _signListView=[[XHSignListView alloc] init];
        
    }
    
    return _signListView;
}
#pragma mark- 全选列表视图
-(XHAllSelectView *)selectAllView
{
    if (_selectAllView==nil) {
        _selectAllView=[[XHAllSelectView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _selectAllView.delegate=self;
        _selectAllView.backgroundColor=[UIColor whiteColor];
    }
    return _selectAllView;
}
-(NSMutableArray *)noSignArry
{
    if (_noSignArry==nil) {
        _noSignArry=[NSMutableArray array];
    }
    return _noSignArry;
}
-(NSMutableArray *)signArry
{
    if (_signArry==nil) {
        _signArry=[NSMutableArray array];
    }
    return _signArry;
}
-(NSMutableArray *)otherArry
{
    if (_otherArry==nil) {
        _otherArry=[NSMutableArray array];
    }
    return _otherArry;
}
-(NSMutableArray *)selectArry
{
    if (_selectArry==nil) {
        _selectArry=[NSMutableArray array];
    }
    return _selectArry;
}
-(NSMutableString *)mutableStr
{
    if (_mutableStr==nil) {
        _mutableStr=[[NSMutableString alloc] init];
    }
    return _mutableStr;
}
-(void)defaultImagView
{
    if (_tag==11)
    {
        [self.collectionView setTipType:TipTitleAndTipImage withTipTitle:@"同学们都去偷懒喽" withTipImage:@"img_bad"];
    }
    else
    {
        [self.collectionView setTipType:TipTitleAndTipImage withTipTitle:@"同学们都很勤奋哦" withTipImage:@"img_good"];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
