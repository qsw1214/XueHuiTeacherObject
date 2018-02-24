//
//  XHAddNoticeViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddNoticeViewController.h"
#import "XHAddNoticeContentView.h"
#import "XHNoticeListViewController.h"
#import "XHAddNoticeRecipientViewController.h"
#import "CameraManageViewController.h"
#import "WPhotoViewController.h"
#import "XHNoticeRecordViewController.h"






@interface XHAddNoticeViewController () <XHAddNoticeContentViewDeletage>

@property (nonatomic,strong) XHAddNoticeContentView *contentView;

@end

@implementation XHAddNoticeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"发布通知"];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"记录"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}

-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    XHNoticeRecordViewController *noticeRecord = [[XHNoticeRecordViewController alloc]init];
    [self.navigationController pushViewController:noticeRecord animated:YES];
}


#pragma mark - Deletage Method
#pragma mark XHAddNoticeContentViewDeletage
-(void)addNoticeContentAction:(BaseButtonControl*)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
            {
                CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeCamera setDeletate:self];
                [self.navigationController presentViewController:manager animated:YES completion:nil];
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                WPhotoViewController
                *wphoto = [[WPhotoViewController alloc] init];
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
                    
                    
                    [self.contentView setItemArray:self.dataArray];
                };
                [self.navigationController presentViewController:wphoto animated:YES completion:nil];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}]];
            
            [self presentViewController:alertController animated:YES completion:^{}];
        }
            break;
        case 2:
        {
            XHAddNoticeRecipientViewController *linkMan = [[XHAddNoticeRecipientViewController alloc]init];
            linkMan.markSuccessBlock = ^(BOOL sucess,XHNoticeMarkModel *model)
            {
                if (sucess)
                {
                    [self.contentView setMarkModel:model];
                }
                
            };
            [self.navigationController pushViewController:linkMan animated:YES];
        }
            break;
        case 3:
        {
            if ([self.dataArray count])
            {
                [XHShowHUD showTextHud];
                NSMutableArray *tempImageArray = [NSMutableArray array];
                [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHPreviewModel *obj, NSUInteger idx, BOOL *stop)
                {
                    [tempImageArray addObject:obj.previewImage];
                }];
                [OSSImageUploader asyncUploadImages:tempImageArray complete:^(NSArray<NSString *> *names, UploadImageState state)
                {
                    [XHShowHUD hideHud];
                    if (state)
                    {
                        for (int i = 0; i< [names count]; i++)
                        {
                            NSString *imageName = [NSString safeString:[names objectAtIndex:i]];
                            [sender.networkConfig setObject:imageName forKey:[NSString stringWithFormat:@"picUrl%zd",(i+1)]];
                        }
                        [sender.networkConfig postWithUrl:@"zzjt-app-api_notice004" sucess:^(id object, BOOL verifyObject)
                         
                         {
                             if (verifyObject)
                             {
                                 [self.navigationController popViewControllerAnimated:YES];
                             }
                             
                         } error:^(NSError *error){}];
                    }
                    else
                    {
                        [XHShowHUD showNOHud:@"发布失败，请重试"];
                    }
                }];
        }
        else
        {
            [XHShowHUD showTextHud];
            [sender.networkConfig postWithUrl:@"zzjt-app-api_notice004" sucess:^(id object, BOOL verifyObject)
             
             {
                 if (verifyObject)
                 {
                     [self.navigationController popViewControllerAnimated:YES];
                 }
             } error:^(NSError *error){}];
        }
    }
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
        [self.contentView setItemArray:self.dataArray];
    }
}


#pragma mark - Getter / Setter
-(XHAddNoticeContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHAddNoticeContentView alloc]init];
        [_contentView setAddDeletage:self];
    }
    return _contentView;
}




@end
