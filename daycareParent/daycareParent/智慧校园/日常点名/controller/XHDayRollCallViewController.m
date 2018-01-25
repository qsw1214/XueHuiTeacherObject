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
#define SIGN_TITLE @[@"未签到",@"已签到",@"请假"]
@interface XHDayRollCallViewController ()<XHCustomDatePickerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger _tag;
    NSInteger _selectNumber;
}
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)BaseButtonControl *rightBtn;
@property(nonatomic,strong)UIView *signView;
@property(nonatomic,strong)BaseCollectionView *collectionView;
@property(nonatomic,strong)UIView *selectAllView;//!< 处理未签到视图

@end

@implementation XHDayRollCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"日常点名"];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.rightBtn];
    [self.view addSubview:self.signView];
    [self.view addSubview:self.collectionView];
     [self.collectionView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [self.collectionView beginRefreshing];
    [self.collectionView setTipType:TipTitleAndTipImage withTipTitle:nil withTipImage:@"ico-no-data"];
}
#pragma mark-------------刷新collectionView头视图--------------
-(void)refreshHead
{
    [self refreshAll];
    [self getModel];
    [self.collectionView refreshReloadData];
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
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
#pragma mark-------------出勤率视图--------------
-(UIView *)headView
{
    if (_headView==nil) {
        _headView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 70)];
        _headView.backgroundColor=RGB(254, 248, 242);
        [self.view addSubview:_headView];
        NSArray *arry=@[@"班级",@"应到人数",@"实到人数",@"出勤率"];
        NSArray *arr=@[@"三二班>",@"26",@"24",@"92%"];
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
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:RGB(63, 163, 63) forState:UIControlStateNormal];
            if (i==0) {
                  [btn addTarget:self action:@selector(classBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            }
         
            [_headView addSubview:btn];
        }
        
    }
    return _headView;
}
#pragma mark-------------点击显示日历按钮--------------
-(void)rightBtnClick
{
    self.datePickerView.delegate=self;
    self.datePickerView.modelyTpe=XHCustomDatePickerViewModelMouthAndDayType;
    [self.view addSubview:self.datePickerView];
}

