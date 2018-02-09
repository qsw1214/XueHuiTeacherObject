//
//  XHNewDynamicsViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewDynamicsViewController.h"
#import "XHNewDynamicsContentView.h"
#import "CameraManageViewController.h"
#import "ShootVideoViewController.h"
#import "WPhotoViewController.h"
#import "VideoManagerViewController.h"


@interface XHNewDynamicsViewController () <XHNewDynamicsContentViewDeletage,ShootVideoViewControllerDelegate,ShootVideoViewControllerDelegate>

@property (nonatomic,strong) XHNewDynamicsContentView *contentView;
@end

@implementation XHNewDynamicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"新增"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    switch (self.index) {
        case 0:
        {
            self.contentView.modelType=XHNewDynamicsImgContentModelType;
        }
            break;
            
        case 1:
        {
            self.contentView.modelType=XHNewDynamicsVideoContentModelType;
        }
            break;
    }
}
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        self.contentView.currentVC=self;
    }
}

#pragma mark - Getter / Setter
-(XHNewDynamicsContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHNewDynamicsContentView alloc]init];
        [_contentView setDynamicsDynamicsDeletage:self];
    }
    return _contentView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - Deletage Method
-(void)newDynamicsAction:(BaseButtonControl *)sender
{
    switch (self.contentView.modelType)
    {
#pragma mark  发送图片
        case XHNewDynamicsImgContentModelType:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
            {
                CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeCamera setDeletate:self];
                [self.navigationController presentViewController:manager animated:YES completion:nil];
                
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
                    
                    
                    [self.contentView setItemArray:self.dataArray];
                };
                [self presentViewController:wphoto animated:YES completion:nil];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}]];
            [[XHHelper sharedHelper].currentViewController presentViewController:alertController animated:YES completion:nil];
        }
            break;
#pragma mark  发送视频
        case XHNewDynamicsVideoContentModelType:
        {
            
            [UIAlertController actionSheetWithmessage:@"选择类型" titlesArry:@[@"录制视频",@"从相册中选择"] controller:self indexBlock:^(NSInteger index, id object) {
                switch (index)
                {
                    case 0:
                    {
                        ShootVideoViewController *shoot = [[ShootVideoViewController alloc] init];
                        shoot.delegate = self;
                        [self presentViewController:shoot animated:YES completion:nil];
                    }
                        break;
                        
                    case 1:
                    {
                        VideoManagerViewController *video=[[VideoManagerViewController alloc] initWithVideoManageWithType:VideoSourceTypeSavedPhotosAlbum setDeletate:self];
                        [self presentViewController:video animated:YES completion:nil];
                    }
                        break;
                }
            }];
            
        }
            break;
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
#pragma mark VideoManageDeletage
-(void)videoPickerControllerdidFinishPickingMediaWithImage:(UIImage *)image videoData:(NSData *)videoData
{
    [self.dataArray removeAllObjects];
//    self.videoData=videoData;
    XHPreviewModel *imageModel = [[XHPreviewModel alloc]init];
    [imageModel setPreviewImage:image];
    [imageModel setItemSize:CGSizeMake(100, 100)];
    [imageModel setType:XHPreviewImagesType];
    [imageModel setTage:0];
    [imageModel setIndexTage:0];
    [self.dataArray addObject:imageModel];
    [self.contentView setItemArray:self.dataArray];
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
