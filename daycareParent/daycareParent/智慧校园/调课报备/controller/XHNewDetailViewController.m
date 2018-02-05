//
//  XHNewDetailViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/17.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewDetailViewController.h"
#import "BaseTableView.h"
#import "XHNewTableViewCell.h"
#import "XHNewHeardTableViewCell.h"
#import "XHHistoryDetailTableViewCell.h"
#import "XHHistoryHeadTableViewCell.h"
#import "XHApplyTableViewCell.h"
#import "XHApproverTableViewCell.h"
#import "XHHistoryApproverDetailTableViewCell.h"
#import "XHApproveModel.h"
#import "XHApproveDetailModel.h"
#define TITLE  @[@"李某某的课程",@"类型",@"原任课教师",@"课程名称",@"委任教师",@"委任课程",@"上课时间",@"上课班级",@"请假时长",@"审批人"]
@interface XHNewDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView *_tableView;
    NSInteger _tag;
}
@property(nonatomic,strong)UIImageView *imageV;
@end

@implementation XHNewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionHeaderHeight=0;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHHistoryDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"headcell"];
    [_tableView registerClass:[XHHistoryHeadTableViewCell class] forCellReuseIdentifier:@"historyHeadCell"];
     [_tableView registerClass:[XHApplyTableViewCell class] forCellReuseIdentifier:@"applyCell"];
     [_tableView registerClass:[XHApproverTableViewCell class] forCellReuseIdentifier:@"approverCell"];
     [_tableView registerClass:[XHHistoryApproverDetailTableViewCell class] forCellReuseIdentifier:@"historyApproverCell"];
    [self.view addSubview:_tableView];
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [_tableView beginRefreshing];
    [_tableView setTipType:TipTitleAndTipImage withTipTitle:nil withTipImage:@"ico-no-data"];
    [_tableView addSubview:self.imageV];
    //去掉留白方法
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)refreshHead
{
    [self.netWorkConfig setObject:self.model.ID forKey:@"id"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_bizInfo005" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject)
            {
                if (self.isRefresh) {
                  self.isRefresh(YES);
                }
                NSDictionary *dic=[object objectItemKey:@"object"];
                NSDictionary *propValueDic=[dic objectItemKey:@"propValue"];
                XHApproveDetailModel *model=[[XHApproveDetailModel alloc] initWithDic:propValueDic];
                [self.dataArray addObject:model];
            }
            [_tableView refreshReloadData];
    } error:^(NSError *error) {
        [_tableView refreshReloadData];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    else
    {
       return 0;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [_tableView tableTipViewWithArray:self.dataArray];
    switch (section) {
        case 0:
             return 10;
            break;
            
        default:
            return 1;
            break;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section==1) {
        if ([self.model.isMe integerValue]==1&&self.Tag==10) {
            return 80;
        }
        else
        {
            return 145;
        }
    }
    else
    {
        if (indexPath.row==0) {
            return 60;
        }
        if (indexPath.row==9) {
            return 110;
        }
        else
        {
            return 50;
        }
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHApproveDetailModel *model=self.dataArray.firstObject;
    switch ([model.isStatus integerValue]) {
        case 0:
            
        {
            self.imageV.image=[UIImage imageNamed:@"zhang_daishenpi"];
        }
            break;
            
        case 1:
        {
            self.imageV.image=[UIImage imageNamed:@"zhang_tongyi"];
        }
            break;
            case 2:
        {
            self.imageV.image=[UIImage imageNamed:@"zhang_jujue"];
        }
            break;
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            XHHistoryHeadTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"historyHeadCell" forIndexPath:indexPath];
            [cell.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.headPic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
            if ([model.bizType integerValue]==1) {
                cell.titleLabel.text=[NSString stringWithFormat:@"%@的调课",model.teacherName];
            }
            if ([model.bizType integerValue]==2)
            {
                cell.titleLabel.text=[NSString stringWithFormat:@"%@的代课",model.teacherName];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==9) {
            XHHistoryDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headcell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.approveLabel.text=TITLE[indexPath.row];
            cell.nameLabel.text=model.auditor;
            [cell.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.auditorHeadPic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.titleLabel.text=TITLE[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            switch (indexPath.row) {
                case 1:
                {
                     cell.selectLabel.hidden=YES;
                    switch ([model.bizType integerValue]==1) {
                        case 1:
                        {
                            cell.titleLabel.text=[NSString stringWithFormat:@"类型：调课"];
                        }
                            break;
                            
                        default:
                        {
                            cell.titleLabel.text=[NSString stringWithFormat:@"类型：代课"];
                        }
                            break;
                    }
                }
                    break;
                    
                default:
                {
                    cell.selectLabel.hidden=NO;
                    switch (indexPath.row) {
                        case 2:
                        {
                            cell.selectLabel.text=model.formerTeacherName;
                        }
                            break;
                            
                        case 3:
                        {
                            cell.selectLabel.text=model.formerSubjectName;
                        }
                            break;
                        case 4:
                        {
                            cell.selectLabel.text=model.appointedTeacherName;
                        }
                            break;
                        case 5:
                        {
                            cell.selectLabel.text=model.appointedSubjectName;
                        }
                            break;
                        case 6:
                        {
                            cell.selectLabel.text=model.beginTime;
                        }
                            break;
                        case 7:
                        {
                            cell.selectLabel.text=model.clazzName;
                        }
                            break;
                        case 8:
                        {
                            cell.selectLabel.text=[NSString stringWithFormat:@"%@节课程",model.subjectNum];
                        }
                            break;
                    }
                }
                    break;
            }
            return cell;
        }
    }
    else {
        if (self.Tag==11)
        {
#pragma mark-------------审批人显示cell--------------
            XHHistoryApproverDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"historyApproverCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (int i=0; i<2; i++) {
                UIImageView *selectImage=[cell.contentView viewWithTag:100+i];
                UIButton *headBtn=[cell.contentView viewWithTag:200+i];
                XHBaseLabel *nameLabel=[cell.contentView viewWithTag:300+i];
                XHBaseLabel *dateLabel=[cell.contentView viewWithTag:400+i];
                XHBaseLabel *applyLabel=[cell.contentView viewWithTag:500+i];
                if (i==1) {
                    [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.auditorHeadPic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
                    nameLabel.text=model.auditor;
                    dateLabel.text=[NSDate dateStr:model.updateTime FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:YY_DEFAULT_TIME_FORM];
                    if ([model.isStatus integerValue]==0) {
                        applyLabel.text=@"未审批";
                        selectImage.image=[UIImage imageNamed:@"ico_right"];
                    }
                     if ([model.isStatus integerValue]==1) {
                       applyLabel.text=@"已同意";
                      selectImage.image=[UIImage imageNamed:@"ico_right"];
                    }
                    if ([model.isStatus integerValue]==2) {
                        applyLabel.text=@"已拒绝";
                        selectImage.image=[UIImage imageNamed:@"ico_wrong"];
                    }
                }
                else
                {
                    nameLabel.text=model.teacherName;
                    applyLabel.text=@"发起申请";
                    dateLabel.text=[NSDate dateStr:model.createTime FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:YY_DEFAULT_TIME_FORM];
                     selectImage.image=[UIImage imageNamed:@"ico_right"];
                    [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.headPic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
                }
                
            }
            
            return cell;
        }
        else
        {
            if ([self.model.isMe integerValue]==1)
            {
#pragma mark--------------发起人显示cell--------------
                XHApplyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"applyCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.nameLabel.text=model.formerTeacherName;
                cell.applyLabel.text=@"发起申请";
                cell.dateLabel.text=[NSDate dateStr:model.createTime FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:YY_DEFAULT_TIME_FORM];
                cell.selectImageV.image=[UIImage imageNamed:@"ico_right"];
                return cell;
            }
            else
            {
#pragma mark-------------审批人显示cell--------------
                XHApproverTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"approverCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.nameLabel.text=model.formerTeacherName;
                cell.applyLabel.text=@"发起申请";
                cell.dateLabel.text=[NSDate dateStr:model.createTime FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:YY_DEFAULT_TIME_FORM];
                 cell.selectImageV.image=[UIImage imageNamed:@"ico_right"];
                for (int i=0; i<2; i++) {
                    XHBaseBtn *btn=[cell.contentView viewWithTag:10+i];
                    [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                return cell;
            }
        }
    }

}
-(void)selectBtnClick:(XHBaseBtn *)btn

{
    NSLog(@"-----%zd-----%@",btn.tag,btn.tag==10?@"拒绝":@"同意");
    XHApproveDetailModel *model=self.dataArray.firstObject;
    [self.netWorkConfig setObject:model.ID forKey:@"id"];
    switch (btn.tag) {
        case 10:
        {
            [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",2] forKey:@"agree"];
        }
            break;
        case 11:
        {
            [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",1] forKey:@"agree"];
        }
            break;
    }
    
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_bizInfo004" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            
            //跳转到已审列表
            if (self.isRefresh) {
                self.isRefresh(YES);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } error:^(NSError *error) {
        
    }];
}
-(UIImageView *)imageV
{
    if (_imageV==nil) {
        _imageV=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 30, 60, 60)];
        _imageV.layer.cornerRadius=30;
        _imageV.layer.masksToBounds=YES;
        //_imageV.backgroundColor=[UIColor redColor];
    }
    return _imageV;
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
