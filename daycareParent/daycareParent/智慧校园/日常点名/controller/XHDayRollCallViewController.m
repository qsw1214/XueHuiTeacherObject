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
#define SIGN_TITLE @[@"未签到",@"已签到",@"请假"]
@interface XHDayRollCallViewController ()<XHCalendarViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger _tag;
    NSInteger _selectNumber;
    NSString *_dateStr;
    NSInteger _number;
}
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)BaseButtonControl *rightBtn;
@property(nonatomic,strong)UIView *signView;
@property(nonatomic,strong)BaseCollectionView *collectionView;
@property(nonatomic,strong)UIView *selectAllView;//!< 处理未签到视图
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
    _number=0;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.rightBtn];
    [self.view addSubview:self.signView];
    [self.view addSubview:self.collectionView];
     [self.collectionView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [self.collectionView beginRefreshing];
    [self.collectionView setTipType:TipTitleAndTipImage withTipTitle:@"同学们都去偷懒喽" withTipImage:@"img_bad"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHead) name:@"noticeName" object:nil];
    
}
#pragma mark-------------刷新collectionView头视图--------------
-(void)refreshHead
{
    [self refreshAll];
}

#pragma mark-----------选择日期后回调代理方法----------
-(void)getCalendarDateStr:(NSString *)dateStr
{
    if (dateStr)
    {
        NSString *str=[dateStr componentsSeparatedByString:@"年"][1];
        [self.rightBtn setText:str withNumberType:0 withAllType:NO];
        _dateStr=[NSDate dateStr:dateStr FromFormatter:@"yyyy年MM月dd日" ToFormatter:YY_DEFAULT_TIME_FORM];
        [_collectionView beginRefreshing];
    }
    
}
#pragma mark-------------选择班级按钮--------------
-(void)classBtnMethod
{
    [UIAlertController alertClassListWith:self indexBlock:^(NSInteger index, id object) {
        _number=index;
        [self.collectionView beginRefreshing];
    }];
}

