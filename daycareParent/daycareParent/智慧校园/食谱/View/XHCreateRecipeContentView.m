//
//  XHCreateRecipeContentView.m
//  daycareParent
//
//  Created by Git on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCreateRecipeContentView.h"
#import "CameraManageViewController.h"
#import "XHAskforLeaveAddPhotoControl.h"
#import "BaseTextFieldControl.h"
#import "XHDatePickerControl.h"



@interface XHCreateRecipeContentView () <XHCustomDatePickerViewDelegate>

@property (nonatomic,strong) BaseButtonControl *kindContent; //!< 类别
@property (nonatomic,strong) XHAskforLeaveAddPhotoControl *addPhotoContent; //!< 类别
@property (nonatomic,strong) BaseTextView *inputContent; //!< 输入类型
@property (nonatomic,strong) BaseButtonControl *dateContent; //!< 日期
@property (nonatomic,strong) BaseButtonControl *submitContent; //!< 发布







@end

@implementation XHCreateRecipeContentView




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews:YES];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    //类型
    [self.kindContent resetFrame:CGRectMake(0, 0, frame.size.width, 60.0)];
    [self.kindContent setTitleEdgeFrame:CGRectMake(10, 0, 60, self.kindContent.height) withNumberType:0 withAllType:NO];
    [self.kindContent setTitleEdgeFrame:CGRectMake(80, 0, (frame.size.width-110.0), self.kindContent.height) withNumberType:1 withAllType:NO];
    [self.kindContent setImageEdgeFrame:CGRectMake((self.kindContent.width-30.0), ((self.kindContent.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.kindContent resetLineViewFrame:CGRectMake(0, self.kindContent.height-0.5, self.kindContent.width, 0.5) withNumberType:0 withAllType:NO];
    //添加图片
    [self.addPhotoContent resetFrame:CGRectMake(10, self.kindContent.bottom+10.0,(frame.size.width-30.0)*(2.0/5.0) , 90)];
    //添加食谱描述
    [self.inputContent resetFrame:CGRectMake(self.addPhotoContent.right+10.0,self.addPhotoContent.top, (frame.size.width-30.0)*(3.0/5.0), self.addPhotoContent.height)];
    //添加日期
    [self.dateContent resetFrame:CGRectMake(0, self.addPhotoContent.bottom+10.0, self.kindContent.width, self.kindContent.height)];
    [self.dateContent setTitleEdgeFrame:CGRectMake(10, 0, 60, self.dateContent.height) withNumberType:0 withAllType:NO];
    [self.dateContent setTitleEdgeFrame:CGRectMake(80.0, 0, (frame.size.width-110.0), self.dateContent.height) withNumberType:1 withAllType:NO];
    [self.dateContent setImageEdgeFrame:CGRectMake((self.dateContent.width-30.0), ((self.dateContent.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.dateContent resetLineViewFrame:CGRectMake(0, 0.0, self.dateContent.width, 0.5) withNumberType:0 withAllType:NO];
    [self.dateContent resetLineViewFrame:CGRectMake(0, self.dateContent.height-0.5, self.dateContent.width, 0.5) withNumberType:1 withAllType:NO];
    
    //发布
    [self.submitContent resetFrame:CGRectMake(10, self.dateContent.bottom+60.0, (self.dateContent.width-20.0), 50.0)];
    [self.submitContent setTitleEdgeFrame:CGRectMake(0, 0, self.submitContent.width, self.submitContent.height) withNumberType:0 withAllType:NO];
    
    
    //重新设置当前滚动视图的可滚动区域
    [self setContentSize:CGSizeMake(frame.size.width, self.submitContent.bottom+20.0)];
    
}



-(void)contentAction:(BaseButtonControl*)sender
{
    [self.inputContent resignFirstResponder];
    switch (sender.tag)
    {
#pragma mark case 1 选择类型
        case 1:
        {
    
            NSArray *itemArray = @[@"早餐",@"上午加餐",@"午餐",@"下午加餐",@"晚餐"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            for (NSString *title in itemArray)
            {
                [alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                    
                    [self.kindContent setText:action.title withNumberType:1 withAllType:NO];
                    
                }]];
            }
            
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}]];
            
            
            [[XHHelper sharedHelper].currentViewController presentViewController:alert animated:YES completion:^{}];
            
        }
            break;
#pragma mark case 2 选择图片
        case 2:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeCamera setDeletate:self];
                [[XHHelper sharedHelper].currentViewController presentViewController:manager animated:YES completion:nil];
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeHeadPortraitSavedPhotosAlbum setDeletate:self];
                [[XHHelper sharedHelper].currentViewController presentViewController:manager animated:YES completion:nil];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
            {
                
            }]];
            [[XHHelper sharedHelper].currentViewController presentViewController:alertController animated:YES completion:nil];
        }
            break;
#pragma mark case 3 选择时间
        case 3:
        {
            self.datePickerView.delegate=self;
            self.datePickerView.modelyTpe=XHCustomDatePickerViewModelAllDayType;
            [[XHHelper sharedHelper].currentViewController.view addSubview:self.datePickerView];

        }
            break;
