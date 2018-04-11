//
//  XHAssignmentHomeWorkContentView.m
//  daycareParent
//
//  Created by Git on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAssignmentHomeWorkContentView.h"
#import "XHAssignmentHomeWorkCollectionView.h"
#import "CameraManageViewController.h"
#import "WPhotoViewController.h"
#import "XHPreviewModel.h"
#import "XHHomeWorkClassCollectionView.h"






@interface XHAssignmentHomeWorkContentView () <BaseTextViewDeletage>

@property (nonatomic,strong) BaseButtonControl *classContent; //!< 班级
@property (nonatomic,strong) XHHomeWorkClassCollectionView *classCollectionView; //!< 班级分组
@property (nonatomic,strong) BaseButtonControl *subjectContent; //!< 科目
@property (nonatomic,strong) XHHomeWorkClassCollectionView *subjectCollectionView; //!< 科目
@property (nonatomic,strong) BaseButtonControl *addPhotoContent; //!< 类别
@property (nonatomic,strong) XHAssignmentHomeWorkCollectionView *collectionView;
@property (nonatomic,strong) BaseTextView *inputContent; //!< 输入类型
@property (nonatomic,strong) BaseButtonControl *previewControl; //!< 预览功能
@property (nonatomic,strong) BaseButtonControl *submitControl; //!< 发布
@property (nonatomic,strong) UIView *lineVew; //!< 分割线视图
@property (nonatomic,strong) UILabel *limitLabel; //!< 限制字数标签

@end

