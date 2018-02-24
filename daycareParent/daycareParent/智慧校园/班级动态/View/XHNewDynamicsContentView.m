//
//  XHNewDynamicsContentView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewDynamicsContentView.h"
#import "XHAssignmentHomeWorkCollectionView.h"
#import "CameraManageViewController.h"
#import "WPhotoViewController.h"
#import "XHPreviewModel.h"
#import "VideoManagerViewController.h"
#import "ShootVideoViewController.h"
#import "XHAddNoticeRecipientViewController.h"
@interface XHNewDynamicsContentView () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,BaseTextViewDeletage,ShootVideoViewControllerDelegate,VideoManagerViewControllerDeletage>

@property (nonatomic,strong) BaseButtonControl *classContent; //!< 接收人
@property (nonatomic,strong) BaseButtonControl *addPhotoContent; //!< 类别
@property (nonatomic,strong) XHAssignmentHomeWorkCollectionView *collectionView;
@property (nonatomic,strong) BaseTextView *inputContent; //!< 输入类型
@property (nonatomic,strong) BaseButtonControl *submitContent; //!< 发布
@property (nonatomic,strong) UIView *lineVew; //!< 分割线视图
@property (nonatomic,strong) UILabel *limitLabel; //!< 限制字数标签
@property (nonatomic,strong) NSMutableArray *imageNameArray; //!< 图片名称数组
@property (nonatomic,strong) UIImagePickerController *videoPicker;


@end

