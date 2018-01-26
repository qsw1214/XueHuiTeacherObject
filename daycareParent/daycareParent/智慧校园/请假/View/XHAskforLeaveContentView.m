//
//  XHAskforLeaveContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveContentView.h"
#import "XHAskforLeaveArrowCell.h" //选择开始时间、结束时间、选择请假孩子等视图
#import "XHAskforLeaveAddPhotoControl.h" //!< 添加图片
#import "XHAskforLeaveChargeTeacherControl.h" //!< 班主任按钮
#import "XHAskforLeaveSubmitControl.h" //!< 提交按钮
#import "XHDatePickerControl.h" //!< 日期选择器
#import "XHAskforLeavePreviewControl.h" //!< 添加的请假照片预览图
#import "CameraManageViewController.h"  //!< 相机管理类
#import "XHTeacherAddressBookViewController.h"
#import "BaseView.h"
#import "XHLeaveRecordViewController.h"//!< 请假列表


@interface XHAskforLeaveContentView () <BaseTextViewDeletage,XHDatePickerControlDeletage,XHAskforLeavePreviewControlDeletage,CameraManageDeletage>

@property (nonatomic,strong) UIAlertController *alertController; //!< 弹出框视图控制器
@property (nonatomic,strong) BaseViewController *viewController;
@property (nonatomic,strong) UILabel *limitLabel; //!< 输入内容限制
@property (nonatomic,strong) BaseTextView *reasonTextView;  //!< 原因输入文本域
@property (nonatomic,strong) XHAskforLeaveAddPhotoControl *addPhotoControl;   //!< 添加照片选项
@property (nonatomic,strong) XHAskforLeaveArrowCell *startTimeControl;   //!< 开始时间选项
@property (nonatomic,strong) XHAskforLeaveArrowCell *endTimeControl;   //!< 开始时间选项
@property (nonatomic,strong) BaseButtonControl *daysleaveControl;   //!< 请假天数
@property (nonatomic,strong) XHAskforLeaveChargeTeacherControl *chargeTeacherControl;   //!< 审批人
@property (nonatomic,strong) XHAskforLeaveSubmitControl *submitControl;   //!< 提交

@property (nonatomic,assign) NSInteger selectTimeControl; //!< 记录选择的是哪个时间选择器


@end


@implementation XHAskforLeaveContentView

-(instancetype)initWithObject:(BaseViewController*)object
{
    self = [super init];
    if (self)
    {
        [self setViewController:object];
       
        
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self addSubViews:YES];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.reasonTextView resetFrame:CGRectMake(10.0,10.0, frame.size.width-20.0, 60.0)];
    [self.addPhotoControl resetFrame:CGRectMake(self.reasonTextView.left, self.reasonTextView.bottom+10.0, 70.0, 70.0)];
    [self.limitLabel setFrame:CGRectMake(self.addPhotoControl.right, self.addPhotoControl.bottom-20.0, frame.size.width-self.addPhotoControl.right-20.0, 20.0)];
    [self.startTimeControl resetFrame:CGRectMake(0, self.addPhotoControl.bottom+10.0, frame.size.width, 60.0)];
    [self.endTimeControl resetFrame:CGRectMake(self.startTimeControl.left, self.startTimeControl.bottom, self.startTimeControl.width, self.startTimeControl.height)];
    //设置请假几天的控件Frame
    [self.daysleaveControl resetFrame:CGRectMake(self.endTimeControl.left, self.endTimeControl.bottom, self.endTimeControl.width, self.endTimeControl.height)];
    [self.daysleaveControl setTitleEdgeFrame:CGRectMake(10, 0, self.daysleaveControl.width/2.0, self.daysleaveControl.height) withNumberType:0 withAllType:NO];
    [self.daysleaveControl setInputEdgeFrame:CGRectMake((self.daysleaveControl.width-130.0), 0, 100.0, self.daysleaveControl.height) withNumberType:0 withAllType:NO];
    [self.daysleaveControl setTitleEdgeFrame:CGRectMake(self.daysleaveControl.width-30, 0, 30, self.daysleaveControl.height) withNumberType:1 withAllType:NO];
    [self.daysleaveControl resetLineViewFrame:CGRectMake(0, self.daysleaveControl.height-0.5, self.daysleaveControl.width, 0.5) withNumberType:0 withAllType:NO];
    //审批人
    [self.chargeTeacherControl resetFrame:CGRectMake(self.daysleaveControl.left, self.daysleaveControl.bottom+10.0, 80.0, 105)];
    
    [self.submitControl resetFrame:CGRectMake(10, self.chargeTeacherControl.bottom+20.0, (frame.size.width-20.0), 40.0)];
    [self setContentSize:CGSizeMake(frame.size.width, self.submitControl.bottom+60.0)];
    
    
  
}