#pragma mark-----------选择日期后回调代理方法----------
-(void)getDateStr:(NSString *)dateStr
{
    if (dateStr)
    {
        [self.rightBtn setText:dateStr withNumberType:0 withAllType:NO];
    }
    
}
#pragma mark-------------选择班级按钮--------------
-(void)classBtnMethod
{
    NSLog(@"选择班级按钮");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择班级" preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<4; i++) {
        
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%zd",i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //刷新数据
            [self refreshAll];
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
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
        NSArray  *arry=@[@"未签到",@"已签到",@"请假"];
        for (int i=0; i<3; i++) {
            BaseButtonControl *btn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH/3.0, _headView.bottom, SCREEN_WIDTH/3.0, 50)];
            [btn setNumberLabel:2];
            [btn setText:[NSString stringWithFormat:@"%@（%zd)",arry[i],i] withNumberType:0 withAllType:NO];
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
#pragma mark-------------签到按钮方法--------------
-(void)btnClick:(BaseButtonControl *)btn
{
    _selectNumber=0;
    [self refreshSelectAll];
#pragma mark-------------点击按钮前状态改变--------------
    BaseButtonControl *lastBtn=[self.view viewWithTag:_tag];
    [lastBtn setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
    [lastBtn setTextBackGroundColor:[UIColor clearColor] withTpe:1 withAllType:NO];
#pragma mark-------------现在点击按钮状态改变--------------
    [btn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
    [btn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
    _tag=btn.tag;
    [self getModel];
    [self.collectionView refreshReloadData];
    
}
#pragma mark-------------建立数据--------------
-(void)getModel
{
    [self.dataArray removeAllObjects];
    for (int i=0; i<25; i++) {
        XHDayRollCallModel *model=[[XHDayRollCallModel alloc] init];
        model.reasonStr=@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=123&step_word=&hs=0&pn=4&spn=0&di=196973662930&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=2&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=-1&cs=3187992390%2C4014544366&os=2200788253%2C1058291308&simid=4136928266%2C611208284&adpicid=0&lpn=0&ln=1895&fr=&fmq=1516762023736_R&fm=detail&ic=0&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fw%3D268%2Fsign%3D150ca7320ef3d7ca0cf63870ca1fbe3c%2F11385343fbf2b2111e3d6542c88065380cd78eaf.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fkwthj_z%26e3Bkwt17_z%26e3Bv54AzdH3FetjoAzdH3Fd0d8c_z%26e3Bip4%3Fu654I1%3Ddabd9cc&gsm=0&rpstart=0&rpn";
        model.imagPic=@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=123&step_word=&hs=0&pn=4&spn=0&di=196973662930&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=2&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=-1&cs=3187992390%2C4014544366&os=2200788253%2C1058291308&simid=4136928266%2C611208284&adpicid=0&lpn=0&ln=1895&fr=&fmq=1516762023736_R&fm=detail&ic=0&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fw%3D268%2Fsign%3D150ca7320ef3d7ca0cf63870ca1fbe3c%2F11385343fbf2b2111e3d6542c88065380cd78eaf.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fkwthj_z%26e3Bkwt17_z%26e3Bv54AzdH3FetjoAzdH3Fd0d8c_z%26e3Bip4%3Fu654I1%3Ddabd9cc&gsm=0&rpstart=0&rpnum=0";
        if (_tag==10) {
            model.modelType=DayRollCallNOSignType;
            self.collectionView.frame=CGRectMake(0, 184, SCREEN_WIDTH,SCREEN_HEIGHT-234);
        }
        else if (_tag==11)
        {
            model.modelType=DayRollCallSignType;
            self.collectionView.frame=CGRectMake(0, 184, SCREEN_WIDTH,SCREEN_HEIGHT-184);
        }
        else
        {
            model.modelType=DayRollCallOtherType;
            self.collectionView.frame=CGRectMake(0, 184, SCREEN_WIDTH,SCREEN_HEIGHT-184);
        }
        [self.dataArray addObject:model];
    }
    if ([self.dataArray count]&&_tag==10) {
        [self.view addSubview:self.selectAllView];
    }
    else
    {
        [self.selectAllView  removeFromSuperview];
    }
}
#pragma mark-------------刷新数据--------------
-(void)refreshAll
{
   #pragma mark-------------出勤率列表数据刷新--------------
    for (int i=0; i<4; i++) {

        XHBaseBtn *classBtn=[self.view viewWithTag:100+i];
        [classBtn setTitle:@"111" forState:UIControlStateNormal];
    }
    #pragma mark-------------签到列表数据刷新--------------
    for (int i=0; i<3; i++) {
     
        BaseButtonControl *signBtn=[self.view viewWithTag:10+i];
        [signBtn setText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[i],i+10] withNumberType:0 withAllType:NO];
    }
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
    //cell.backgroundColor=[UIColor redColor];
    [cell setItemObject:self.dataArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHDayRollCollectionViewCell *cell=[_collectionView cellForItemAtIndexPath:indexPath];
    XHDayRollCallModel *model=self.dataArray[indexPath.row];
    if (_tag==10) {
       model.IfSelect=!model.IfSelect;
        [cell setItemObject:model];
        if (model.IfSelect) {
            _selectNumber++;
        }
        else
        {
            _selectNumber--;
        }
        [self refreshSelectAll];
    }
    if (_tag==12) {
        XHDayRollCallDetailViewController *detail=[[XHDayRollCallDetailViewController alloc] init];
        detail.model=self.dataArray[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}
#pragma mark-------------请假、签到列表视图--------------
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
#pragma mark-------------请假、签到已选择数据刷新--------------
-(void)refreshSelectAll
{
     BaseButtonControl *selectbtn=[self.view viewWithTag:50];
    BaseButtonControl *btn=[self.view viewWithTag:51];
    [btn setText:[NSString stringWithFormat:@"已选%zd人",_selectNumber] withNumberType:0 withAllType:NO];
    if (_selectNumber==self.dataArray.count) {
        [selectbtn setImage:@"icoyixuan" withNumberType:0 withAllType:NO];
    }
    else
    {
        selectbtn.selected=NO;
        [selectbtn setImage:@"icoweixuan" withNumberType:0 withAllType:NO];
    }
}
#pragma mark-------------请假，签到，全选按钮方法--------------
-(void)selectBtnMethod:(BaseButtonControl *)btn
{
    
    if (btn.tag==50) {
        btn.selected=!btn.selected;
        if (btn.selected==YES) {
            [btn setImage:@"icoyixuan" withNumberType:0 withAllType:NO];
            _selectNumber=self.dataArray.count;
            for (int i=0; i<self.dataArray.count; i++) {
                XHDayRollCallModel *model=self.dataArray[i];
                model.IfSelect=YES;
                [self.dataArray replaceObjectAtIndex:i withObject:model];
            }
        }
        else
        {
            _selectNumber=0;
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
    #pragma mark-------------刷新请假列表--------------
    if (btn.tag==52&&_selectNumber!=0) {
        _selectNumber=0;
        [self refreshSelectAll];
#pragma mark-------------点击按钮前状态改变--------------
        BaseButtonControl *lastBtn=[self.view viewWithTag:_tag];
        [lastBtn setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [lastBtn setTextBackGroundColor:[UIColor clearColor] withTpe:1 withAllType:NO];
#pragma mark-------------现在点击按钮状态改变--------------
         BaseButtonControl *nowBtn=[self.view viewWithTag:12];
        [nowBtn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
        [nowBtn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
        _tag=12;
        [self getModel];
        [self.collectionView refreshReloadData];
    }
    #pragma mark-------------刷新签到列表--------------
    if (btn.tag==53&&_selectNumber!=0) {
        _selectNumber=0;
        [self refreshSelectAll];
#pragma mark-------------点击按钮前状态改变--------------
        BaseButtonControl *lastBtn=[self.view viewWithTag:_tag];
        [lastBtn setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [lastBtn setTextBackGroundColor:[UIColor clearColor] withTpe:1 withAllType:NO];
#pragma mark-------------现在点击按钮状态改变--------------
        BaseButtonControl *nowBtn=[self.view viewWithTag:11];
        [nowBtn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
        [nowBtn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
        _tag=11;
        [self getModel];
        [self.collectionView refreshReloadData];
    }
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