#pragma mark-------------未签到列表按钮方法--------------
-(void)btnClick:(BaseButtonControl *)btn
{

    BaseButtonControl *lastBtn=[self.view viewWithTag:_tag];
    [lastBtn setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
    [lastBtn setTextBackGroundColor:[UIColor clearColor] withTpe:1 withAllType:NO];
    [btn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
    [btn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
    _tag=btn.tag;
    [self getDataArry];
    [_collectionView refreshReloadData];
    
}
#pragma mark-------------刷新全选视图数据--------------
-(void)getSelectAllView
{
    if (_tag==10) {
        self.collectionView.frame=CGRectMake(0, 184, SCREEN_WIDTH,SCREEN_HEIGHT-234);
    }
    else if (_tag==11)
    {
        self.collectionView.frame=CGRectMake(0, 184, SCREEN_WIDTH,SCREEN_HEIGHT-184);
    }
    else
    {
        self.collectionView.frame=CGRectMake(0, 184, SCREEN_WIDTH,SCREEN_HEIGHT-184);
    }
    if ([self.dataArray count]&&_tag==10&&[NSDate isSameDay:[NSDate getDateWithDateStr:_dateStr formatter:YY_DEFAULT_TIME_FORM] twoDate:[NSDate getDate:[NSDate date] formatter:YY_DEFAULT_TIME_FORM]])
    {
        [self.view addSubview:self.selectAllView];
    }
    else
    {
        [self.selectAllView  removeFromSuperview];
    }
}
#pragma mark-------------刷新表数据--------------
-(void)refreshAll
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
                     [self refreshClassView:model propValueDic:propValueDic];
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
#pragma mark  ---------------刷新出勤率列表视图数据---------------
-(void)refreshClassView:(XHClassListModel *)model propValueDic:(NSDictionary *)propValueDic
{
    for (int i=0; i<4; i++)
    {
        
        XHBaseBtn *classBtn=[self.view viewWithTag:100+i];
        switch (i) {
            case 0:
            {
                [classBtn setTitle:[NSString stringWithFormat:@"%@>",model.clazz] forState:UIControlStateNormal];
            }
                break;
                
            case 1:
            {
                [classBtn setTitle:[propValueDic objectItemKey:@"sum"] forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [classBtn setTitle:[propValueDic objectItemKey:@"attendanceCnt"] forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                [classBtn setTitle:[propValueDic objectItemKey:@"pre"] forState:UIControlStateNormal];
            }
                break;
        }
        
    }
}
#pragma mark-------------未签到列表数据刷新--------------
-(void)refreshSignView
{

    for (int i=0; i<3; i++) {
        
        BaseButtonControl *signBtn=[self.view viewWithTag:10+i];
        switch (i) {
            case 0:
            {
                [signBtn setText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[i],self.noSignArry.count] withNumberType:0 withAllType:NO];
            }
                break;
            case 1:
            {
                [signBtn setText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[i],self.signArry.count] withNumberType:0 withAllType:NO];
            }
                break;
            case 2:
            {
                [signBtn setText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[i],self.otherArry.count] withNumberType:0 withAllType:NO];
            }
                break;
                
        }
        
    }
}
#pragma mark-------------全选视图列表数据刷新--------------
-(void)refreshSelectAll
{
    BaseButtonControl *selectbtn=[self.view viewWithTag:50];
    BaseButtonControl *btn=[self.view viewWithTag:51];
    [btn setText:[NSString stringWithFormat:@"已选%zd人",_selectNumber] withNumberType:0 withAllType:NO];
    if (_selectNumber==self.dataArray.count)
    {
        [selectbtn setImage:@"icoyixuan" withNumberType:0 withAllType:NO];
    }
    else
    {
        selectbtn.selected=NO;
        [selectbtn setImage:@"icoweixuan" withNumberType:0 withAllType:NO];
    }
}
#pragma mark-------------全选视图列表按钮方法--------------
-(void)selectBtnMethod:(BaseButtonControl *)btn
{
    if (btn.tag==50)
    {
        btn.selected=!btn.selected;
        if (btn.selected==YES)
        {
            [btn setImage:@"icoyixuan" withNumberType:0 withAllType:NO];
            _selectNumber=self.dataArray.count;
            [self.selectArry setArray:self.dataArray];
            for (int i=0; i<self.dataArray.count; i++) {
                XHDayRollCallModel *model=self.dataArray[i];
                model.IfSelect=YES;
                [self.dataArray replaceObjectAtIndex:i withObject:model];
            }
        }
        else
        {
            _selectNumber=0;
            [self.selectArry removeAllObjects];
            [btn setImage:@"icoweixuan" withNumberType:0 withAllType:NO];
            for (int i=0; i<self.dataArray.count; i++) {
                XHDayRollCallModel *model=self.dataArray[i];
                model.IfSelect=NO;
                [self.dataArray replaceObjectAtIndex:i withObject:model];
            }
        }
        [self refreshSelectAll];
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
            [self.netWorkConfig postWithUrl:btn.tag==52?@"zzjt-app-api_bizInfo006":@"zzjt-app-api_attendanceSheet002" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject)
                {
                    [XHShowHUD hideHud];
                    BaseButtonControl *lastBtn=[self.view viewWithTag:_tag];
                    [lastBtn setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
                    [lastBtn setTextBackGroundColor:[UIColor clearColor] withTpe:1 withAllType:NO];
                    BaseButtonControl *nowBtn=[self.view viewWithTag:btn.tag==52?12:11];
                    [nowBtn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
                    [nowBtn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
                    _tag=btn.tag==52?12:11;
                }
                [self.collectionView beginRefreshing];
            } error:^(NSError *error) {
                [self.collectionView beginRefreshing];
            }];
        }
    }
}
#pragma mark  刷新数据源
-(void)getDataArry
{
    
    if (_tag==10) {
        [self.dataArray setArray:self.noSignArry];
    }
    if (_tag==11) {
        [self.dataArray setArray:self.signArry];
    }
    if (_tag==12) {
       [self.dataArray setArray:self.otherArry];
    }
    [self defaultImagView];
    [self refreshSignView];
    [_selectArry removeAllObjects];
    _selectNumber=0;
    for (int i=0; i<self.dataArray.count; i++) {
        XHDayRollCallModel *model=self.dataArray[i];
        model.IfSelect=NO;
        [self.dataArray replaceObjectAtIndex:i withObject:model];
    }
    [self getSelectAllView];
    [self refreshSelectAll];//!< 恢复未选中状态
}
#pragma mark-------------出勤率视图--------------
-(UIView *)headView
{
    if (_headView==nil) {
        _headView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 70)];
        _headView.backgroundColor=RGB(254, 248, 242);
        [self.view addSubview:_headView];
        NSArray *arry=@[@"班级",@"应到人数",@"实到人数",@"出勤率"];
        for (int i=0; i<4; i++) {
            XHBaseLabel *label=[[XHBaseLabel alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH/4.0, 0, SCREEN_WIDTH/4.0, 40)];
            label.text=arry[i];
            //label.backgroundColor=[UIColor redColor];
            label.textAlignment=NSTextAlignmentCenter;
            [_headView addSubview:label];
            XHBaseBtn *btn=[[XHBaseBtn alloc] initWithFrame:CGRectMake(label.left, label.bottom-5, label.width, label.height-10)];
            btn.tag=100+i;
            btn.layer.cornerRadius=0;
            btn.backgroundColor=[UIColor clearColor];
            //[btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:RGB(63, 163, 63) forState:UIControlStateNormal];
            if (i==0) {
                [btn addTarget:self action:@selector(classBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [_headView addSubview:btn];
        }
        
    }
    return _headView;
}
#pragma mark-------------未签到列表视图--------------
-(UIView *)signView
{
    if (_signView==nil) {
        for (int i=0; i<2; i++) {
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, _headView.bottom+49*i, SCREEN_WIDTH, 1)];
            label.backgroundColor=RGB(224, 224, 224);
            [self.view addSubview:label];
        }
        for (int i=0; i<3; i++) {
            BaseButtonControl *btn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH/3.0, _headView.bottom, SCREEN_WIDTH/3.0, 50)];
            [btn setNumberLabel:2];
            [btn setText:SIGN_TITLE[i] withNumberType:0 withAllType:NO];
            [btn setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
            [btn setTitleEdgeFrame:CGRectMake(0, 0, btn.width, btn.height-2) withNumberType:0 withAllType:NO];
            [btn setTitleEdgeFrame:CGRectMake(btn.width*0.15, btn.height-2, btn.width*0.7, 2) withNumberType:1 withAllType:NO];
            btn.tag=10+i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                [btn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
                [btn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
                _tag=10;
            }
            [self.view addSubview:btn];
            
        }
    }
    
    return _signView;
}
-(BaseButtonControl *)rightBtn
{
    if (_rightBtn==nil) {
        _rightBtn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110, 20, 100, 44)];
        //_rightBtn.backgroundColor=[UIColor yellowColor];
        [_rightBtn setNumberImageView:1];
        [_rightBtn setNumberLabel:1];
        [_rightBtn setImageEdgeFrame:CGRectMake(5, 15, 16, 16) withNumberType:0 withAllType:NO];
        [_rightBtn setImage:@"ico_date" withNumberType:0 withAllType:NO];
        [_rightBtn setTitleEdgeFrame:CGRectMake(25, 0, 70, 45) withNumberType:0 withAllType:NO];
        [_rightBtn setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_rightBtn setFont:FontLevel3 withNumberType:0 withAllType:NO];
        //[_rightBtn setTextBackGroundColor:[UIColor redColor] withTpe:0 withAllType:NO];
        [_rightBtn setText:[NSString dateWithDateFormatter:@"MM月dd日" Date:[NSDate date]] withNumberType:0 withAllType:NO];
        _dateStr=[NSDate getDateStrWithDateFormatter:YY_DEFAULT_TIME_FORM Date:[NSDate date]];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark-------------点击显示日历按钮--------------
-(void)rightBtnClick
{
    [self.calendarView show];
}
#pragma mark-------------全选列表视图--------------
-(UIView *)selectAllView
{
    if (_selectAllView==nil) {
        _selectAllView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _selectAllView.backgroundColor=RGB(239, 239, 239);
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        label.backgroundColor=RGB(224, 224, 224);
        [_selectAllView addSubview:label];
        for (int i=0; i<4; i++) {
            BaseButtonControl *btn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH/4.0, 0, SCREEN_WIDTH/4.0, 50)];
            btn.tag=50+i;
            [btn addTarget:self action:@selector(selectBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [btn setNumberLabel:1];
            switch (i) {
                case 0:
                {
                    [btn setNumberImageView:1];
                    [btn setImageEdgeFrame:CGRectMake(10, 15, 20, 20) withNumberType:0 withAllType:NO];
                    [btn setImage:@"icoweixuan" withNumberType:0 withAllType:NO];
                    [btn setTitleEdgeFrame:CGRectMake(40, 0, btn.width-40, 50) withNumberType:0 withAllType:NO];
                    [btn setText:@"全选" withNumberType:0 withAllType:NO];
                }
                    break;
                case 1:
                {
                    [btn setTitleEdgeFrame:CGRectMake(0, 0, btn.width, 50) withNumberType:0 withAllType:NO];
                    [btn setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
                    [btn setText:@"已选0人" withNumberType:0 withAllType:NO];
                }
                    break;
                case 2:
                {
                    [btn setTitleEdgeFrame:CGRectMake(0, 0, btn.width, 50) withNumberType:0 withAllType:NO];
                    [btn setText:@"请假" withNumberType:0 withAllType:NO];
                    [btn setTextBackGroundColor:RGB(236, 63, 27) withTpe:0 withAllType:NO];
                    [btn setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
                    [btn setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
                }
                    break;
                case 3:
                {
                    [btn setTitleEdgeFrame:CGRectMake(0, 0, btn.width, 50) withNumberType:0 withAllType:NO];
                    [btn setText:@"签到" withNumberType:0 withAllType:NO];
                    [btn setTextBackGroundColor:RGB(63, 163, 63) withTpe:0 withAllType:NO];
                    [btn setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
                    [btn setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
                }
                    break;
            }
            [_selectAllView addSubview:btn];
        }
    }
    return _selectAllView;
}
-(BaseCollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/5.0-10, SCREEN_WIDTH/5.0+SCREEN_WIDTH/10.0-5);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _collectionView = [[BaseCollectionView alloc]initWithFrame:CGRectMake(0, 184, SCREEN_WIDTH,SCREEN_HEIGHT-234) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XHDayRollCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
    
}
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
    if (_tag==10)
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
        [self refreshSelectAll];
    }
    if (_tag==12) {
        XHDayRollCallDetailViewController *detail=[[XHDayRollCallDetailViewController alloc] init];
        detail.model=self.dataArray[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}
-(XHCalendarView *)calendarView
{
    if (_calendarView==nil) {
        
        _calendarView=[[XHCalendarView alloc] initWithDelegate:self];
    }
    return _calendarView;
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