#pragma mark - Action Method
-(void)controlAction:(UIControl*)sender
{
    [self.daysleaveControl resignInputFirstResponder];
    [self.reasonTextView resignFirstResponder];
    switch (sender.tag)
    {
#pragma mark case 1 选择孩子
        case 1:
        {
            
            [self.viewController presentViewController:self.alertController animated:YES completion:^{}];
        }
            break;
#pragma mark case 2 添加图片
        case 2:
        {
            [self addphototAction:sender];
        }
            break;
#pragma mark case 3 开始时间
        case 3:
#pragma mark case 4 结束时间
        case 4:
        {
            [self setSelectTimeControl:sender.tag];
            [[XHDatePickerControl sharedObject] showWithDeletage:self];
        }
            break;
#pragma mark case 6  班主任
        case 6:
        {
            XHTeacherAddressBookViewController *teacherAddressBook = [[XHTeacherAddressBookViewController alloc]init];
            [self.viewController.navigationController pushViewController:teacherAddressBook animated:YES];
            teacherAddressBook.didselectBack = ^(XHTeacherAddressBookFrame *itemObject)
            {
                [self.chargeTeacherControl setTeacherAddressBook:itemObject];
            };
        }
            break;
#pragma mark case 7 提交
        case 7:
        {
            [self uploadImageWithImage:self.addPhotoControl.image withImageName:[XHHelper createGuid] WithContent:self.reasonTextView.text withBeginTime:self.startTimeControl.describe withEndTime:self.endTimeControl.describe withActorId:[XHUserInfo sharedUserInfo].guardianModel.guardianId withStudentBaseId:@"" withShr:self.chargeTeacherControl.teacherAddressBook.model.ID withCsr:@""];
            
        }
            break;
    }
}


-(void)addphototAction:(UIControl*)sender
{
    if (self.addPhotoControl.isAddImage)
    {
        [[XHAskforLeavePreviewControl sharedObject] showWithImage:self.addPhotoControl.image withDeletage:self];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
        {
            CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeCamera setDeletate:self];
            [self.viewController.navigationController presentViewController:manager animated:YES completion:^{}];
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeSavedPhotosAlbum setDeletate:self];
            [self.viewController.navigationController presentViewController:manager animated:YES completion:^{}];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}]];
        [self.viewController presentViewController:alertController animated:YES completion:^{}];
    }
}



-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.reasonTextView];
        [self addSubview:self.addPhotoControl];
        [self addSubview:self.limitLabel];
        [self addSubview:self.startTimeControl];
        [self addSubview:self.endTimeControl];
        [self addSubview:self.chargeTeacherControl];
        [self addSubview:self.daysleaveControl];
        [self addSubview:self.submitControl];
    }
}




#pragma mark - Deletage Method
#pragma mark BaseTextViewDeletage
- (void)textViewDidChange:(UITextView *)textView
{
    //实时显示字数
    [self.limitLabel setText:[NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length]];
    
    //字数限制操作
    if (textView.text.length >= 200)
    {
        
        textView.text = [textView.text substringToIndex:200];
        [self.limitLabel setText:@"200/200"];
        
    }
}


#pragma mark XHDatePickerControlDeletage
-(void)datePickerClickObject:(NSString *)date
{
    switch (self.selectTimeControl)
    {
        case 3:
        {
            [self.startTimeControl setDescribe:date];
        }
            break;
        case 4:
        {
            [self.endTimeControl setDescribe:date];
            
        }
            break;
    }
}

#pragma mark XHAskforLeavePreviewControlDeletage
-(void)askforLeavePreviewControlAction:(UIImage*)image
{
    [self.addPhotoControl setImage:image];
}


#pragma mark CameraManageDeletage
-(void)imagePickerControllerdidFinishPickingMediaWithImage:(nonnull UIImage*)image
{
    [self.addPhotoControl setImage:image];
}