#pragma mark case 4 提交
        case 4:
        {
            
            NSString *kind = [self.kindContent labelTitlewithNumberType:1];
            NSString *time = [self.dateContent labelTitlewithNumberType:1];
            if ([kind isEqualToString:@"请选择"])
            {
                [XHShowHUD showNOHud:@"请选择类型"];
            }
            else if (!self.addPhotoContent.isAddImage)
            {
                [XHShowHUD showNOHud:@"请选择封面图片"];
            }
            else if ([self.inputContent.text isEqualToString:@""])
            {
                [XHShowHUD showNOHud:@"内容不能为空"];
            }
            else  if ([time isEqualToString:@"请选择"])
            {
                [XHShowHUD showNOHud:@"请选择时间"];
            }
            else
            {
                [XHShowHUD showTextHud];
                NSString *fileName = [XHHelper createGuid];
                [XHHelper uploadImage:self.addPhotoContent.recipeImage name:fileName uploadCallback:^(BOOL success, NSError *error)
                 {
                     if (success)
                     {
                         MAIN(^{
                             XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                             [config setObject:fileName forKey:@"picUrl"];
                             [config setObject:time forKey:@"publishTime"];
                             [config setObject:[NSString safeString:self.inputContent.text] forKey:@"demo"];
                             [config setObject:[XHUserInfo sharedUserInfo].schoolId forKey:@"school_id"];
                             [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"publish_user_id"];
                             [config setObject:[XHHelper BookingSituation:kind] forKey:@"type"];
                             [config postWithUrl:@"zzjt-app-api_cookBook001" sucess:^(id object, BOOL verifyObject)
                              {
                                  [XHShowHUD hideHud];
                                  [[XHHelper sharedHelper].currentViewController.navigationController popViewControllerAnimated:YES];
                                  
                              } error:^(NSError *error) {
                                  [XHShowHUD hideHud];
                              }];
                         });
                        
                     }
                     else
                     {
                         [XHShowHUD showNOHud:@"提交失败，请重试！"];
                     }
                     
                } withProgressCallback:^(float progress) {}];
                
                
                
            }
        }
            break;
    }
}



#pragma mark - Deletage Method
#pragma mark XHDatePickerControlDeletage
-(void)getDateStr:(NSString *)dateStr
{
    [self.dateContent setText:dateStr withNumberType:1 withAllType:NO];
}
-(void)imagePickerControllerdidFinishPickingMediaWithImage:(nonnull UIImage*)image
{
    [self.addPhotoContent setRecipeImage:image];
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.kindContent];
        [self addSubview:self.addPhotoContent];
        [self addSubview:self.inputContent];
        [self addSubview:self.dateContent];
        [self addSubview:self.submitContent];
    }
}

#pragma mark - Getter / Setter
-(BaseButtonControl *)kindContent
{
    if (!_kindContent)
    {
        _kindContent = [[BaseButtonControl alloc]init];
        [_kindContent setNumberLabel:2];
        [_kindContent setNumberImageView:1];
        [_kindContent setNumberLineView:1];
        [_kindContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_kindContent setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_kindContent setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [_kindContent setTextColor:[UIColor grayColor] withTpe:1 withAllType:NO];
        [_kindContent setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_kindContent setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
        [_kindContent setText:@"类别" withNumberType:0 withAllType:NO];
        [_kindContent setText:@"请选择" withNumberType:1 withAllType:NO];
        [_kindContent addTarget:self action:@selector(contentAction:) forControlEvents:UIControlEventTouchUpInside];
        [_kindContent setTag:1];
  
    }
    return _kindContent;
}

#pragma mark 添加图片
-(XHAskforLeaveAddPhotoControl *)addPhotoContent
{
    if (_addPhotoContent == nil)
    {
        _addPhotoContent = [[XHAskforLeaveAddPhotoControl alloc]init];
        [_addPhotoContent addTarget:self action:@selector(contentAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addPhotoContent setTag:2];
        [_addPhotoContent setRecipeImage:nil];
    }
    return _addPhotoContent;
}

-(BaseTextView *)inputContent
{
    if (!_inputContent)
    {
        _inputContent = [[BaseTextView alloc]init];
        [_inputContent setPlaceholder:@"添加菜谱描述"];
        [_inputContent setLayerCornerRadius:2.0];
        [_inputContent setLayerBorderWidth:0.5];
        [_inputContent setBorderColor:LineViewColor];
        [_inputContent setPlaceholderColor:RGB(169.0, 169.0, 169.0)];
    }
    return _inputContent;
}


-(BaseButtonControl *)dateContent
{
    if (!_dateContent)
    {
        _dateContent = [[BaseButtonControl alloc]init];
        [_dateContent setNumberLabel:2];
        [_dateContent setNumberImageView:1];
        [_dateContent setNumberLineView:2];
        [_dateContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_dateContent setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_dateContent setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [_dateContent setTextColor:[UIColor grayColor] withTpe:1 withAllType:NO];
        [_dateContent setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
        [_dateContent setText:@"时间" withNumberType:0 withAllType:NO];
        [_dateContent setText:@"请选择" withNumberType:1 withAllType:NO];
        [_dateContent setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_dateContent addTarget:self action:@selector(contentAction:) forControlEvents:UIControlEventTouchUpInside];
        [_dateContent setTag:3];
    }
    return _dateContent;
}


-(BaseButtonControl *)submitContent
{
    if (!_submitContent)
    {
        _submitContent = [[BaseButtonControl alloc]init];
        [_submitContent setNumberLabel:1];
        [_submitContent setBackgroundColor:MainColor];
        [_submitContent setText:@"发布" withNumberType:0 withAllType:NO];
        [_submitContent setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_submitContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_submitContent setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_submitContent setLayerCornerRadius:5.0];
        [_submitContent addTarget:self action:@selector(contentAction:) forControlEvents:UIControlEventTouchUpInside];
        [_submitContent setTag:4];
    }
    return _submitContent;
}

@end