@implementation XHNewDynamicsContentView

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
    [self.classContent setTitleEdgeFrame:CGRectMake(10, 0, 80, self.classContent.height) withNumberType:0 withAllType:NO];
    [self.classContent setTitleEdgeFrame:CGRectMake(100, 0, (frame.size.width-130.0), self.classContent.height) withNumberType:1 withAllType:NO];
    [self.classContent setImageEdgeFrame:CGRectMake((self.classContent.width-30.0), ((self.classContent.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.classContent resetLineViewFrame:CGRectMake(0, self.classContent.height-0.5, self.classContent.width, 0.5) withNumberType:0 withAllType:NO];
    //添加食谱描述
    [self.inputContent resetFrame:CGRectMake(10.0,self.classContent.bottom+10.0, (frame.size.width-20.0), 120.0)];
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
    [self.submitContent resetFrame:CGRectMake(10, self.addPhotoContent.bottom+60.0, (frame.size.width-20.0), 50.0)];
    [self.submitContent setTitleEdgeFrame:CGRectMake(0, 0, self.submitContent.width, self.submitContent.height) withNumberType:0 withAllType:NO];
    
    
    
    
    
    
    //重新设置当前滚动视图的可滚动区域
    [self setContentSize:CGSizeMake(frame.size.width, self.submitContent.bottom+20.0)];
}




-(void)setItemArray:(NSMutableArray*)array
{
    [self setDataArray:array];
    [self.collectionView setItemArray:array];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.classContent];
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
#pragma mark case 1 选择接收人
        case 1:
        {
            XHAddNoticeRecipientViewController *add=[[XHAddNoticeRecipientViewController alloc] init];
            [self.currentVC.navigationController pushViewController:add animated:YES];
            add.markSuccessBlock = ^(BOOL sucess, XHNoticeMarkModel *model) {
                if (sucess) {
                    [self.classContent setText:[NSString stringWithFormat:@"已选择%zd人",model.count] withNumberType:1 withAllType:NO];
                    self.classContent.noticeMarkModel=model;
                }
            };
        }
            break;
#pragma mark case 3 选择相册
        case 3:
        {
            
            if ([self.dynamicsDynamicsDeletage respondsToSelector:@selector(newDynamicsAction:)])
            {
                [self.dynamicsDynamicsDeletage newDynamicsAction:sender];
            }

        }
            break;
#pragma mark 发布作业
        case 4:
        {
            if (!self.classContent.noticeMarkModel)
            {
                [XHShowHUD showNOHud:@"请选择接收人"];
            }
            else if ([self.inputContent.text isEqualToString:@""])
            {
                [XHShowHUD showNOHud:@"内容不能为空"];
            }
            else
            {
                switch (self.modelType) {
                    case XHNewDynamicsImgContentModelType:
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
                                    
                                    for (int i=0; i < [names count]; i++)
                                    {
                                        [config setObject:names[i] forKey:[NSString stringWithFormat:@"picUrl%zd",i+1]];
                                    }
                                    [config setObject:content forKey:@"content"];
                                    [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
                                    [config setObject:[XHUserInfo sharedUserInfo].sessionId forKey:@"sessionId"];
                                    [config setObject:@"2" forKey:@"noticeType"];
                                    
                                    [config setObject:self.classContent.noticeMarkModel.teacherID forKey:@"teacherId"];
                                    [config setObject:self.classContent.noticeMarkModel.guardianID forKey:@"guardianId"];
                                    [config postWithUrl:@"pmschool-teacher-api_/teacher/notice/add" sucess:^(id object, BOOL verifyObject)
                                     
                                     {
                                         if (verifyObject)
                                         {
                                             [self.currentVC.navigationController popViewControllerAnimated:YES];
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
                            //不上传图片
                            XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                            [config setObject:self.classContent.noticeMarkModel.teacherID forKey:@"teacherId"];
                            [config setObject:self.classContent.noticeMarkModel.guardianID forKey:@"guardianId"];
                            [config setObject:content forKey:@"content"];
                            [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
                            [config setObject:[XHUserInfo sharedUserInfo].sessionId forKey:@"sessionId"];
                            [config setObject:@"2" forKey:@"noticeType"];
                            [config postWithUrl:@"pmschool-teacher-api_/teacher/notice/add" sucess:^(id object, BOOL verifyObject)
                             {
                                 if (verifyObject)
                                 {
                                     [self.currentVC.navigationController popViewControllerAnimated:YES];
                                 }
                             } error:^(NSError *error){}];
                        }
                        
                        
                    }
                        break;
                        
                    case XHNewDynamicsVideoContentModelType:
                    {
                        NSString *content = [NSString safeString:self.inputContent.text];
                        if ([self.dataArray count])
                        {
                            [XHShowHUD showTextHud];
                            [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHPreviewModel *obj, NSUInteger idx, BOOL *stop)
                             {
                                 NSString *imageName = [NSString stringWithFormat:@"%@.png",[XHHelper createGuid]];
                                 [XHHelper uploadImage:obj.previewImage name:imageName uploadCallback:^(BOOL success, NSError *error)
                                  {
                                      if (success)
                                      {
                                          [self.imageNameArray addObject:imageName];
                                          if ([self.imageNameArray count] == [self.dataArray count])
                                          {
                                              [XHShowHUD showProgressHUD:@"上传视频..."];
                                              NSString *fileName = [NSString stringWithFormat:@"%@.mp4",[XHHelper createGuid]];
                                              [XHHelper uploadVideo:self.videoData name:fileName uploadCallback:^(BOOL success, NSError *error) {
                                                  if (success)
                                                  {
                                                      [XHShowHUD showOKHud:@"视频上传成功"];
                                                      XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                                                      [config setObject:content forKey:@"content"];
                                                      [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
                                                      [config setObject:[XHUserInfo sharedUserInfo].sessionId forKey:@"sessionId"];
                                                      [config setObject:@"2" forKey:@"noticeType"];
                                                      [config setObject:self.classContent.noticeMarkModel.teacherID forKey:@"teacherId"];
                                                      [config setObject:self.classContent.noticeMarkModel.guardianID forKey:@"guardianId"];
                                                      [config setObject:fileName forKey:@"vedioUrl"];
                                                      [config setObject:imageName forKey:@"vedioFirstPicUrl"];
                                                      [config postWithUrl:@"pmschool-teacher-api_/teacher/notice/add" sucess:^(id object, BOOL verifyObject)
                                                       
                                                       {
                                                           if (verifyObject)
                                                           {
                                                               [self.currentVC.navigationController popViewControllerAnimated:YES];
                                                           }
                                                       } error:^(NSError *error){}];
                                                  }
                                                  [XHShowHUD showOKHud:@"视频上传 失败"];
                                              } withProgressCallback:^(float progress){}];
                                              
                                          }
                                      }
                                      else
                                      {
                                          [self.dataArray removeObject:imageName];
                                          if ([self.imageNameArray count] == [self.dataArray count])
                                          {
                                              [XHShowHUD showProgressHUD:@"上传视频..."];
                                              NSString *fileName = [NSString stringWithFormat:@"%@.mp4",[XHHelper createGuid]];
                                              [XHHelper uploadVideo:self.videoData name:fileName uploadCallback:^(BOOL success, NSError *error) {
                                                  if (success)
                                                  {
                                                      [XHShowHUD showOKHud:@"视频上传成功"];
                                                      XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                                                      [config setObject:content forKey:@"content"];
                                                      [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
                                                      [config setObject:[XHUserInfo sharedUserInfo].sessionId forKey:@"sessionId"];
                                                      [config setObject:@"2" forKey:@"noticeType"];
                                                      [config setObject:self.classContent.noticeMarkModel.teacherID forKey:@"teacherId"];
                                                      [config setObject:self.classContent.noticeMarkModel.guardianID forKey:@"guardianId"];
                                                      [config setObject:fileName forKey:@"vedioUrl"];
                                                      [config setObject:imageName forKey:@"vedioFirstPicUrl"];
                                                      [config postWithUrl:@"pmschool-teacher-api_/teacher/notice/add" sucess:^(id object, BOOL verifyObject)
                                                       
                                                       {
                                                           if (verifyObject)
                                                           {
                                                               [self.currentVC.navigationController popViewControllerAnimated:YES];
                                                           }
                                                       } error:^(NSError *error){}];
                                                  }
                                                  [XHShowHUD showOKHud:@"视频上传 失败"];
                                              } withProgressCallback:^(float progress){}];
                                              
                                          }
                                      }
                                  } withProgressCallback:^(float progress){}];
                             }];
                        }
                        else
                        {
                            //不上传视频
                            
                            
                            XHNetWorkConfig *config = [[XHNetWorkConfig alloc]init];
                            [config setObject:self.classContent.noticeMarkModel.teacherID forKey:@"teacherId"];
                            [config setObject:self.classContent.noticeMarkModel.guardianID forKey:@"guardianId"];
                            [config setObject:content forKey:@"content"];
                            [config setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
                            [config setObject:[XHUserInfo sharedUserInfo].sessionId forKey:@"sessionId"];
                            [config setObject:@"2" forKey:@"noticeType"];
                            [config postWithUrl:@"pmschool-teacher-api_/teacher/notice/add" sucess:^(id object, BOOL verifyObject)
                             {
                                 if (verifyObject)
                                 {
                                     [self.currentVC.navigationController popViewControllerAnimated:YES];
                                 }
                             } error:^(NSError *error){}];
                            
                            
                            
                        }
                       
                    }
                        break;
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


- (void)chooseVideoFromLib
{
    _videoPicker = [[UIImagePickerController alloc]init];
    _videoPicker.view.frame = CGRectMake(50, 150, 300, 600);
    _videoPicker.view.backgroundColor = [UIColor redColor];
    _videoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _videoPicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    _videoPicker.delegate = self;
    _videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    _videoPicker.allowsEditing = YES;
    [[XHHelper sharedHelper].currentViewController presentViewController:_videoPicker animated:YES completion:nil];
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
        [_classContent setText:@"选择接收人" withNumberType:0 withAllType:NO];
        [_classContent setText:@"请选择" withNumberType:1 withAllType:NO];
        [_classContent addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_classContent setTag:1];
    }
    return _classContent;
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
        [_inputContent setPlaceholder:@"请输入内容"];
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