#pragma mark - NetWoth Method
-(void)uploadImageWithImage:(UIImage*)image  //!< 图片
              withImageName:(NSString*)imageName  //!< 图片名称
                WithContent:(NSString*)content  //!< 请假内容
              withBeginTime:(NSString*)beginTime  //!< 开始时间
                withEndTime:(NSString*)endTime  //!< 结束时间
                withActorId:(NSString*)actorId   //!< 申请人ID（家长Id）
          withStudentBaseId:(NSString*)studentBaseId //!< 学生ID
                    withShr:(NSString*)shr //!< 班主任ID
                    withCsr:(NSString*)csr //!< 相关人ID（多位以逗号拼接）
{
    if (image)
    {
        [XHHelper uploadImage:image name:imageName uploadCallback:^(BOOL success, NSError *error)
         {
             if (success)
             {
                 [self submitAskforLeaveWithContent:content withBeginTime:beginTime withEndTime:endTime withPicUrl:imageName withActorId:actorId withStudentBaseId:studentBaseId withShr:shr withCsr:csr];
             }
        
             
         } withProgressCallback:^(float progress)
         {
         }];
    }
    else
    {
         [self submitAskforLeaveWithContent:content withBeginTime:beginTime withEndTime:endTime withPicUrl:@"" withActorId:actorId withStudentBaseId:studentBaseId withShr:shr withCsr:csr];
    }
}



-(void)submitAskforLeaveWithContent:(NSString*)content  //!< 请假内容
                      withBeginTime:(NSString*)beginTime  //!< 开始时间
                        withEndTime:(NSString*)endTime  //!< 结束时间
                         withPicUrl:(NSString*)picUrl  //!< 图片url地址
                        withActorId:(NSString*)actorId   //!< 申请人ID（家长Id）
                  withStudentBaseId:(NSString*)studentBaseId //!< 学生ID
                            withShr:(NSString*)shr //!< 班主任ID
                            withCsr:(NSString*)csr //!< 相关人ID（多位以逗号拼接）
{
    if ([[NSString safeString:content] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"内容不能为空"];
    }
    else if ([[NSString safeString:studentBaseId] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"请选择孩子"];
    }
    else if ([[NSString safeString:beginTime] isEqualToString:@"请选择"])
    {
        [XHShowHUD showNOHud:@"请选择开始时间"];
    }
    else if ([[NSString safeString:endTime] isEqualToString:@"请选择"])
    {
        [XHShowHUD showNOHud:@"请选择结束时间"];
    }
    else if ([[NSString safeString:beginTime] isEqualToString:endTime])
    {
        [XHShowHUD showNOHud:@"开始结束时间不能相同"];
    }
    else if ([beginTime compare:endTime] == NSOrderedDescending)
    {
        [XHShowHUD showNOHud:@"开始时间不能晚于结束时间"];
    }
    else if ([[NSString safeString:shr] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"请选择审批人"];
    }
    else
    {
        if (![[NSString safeString:picUrl] isEqualToString:@""])
        {
            [self.netWorkConfig setObject:picUrl forKey:@"picUrl"];
        }
        if (![[NSString safeString:csr] isEqualToString:@""])
        {
            [self.netWorkConfig setObject:csr forKey:@"csr"];
        }
        [self.netWorkConfig setObject:content forKey:@"content"];
        [self.netWorkConfig setObject:beginTime forKey:@"beginTime"];
        [self.netWorkConfig setObject:endTime forKey:@"endTime"];
        [self.netWorkConfig setObject:actorId forKey:@"actorId"];
        [self.netWorkConfig setObject:studentBaseId forKey:@"studentBaseId"];
        [self.netWorkConfig setObject:shr forKey:@"shr"];
        [XHShowHUD showTextHud];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus008" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 
                 
                 
             }
         } error:^(NSError *error){}];
    }
}




#pragma mark - Getter / Setter
#pragma mark 请输入请假理由
-(BaseTextView *)reasonTextView
{
    if (_reasonTextView == nil)
    {
        _reasonTextView = [[BaseTextView alloc]init];
        [_reasonTextView setPlaceholder:@"请输入请假理由"];
        [_reasonTextView setTintColor:MainColor];
        [_reasonTextView setTextDeletage:self];
    }
    return _reasonTextView;
}