@implementation XHAssignmentHomeWorkContentView

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
    //班级类型
    [self.classContent resetFrame:CGRectMake(0, 0, frame.size.width, 60.0)];
    [self.classContent setTitleEdgeFrame:CGRectMake(10, 0, 60, self.classContent.height) withNumberType:0 withAllType:NO];
    [self.classContent resetLineViewFrame:CGRectMake(0, self.classContent.height-0.5, self.classContent.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 班级滚动条
    [self.classCollectionView resetFrame:CGRectMake(80.0, 0.0, SCREEN_WIDTH-90.0, self.classContent.height)];
    //添加科目
    [self.subjectContent resetFrame:CGRectMake(0, self.classContent.bottom, frame.size.width, 60.0)];
    [self.subjectContent setTitleEdgeFrame:CGRectMake(10, 0, 60, self.subjectContent.height) withNumberType:0 withAllType:NO];
    [self.subjectContent setTitleEdgeFrame:CGRectMake(80, 0, (frame.size.width-110.0), self.subjectContent.height) withNumberType:1 withAllType:NO];
    [self.subjectContent setImageEdgeFrame:CGRectMake((self.subjectContent.width-30.0), ((self.subjectContent.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.subjectContent resetLineViewFrame:CGRectMake(0, self.subjectContent.height-0.5, self.subjectContent.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 科目滚动条
    [self.subjectCollectionView resetFrame:CGRectMake(80.0, self.subjectContent.top, SCREEN_WIDTH-90.0, self.subjectContent.height)];
    //添加食谱描述
    [self.inputContent resetFrame:CGRectMake(10.0,self.subjectContent.bottom+10.0, (frame.size.width-20.0), 120.0)];
    //添加字数限制
    [self.limitLabel setFrame:CGRectMake(10.0, self.inputContent.bottom, frame.size.width-20.0, 20.0)];
    //添加分割线
    [self.lineVew setFrame:CGRectMake(0, (self.limitLabel.bottom+5.0),SCREEN_WIDTH, 0.5)];
    //添加图片
    [self.addPhotoContent resetFrame:CGRectMake(10, self.lineVew.bottom+20.0, 90, 90)];
    [self.addPhotoContent setImageEdgeFrame:CGRectMake(0, 0, self.addPhotoContent.width, self.addPhotoContent.height) withNumberType:0 withAllType:NO];
    //添加滚动视图
    [self.collectionView resetFrame:CGRectMake(self.addPhotoContent.right+5.0, self.addPhotoContent.top-15.0, frame.size.width-(self.addPhotoContent.right+15.0), 120.0)];
    
    //!< 预览
     [self.previewControl resetFrame:CGRectMake(10, (self.addPhotoContent.bottom+60.0), ((self.subjectContent.width-30.0)/2.0), 50.0)];
    [self.previewControl setTitleEdgeFrame:CGRectMake(0, 0, self.previewControl.width, self.previewControl.height) withNumberType:0 withAllType:NO];
    //发布
    [self.submitControl resetFrame:CGRectMake((self.previewControl.right+10.0),self.previewControl.top, self.previewControl.width, self.previewControl.height)];
    [self.submitControl setTitleEdgeFrame:CGRectMake(0, 0, self.submitControl.width, self.submitControl.height) withNumberType:0 withAllType:NO];
    
    
    
    
    
    
    //重新设置当前滚动视图的可滚动区域
    [self setContentSize:CGSizeMake(frame.size.width, self.submitControl.bottom+20.0)];
}




-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.classContent];
        [self addSubview:self.classCollectionView];
        [self addSubview:self.subjectContent];
        [self addSubview:self.subjectCollectionView];
        [self addSubview:self.addPhotoContent];
        [self addSubview:self.collectionView];
        [self addSubview:self.inputContent];
        [self addSubview:self.limitLabel];
        [self addSubview:self.lineVew];
        [self addSubview:self.previewControl];
        [self addSubview:self.submitControl];
        
        
        
        
    }
}




#pragma mark - Action Method
-(void)controlAction:(BaseButtonControl*)sender
{
    [self.inputContent resignFirstResponder];
    
    switch (sender.tag)
    {
#pragma mark case 1 选择班级
        case 1:
        {
            [UIAlertController alertClassListWith:[XHHelper sharedHelper].currentViewController indexBlock:^(NSInteger index, XHClassListModel *object) {
                [self.classContent setClassListModel:object];
                [self.classContent setText:object.gradeAndClassName withNumberType:1 withAllType:NO];
            }];
        }
            break;
#pragma mark case 2 选择科目
        case 2:
        {
            [UIAlertController alertSubjectListWithController:[XHHelper sharedHelper].currentViewController indexBlock:^(NSInteger index, XHSubjectListModel *object) {
                [self.subjectContent setSubjectListModel:object];
                [self.subjectContent setText:object.subjectName withNumberType:1 withAllType:NO];
            }];
            
        }
            break;
#pragma mark case 3 选择相册
        case 3:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
            {
                CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeCamera setDeletate:self];
                [[XHHelper sharedHelper].currentViewController.navigationController presentViewController:manager animated:YES completion:nil];
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                WPhotoViewController *wphoto = [[WPhotoViewController alloc] init];
                [wphoto setSelectPhotoOfMax:(6-[self.dataArray count])];
                wphoto.selectPhotosBack = ^(NSMutableArray *photosArray)
                {
                    [photosArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                     {
                         XHPreviewModel *imageModel = [[XHPreviewModel alloc]init];
                         [imageModel setPreviewImage:[obj objectForKey:@"image"]];
                         [imageModel setItemSize:CGSizeMake(100, 100)];
                         [imageModel setType:XHPreviewImagesType];
                         [imageModel setTage:idx];
                         [imageModel setIndexTage:idx];
                         [self.dataArray addObject:imageModel];
                     }];
                    
                    
                    [self.collectionView setItemArray:self.dataArray];
                };
                [[XHHelper sharedHelper].currentViewController.navigationController presentViewController:wphoto animated:YES completion:nil];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
            {
                
            }]];
            [[XHHelper sharedHelper].currentViewController presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
#pragma mark case 4 发布作业
        case 4:
        {
            if (!self.classContent.classListModel)
            {
                [XHShowHUD showNOHud:@"请选择班级"];
            }
            else if (!self.subjectContent.subjectListModel)
            {
                [XHShowHUD showNOHud:@"请选择学科"];
            }
            else if ([self.inputContent.text isEqualToString:@""])
            {
                [XHShowHUD showNOHud:@"内容不能为空"];
            }
            else
            {
                
                NSString *content = [NSString safeString:self.inputContent.text];
                
                if ([self.dataArray count])
                {
                    [XHShowHUD showTextHud];
                    NSMutableArray *tempArray = [NSMutableArray array];
                    [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHPreviewModel *obj, NSUInteger idx, BOOL *stop)
                     {
                         [tempArray addObject:obj.previewImage];
                     }];
                    
                    [OSSImageUploader asyncUploadImages:tempArray complete:^(NSArray<NSString *> *names, UploadImageState state)
                     {
                         [XHShowHUD hideHud];
                         if (state)
                         {
                             XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                             for (int i=0; i< [names count]; i++)
                             {
                                 [config setObject:names[i] forKey:[NSString stringWithFormat:@"picUrl%d",(i+1)]];
                             }
                             
                             [config setObject:self.classContent.classListModel.clazzId forKey:@"classId"];
                             [config setObject:self.subjectContent.subjectListModel.ID forKey:@"subjectId"];
                             [config setObject:content forKey:@"content"];
                             [config setObject:[XHUserInfo sharedUserInfo].schoolId forKey:@"schoolId"];
                             [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
                             [config postWithUrl:@"zzjt-app-api_schoolWork001" sucess:^(id object, BOOL verifyObject)
                              
                              {
                                  if (verifyObject)
                                  {
                                      [[XHHelper sharedHelper].currentViewController.navigationController popViewControllerAnimated:YES];
                                  }
                              } error:^(NSError *error){}];
                         }
                         else
                         {
                             [XHShowHUD showNOHud:@"发布失败，请重试!"];
                         }
                         
                     }];
                }
                else
                {
                    [XHShowHUD showTextHud];
                    XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                    [config setObject:self.classContent.classListModel.clazzId forKey:@"classId"];
                    [config setObject:self.subjectContent.subjectListModel.ID forKey:@"subjectId"];
                    [config setObject:content forKey:@"content"];
                    [config setObject:[XHUserInfo sharedUserInfo].schoolId forKey:@"schoolId"];
                    [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
                    [config postWithUrl:@"zzjt-app-api_schoolWork001" sucess:^(id object, BOOL verifyObject)
                     
                     {
                         if (verifyObject)
                         {
                             
                         }
                     } error:^(NSError *error){}];
                }
            }
        }
            break;
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

#pragma mark CameraManageDeletage
-(void)imagePickerControllerdidFinishPickingMediaWithImage:(nonnull UIImage*)image
{
    if ([self.dataArray count] >= 6)
    {
        [XHShowHUD showNOHud:@"图片已达到上限(6张)"];
    }
    else
    {
        XHPreviewModel *imageModel = [[XHPreviewModel alloc]init];
        [imageModel setPreviewImage:image];
        [imageModel setItemSize:CGSizeMake(100, 100)];
        [imageModel setType:XHPreviewImagesType];
        [imageModel setTage:0];
        [imageModel setIndexTage:0];
        [self.dataArray addObject:imageModel];
        [self.collectionView setItemArray:self.dataArray];
    }
}

#pragma mark - Getter / Setter
-(BaseButtonControl *)classContent
{
    if (!_classContent)
    {
        _classContent = [[BaseButtonControl alloc]init];
        [_classContent setNumberLabel:1];
        [_classContent setNumberImageView:1];
        [_classContent setNumberLineView:1];
        [_classContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_classContent setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_classContent setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [_classContent setTextColor:[UIColor grayColor] withTpe:1 withAllType:NO];
        [_classContent setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_classContent setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
        [_classContent setText:@"选择班级" withNumberType:0 withAllType:NO];
        [_classContent setTag:1];
    }
    return _classContent;
}

-(XHHomeWorkClassCollectionView *)classCollectionView
{
    if (!_classCollectionView)
    {
        _classCollectionView = [[XHHomeWorkClassCollectionView alloc]init];
    }
    return _classCollectionView;
}


-(BaseButtonControl *)subjectContent
{
    if (!_subjectContent)
    {
        _subjectContent = [[BaseButtonControl alloc]init];
        [_subjectContent setNumberLabel:1];
        [_subjectContent setNumberLineView:1];
        [_subjectContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_subjectContent setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [_subjectContent setText:@"选择科目" withNumberType:0 withAllType:NO];
        [_subjectContent setTag:2];
    }
    return _subjectContent;
}


-(XHHomeWorkClassCollectionView *)subjectCollectionView
{
    if (!_subjectCollectionView)
    {
        _subjectCollectionView = [[XHHomeWorkClassCollectionView alloc]init];
    }
    return _subjectCollectionView;
}


-(BaseButtonControl *)addPhotoContent
{
    if (!_addPhotoContent)
    {
        _addPhotoContent = [[BaseButtonControl alloc]init];
        [_addPhotoContent setNumberImageView:1];
        [_addPhotoContent setImage:@"addhomework" withNumberType:0 withAllType:NO];
        [_addPhotoContent setIconImageViewBackGroundColor:RGB(238, 238, 238) withNumberType:0 withAllType:NO];
        [_addPhotoContent addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addPhotoContent setTag:3];
    }
    return _addPhotoContent;
}

-(BaseTextView *)inputContent
{
    if (!_inputContent)
    {
        _inputContent = [[BaseTextView alloc]init];
        [_inputContent setPlaceholder:@"请输入作业内容"];
        [_inputContent setTextDeletage:self];
        [_inputContent setPlaceholderColor:RGB(169.0, 169.0, 169.0)];
    }
    return _inputContent;
}

-(BaseButtonControl *)previewControl
{
    if (!_previewControl)
    {
        _previewControl = [[BaseButtonControl alloc]init];
        [_previewControl setNumberLabel:1];
        [_previewControl setBackgroundColor:MainColor];
        [_previewControl setText:@"预览" withNumberType:0 withAllType:NO];
        [_previewControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_previewControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_previewControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_previewControl setLayerCornerRadius:5.0];
        [_previewControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_previewControl setTag:4];
    }
    return _previewControl;
}



-(BaseButtonControl *)submitControl
{
    if (!_submitControl)
    {
        _submitControl = [[BaseButtonControl alloc]init];
        [_submitControl setNumberLabel:1];
        [_submitControl setBackgroundColor:MainColor];
        [_submitControl setText:@"发布" withNumberType:0 withAllType:NO];
        [_submitControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_submitControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_submitControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_submitControl setLayerCornerRadius:5.0];
        [_submitControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_submitControl setTag:5];
    }
    return _submitControl;
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


-(UIView *)lineVew
{
    if (!_lineVew)
    {
        _lineVew = [[UIView alloc]init];
        [_lineVew setBackgroundColor:LineViewColor];
    }
    return _lineVew;
}

-(XHAssignmentHomeWorkCollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[XHAssignmentHomeWorkCollectionView alloc]init];
    }
    return _collectionView;
}







@end
