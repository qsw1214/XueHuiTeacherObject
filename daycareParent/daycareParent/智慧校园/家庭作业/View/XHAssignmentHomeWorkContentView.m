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





@interface XHAssignmentHomeWorkContentView () <BaseTextViewDeletage>

@property (nonatomic,strong) BaseButtonControl *classContent; //!< 班级
@property (nonatomic,strong) BaseButtonControl *subjectContent; //!< 科目
@property (nonatomic,strong) BaseButtonControl *addPhotoContent; //!< 类别
@property (nonatomic,strong) XHAssignmentHomeWorkCollectionView *collectionView;
@property (nonatomic,strong) BaseTextView *inputContent; //!< 输入类型
@property (nonatomic,strong) BaseButtonControl *submitContent; //!< 发布
@property (nonatomic,strong) UIView *lineVew; //!< 分割线视图
@property (nonatomic,strong) UILabel *limitLabel; //!< 限制字数标签
@property (nonatomic,strong) NSMutableArray *imageNameArray; //!< 图片名称数组



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
    //类型
    [self.classContent resetFrame:CGRectMake(0, 0, frame.size.width, 60.0)];
    [self.classContent setTitleEdgeFrame:CGRectMake(10, 0, 60, self.classContent.height) withNumberType:0 withAllType:NO];
    [self.classContent setTitleEdgeFrame:CGRectMake(80, 0, (frame.size.width-110.0), self.classContent.height) withNumberType:1 withAllType:NO];
    [self.classContent setImageEdgeFrame:CGRectMake((self.classContent.width-30.0), ((self.classContent.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.classContent resetLineViewFrame:CGRectMake(0, self.classContent.height-0.5, self.classContent.width, 0.5) withNumberType:0 withAllType:NO];
    //添加科目
    [self.subjectContent resetFrame:CGRectMake(0, self.classContent.bottom, frame.size.width, 60.0)];
    [self.subjectContent setTitleEdgeFrame:CGRectMake(10, 0, 60, self.subjectContent.height) withNumberType:0 withAllType:NO];
    [self.subjectContent setTitleEdgeFrame:CGRectMake(80, 0, (frame.size.width-110.0), self.subjectContent.height) withNumberType:1 withAllType:NO];
    [self.subjectContent setImageEdgeFrame:CGRectMake((self.subjectContent.width-30.0), ((self.subjectContent.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.subjectContent resetLineViewFrame:CGRectMake(0, self.subjectContent.height-0.5, self.subjectContent.width, 0.5) withNumberType:0 withAllType:NO];
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
    
    
    //发布
    [self.submitContent resetFrame:CGRectMake(10, self.addPhotoContent.bottom+60.0, (self.subjectContent.width-20.0), 50.0)];
    [self.submitContent setTitleEdgeFrame:CGRectMake(0, 0, self.submitContent.width, self.submitContent.height) withNumberType:0 withAllType:NO];
    
    
    
    
    
    
    //重新设置当前滚动视图的可滚动区域
    [self setContentSize:CGSizeMake(frame.size.width, self.submitContent.bottom+20.0)];
}




-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.classContent];
        [self addSubview:self.subjectContent];
        [self addSubview:self.addPhotoContent];
        [self addSubview:self.collectionView];
        [self addSubview:self.inputContent];
        [self addSubview:self.limitLabel];
        [self addSubview:self.lineVew];
        [self addSubview:self.submitContent];
        
        
        
        
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
            [[XHUserInfo sharedUserInfo] getClassList:^(BOOL isOK, NSMutableArray *classListArry) {
                if (isOK)
                {
                    [UIAlertController alertClassListWithTitle:@"提示" message:@"选择班级列表" titlesArry:classListArry alertControllerStyle:UIAlertControllerStyleActionSheet hiddenCancelButton:NO cancleStyle:UIAlertActionStyleCancel withController:[
                                                                                                                                                                                                                                        XHHelper sharedHelper].currentViewController indexBlock:^(NSInteger index, XHClassListModel *object)
                    {
                        
                        [self.classContent setClassListModel:object];
                        [self.classContent setText:object.gradeAndClassName withNumberType:1 withAllType:NO];
                        
                        
                    }];
                }
                else
                {
                    [UIAlertController alertWithTitle:@"提示" message:@"暂无数据" titlesArry:@[@"确定"] alertControllerStyle:UIAlertControllerStyleAlert hiddenCancelButton:YES cancleStyle:UIAlertActionStyleCancel withController:[
                                                                                                                                                                                                                             XHHelper sharedHelper].currentViewController indexBlock:^(NSInteger index, id object) {}];
                }
            }];
        }
            break;
#pragma mark case 2 选择科目
        case 2:
        {
            [[XHUserInfo sharedUserInfo] getSubjectList:^(BOOL isOK, NSMutableArray *subjectListArry) {
                if (isOK) {
                    [UIAlertController alertSubjectListWithTitle:@"提示" message:@"选择科目列表" titlesArry:subjectListArry alertControllerStyle:UIAlertControllerStyleActionSheet hiddenCancelButton:NO cancleStyle:UIAlertActionStyleCancel withController:[
                                                                                                                                                                                                                                                                                   XHHelper sharedHelper].currentViewController indexBlock:^(NSInteger index, XHSubjectListModel *object)
                    {
                        [self.subjectContent setSubjectListModel:object];
                        [self.subjectContent setText:object.subjectName withNumberType:1 withAllType:NO];
                        
                    }];
                }
                else
                {
                    [UIAlertController alertWithTitle:@"提示" message:@"暂无数据" titlesArry:@[@"确定"] alertControllerStyle:UIAlertControllerStyleAlert hiddenCancelButton:YES cancleStyle:UIAlertActionStyleCancel withController:[
                                                                                                                                                                                                                             XHHelper sharedHelper].currentViewController indexBlock:^(NSInteger index, id object) {}];
                }
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
#pragma mark 发布作业
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
                
                if ([self.dataArray count])
                {
                    [XHShowHUD showTextHud];
                    [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHPreviewModel *obj, NSUInteger idx, BOOL *stop)
                    {
                        NSString *imageName = [XHHelper createGuid];
                        [XHHelper uploadImage:obj.previewImage name:imageName uploadCallback:^(BOOL success, NSError *error)
                     {
                         if (success)
                         {
                             MAIN(^{
                                 
                                 [self.imageNameArray addObject:imageName];
                                 if ([self.imageNameArray count] == [self.dataArray count])
                                 {
                                     XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                                     [config setObject:[self.imageNameArray objectAtIndex:0] forKey:@"picUrl1"];
                                     [config setObject:[self.imageNameArray objectAtIndex:1] forKey:@"picUrl2"];
                                     [config setObject:[self.imageNameArray objectAtIndex:2] forKey:@"picUrl3"];
                                     [config setObject:[self.imageNameArray objectAtIndex:3] forKey:@"picUrl4"];
                                     [config setObject:[self.imageNameArray objectAtIndex:4] forKey:@"picUrl5"];
                                     [config setObject:[self.imageNameArray objectAtIndex:5] forKey:@"picUrl6"];
                                     [config setObject:self.classContent.classListModel.clazzId forKey:@"classId"];
                                     [config setObject:self.subjectContent.subjectListModel.ID forKey:@"subjectId"];
                                     [config setObject:self.inputContent.text forKey:@"content"];
                                     [config setObject:[XHUserInfo sharedUserInfo].schoolId forKey:@"schoolId"];
                                     [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
                                     [config postWithUrl:@"zzjt-app-api_schoolWork001" sucess:^(id object, BOOL verifyObject)
                                      
                                      {
                                          if (verifyObject)
                                          {
                                              
                                          }
                                      } error:^(NSError *error){}];
                                 }
                             });
                             
                         }
                     } withProgressCallback:^(float progress)
                     {
                     }];
                    }];
                }
                else
                {
                    [XHShowHUD showTextHud];
                    XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                    [config setObject:self.classContent.classListModel.clazzId forKey:@"classId"];
                    [config setObject:self.subjectContent.subjectListModel.ID forKey:@"subjectId"];
                    [config setObject:self.inputContent.text forKey:@"content"];
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
        [_classContent setNumberLabel:2];
        [_classContent setNumberImageView:1];
        [_classContent setNumberLineView:1];
        [_classContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_classContent setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_classContent setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [_classContent setTextColor:[UIColor grayColor] withTpe:1 withAllType:NO];
        [_classContent setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_classContent setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
        [_classContent setText:@"选择班级" withNumberType:0 withAllType:NO];
        [_classContent setText:@"请选择" withNumberType:1 withAllType:NO];
        [_classContent addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_classContent setTag:1];
    }
    return _classContent;
}


-(BaseButtonControl *)subjectContent
{
    if (!_subjectContent)
    {
        _subjectContent = [[BaseButtonControl alloc]init];
        [_subjectContent setNumberLabel:2];
        [_subjectContent setNumberImageView:1];
        [_subjectContent setNumberLineView:1];
        [_subjectContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_subjectContent setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_subjectContent setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [_subjectContent setTextColor:[UIColor grayColor] withTpe:1 withAllType:NO];
        [_subjectContent setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_subjectContent setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
        [_subjectContent setText:@"选择科目" withNumberType:0 withAllType:NO];
        [_subjectContent setText:@"请选择" withNumberType:1 withAllType:NO];
        [_subjectContent addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_subjectContent setTag:2];
    }
    return _subjectContent;
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
        [_submitContent addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_submitContent setTag:4];
    }
    return _submitContent;
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



-(NSMutableArray *)imageNameArray
{
    if (!_imageNameArray)
    {
        _imageNameArray = [NSMutableArray array];
    }
    return _imageNameArray;
}
@end