#pragma mark 添加图片
-(XHAskforLeaveAddPhotoControl *)addPhotoControl
{
    if (_addPhotoControl == nil)
    {
        _addPhotoControl = [[XHAskforLeaveAddPhotoControl alloc]init];
        [_addPhotoControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addPhotoControl setTag:2];
    }
    return _addPhotoControl;
}



#pragma mark 字数限制
-(UILabel *)limitLabel
{
    if (_limitLabel == nil)
    {
        _limitLabel = [[UILabel alloc]init];
        [_limitLabel setTextAlignment:NSTextAlignmentRight];
        [_limitLabel setFont:FontLevel4];
        [_limitLabel setTextColor:RGB(64, 64, 64)];
        [_limitLabel setText:@"0/200"];
    }
    return _limitLabel;
}


#pragma mark 开始时间
-(XHAskforLeaveArrowCell *)startTimeControl
{
    if (_startTimeControl == nil)
    {
        _startTimeControl = [[XHAskforLeaveArrowCell alloc]init];
        [_startTimeControl setImageName:@"ico_arrow"];
        [_startTimeControl setTitle:@"开始时间"];
        [_startTimeControl setDescribe:@"请选择"];
        [_startTimeControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_startTimeControl setTag:3];
        
    }
    return _startTimeControl;
}


#pragma mark 结束时间
-(XHAskforLeaveArrowCell *)endTimeControl
{
    if (_endTimeControl == nil)
    {
        _endTimeControl = [[XHAskforLeaveArrowCell alloc]init];
        [_endTimeControl setImageName:@"ico_arrow"];
        [_endTimeControl setTitle:@"结束时间"];
        [_endTimeControl setDescribe:@"请选择"];
        [_endTimeControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_endTimeControl setTag:4];
    }
    return _endTimeControl;
}

#pragma mark 请输入天数
-(BaseButtonControl *)daysleaveControl
{
    if (!_daysleaveControl)
    {
        _daysleaveControl = [[BaseButtonControl alloc]init];
        [_daysleaveControl setNumberLabel:2];
        [_daysleaveControl setNumberTextField:1];
        [_daysleaveControl setNumberLineView:1];
        [_daysleaveControl setText:@"请假时长" withNumberType:0 withAllType:NO];
        [_daysleaveControl setText:@"天" withNumberType:1 withAllType:NO];
        [_daysleaveControl setFont:FontLevel3 withNumberType:0 withAllType:YES];
        [_daysleaveControl setTextColor:RGB(14.0, 14.0, 14.0) withTpe:0 withAllType:NO];
        [_daysleaveControl setTextColor:RGB(64.0, 64.0, 64.0) withTpe:1 withAllType:NO];
        [_daysleaveControl setinputTextPlaceholder:@"请输入天数" withNumberType:0 withAllType:NO];
        [_daysleaveControl setInputTintColor:MainColor withNumberType:0 withAllType:NO];
        [_daysleaveControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_daysleaveControl setTag:5];
        [_daysleaveControl setItemColor:NO];
    }
    return _daysleaveControl;
}
#pragma mark 审批人
-(XHAskforLeaveChargeTeacherControl *)chargeTeacherControl
{
    if (_chargeTeacherControl == nil)
    {
        _chargeTeacherControl = [[XHAskforLeaveChargeTeacherControl alloc]init];
        [_chargeTeacherControl setTitle:@"审批人"];
        [_chargeTeacherControl setImaeg:[UIImage imageNamed:@"addman"]];
        [_chargeTeacherControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_chargeTeacherControl setTag:6];
    }
    return _chargeTeacherControl;
}


#pragma mark 提交
-(XHAskforLeaveSubmitControl *)submitControl
{
    if (_submitControl == nil)
    {
        _submitControl = [[XHAskforLeaveSubmitControl alloc]init];
        [_submitControl setBackgroundColor:MainColor];
        [_submitControl setTitle:@"提交"];
        [_submitControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_submitControl setTag:7];
    }
    return _submitControl;
}




#pragma mark 孩子列表
-(UIAlertController *)alertController
{
    if (!_alertController)
    {
        _alertController = [UIAlertController alertControllerWithTitle:@"孩子列表" message:@"选择孩子" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}];
        
        [_alertController addAction:action];
    }
    return _alertController;
}


-(XHNetWorkConfig *)netWorkConfig
{
    if (!_netWorkConfig)
    {
        _netWorkConfig = [[XHNetWorkConfig alloc]init];
    }
    return _netWorkConfig;
}


@end
