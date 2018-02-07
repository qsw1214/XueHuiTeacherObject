//
//  VideoManager.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "VideoManagerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
@interface VideoManagerViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation VideoManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 WithType:
 1.从照相机拍照
 2.从相册拾取图片
 */
-(nullable id)initWithVideoManageWithType:(VideoType)Type setDeletate:(nullable id)videoDelegate
{
    self = [super init];
    if (self)
    {
        [self setVideoDelegate:videoDelegate];
        [self setDelegate:self];
        switch (Type)
        {
            case VideoSourceTypeCamera:
            {
                if ([self isSourceTypeCamera])  //判断是否有相机
                {
                    //相机类型
                    self.modalPresentationStyle= UIModalPresentationOverFullScreen;
                    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
                    [self setMediaTypes:@[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie]];
                }
                else
                {
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"无法调取你的手机相机，请检查你的手机" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                                {
                                                    [self dismissViewControllerAnimated:YES completion:^{}];
                                                }]];
                    [videoDelegate presentViewController:alertController animated:YES completion:^{}];
                    
                }
            }
                break;
            case VideoSourceTypeHeadPortraitCamera:
            {
                if ([self isSourceTypeCamera])  //判断是否有相机
                {
                    //相机类型
                    self.modalPresentationStyle= UIModalPresentationOverFullScreen;
                    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
                    [self setMediaTypes:@[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie]];
                    [self setAllowsEditing:YES];
                }
                else
                {
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"无法调取你的手机相机，请检查你的手机" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                                {
                                                    [self dismissViewControllerAnimated:YES completion:^{}];
                                                }]];
                    [videoDelegate presentViewController:alertController animated:YES completion:^{}];
                    
                }
            }
                break;
            case VideoSourceTypeSavedPhotosAlbum:
            {
                //相机类型
                self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                self.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
                self.delegate = self;
                self.videoQuality = UIImagePickerControllerQualityTypeHigh;
                self.allowsEditing = YES;;
            }
                break;
            case VideoSourceTypeHeadPortraitSavedPhotosAlbum:
            {
                //相机类型
                [self setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
                [self setAllowsEditing:YES];
            }
                break;
        }
    }
    return self;
}


#pragma mark - Getter/Setter Method
#pragma mark - Delegate Method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:videoURL options:info];
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    
    //    AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    CMTime   time = [asset duration];
    int seconds = ceil(time.value/time.timescale);
    
    if (seconds > 60) {
        [XHShowHUD showNOHud:@"视频时长不能超过60S"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:YES completion:nil];
        });
        return;
    }
    
    //判断是否含有视频轨道
    BOOL hasVideoTrack = [tracks count] > 0;
    if (!hasVideoTrack) {
        [XHShowHUD showNOHud:@"请选择视频" delay:1.0f];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:YES completion:nil];
        });
        return;
    }
    NSLog(@"---%@",videoURL);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [self getVideoPreViewImage:videoURL];

    [self VideoCompressionWithUrlPath:videoURL compressCallBack:^(NSData *vedioData) {
        [XHShowHUD showOKHud:@"压缩成功"];
        if ([self.videoDelegate respondsToSelector:@selector(videoPickerControllerdidFinishPickingMediaWithImage:videoData:)])
        {
            [self.videoDelegate videoPickerControllerdidFinishPickingMediaWithImage:image videoData:vedioData];
        }
    } faliCallBack:^(NSError *error) {
        [XHShowHUD showNOHud:@"压缩失败"];
        NSLog(@"%@",error);
    }];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
//获取视频的第一帧
- (UIImage*) getVideoPreViewImage:(NSURL *)videoUrl
{
    AVURLAsset * asset = [AVURLAsset assetWithURL:videoUrl];
    NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:[videoUrl path] error:nil].fileSize;
    NSLog(@"%@",[NSString stringWithFormat:@"111111视频总大小:%.0fM",fileSize/(1024.0*1024)]);
    //    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
}

//压缩视频文件
- (void)VideoCompressionWithUrlPath:(NSURL *)vedioUrl compressCallBack:(void (^)(NSData *vedioData))successCallBack faliCallBack:(void (^)(NSError *error))faliCallBack
{
    NSString *sandboxPath = nil;
    //    [XCHUDTool showTextHud:@"正在压缩..."];
    [self creatSandBoxFilePathIfNoExist];
    //保存至沙盒路径
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *videoPath = [NSString stringWithFormat:@"%@/Video", pathDocuments];
    //    self.sandboxPath = [videoPath stringByAppendingPathComponent:@"123321"];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];// 用时间, 给文件重新命名, 防止视频存储覆盖,
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    sandboxPath = [videoPath stringByAppendingPathComponent:[NSString stringWithFormat:@"xuehuiVideo-%@.mov", [formater stringFromDate:[NSDate date]]]];
    
    //转码配置
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:vedioUrl options:nil];
    
    //AVAssetExportPresetMediumQuality可以更改，是枚举类型，官方有提供，更改该值可以改变视频的压缩比例
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = [NSURL fileURLWithPath:sandboxPath];
    //AVFileTypeMPEG4 文件输出类型，可以更改，是枚举类型，官方有提供，更改该值也可以改变视频的压缩比例
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        NSLog(@"%d",exportStatus);
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                dispatch_sync(dispatch_get_main_queue(), ^{
                    faliCallBack(exportError);
                });
                
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"视频转码成功");
                
                
                NSData *data = [NSData dataWithContentsOfFile:sandboxPath];
                //                _object.videoData = data;
                
                
                NSFileManager *fm = [NSFileManager defaultManager];
                NSDictionary *attri = [fm attributesOfItemAtPath:sandboxPath error:nil];
                NSLog(@"%@",[NSString stringWithFormat:@"2222视频总大小:%.0fKB",attri.fileSize/1024.0]);
                
                NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:sandboxPath error:nil].fileSize;
                NSLog(@"%@",[NSString stringWithFormat:@"23123123视频总大小:%.0fM",fileSize/(1024.0*1024)]);
                //                [picker dismissViewControllerAnimated:YES completion:nil];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    successCallBack(data);
                });
                break;
            }
        }
    }];
    
}
- (void)creatSandBoxFilePathIfNoExist
{
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSLog(@"databse--->%@",documentDirectory);
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //创建目录
    NSString *createPath = [NSString stringWithFormat:@"%@/Video", pathDocuments];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileImage is exists.");
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}



#pragma mark - Response Method




#pragma mark - Private Method
#pragma mark 以下三个方法是判断用户手机中是否有摄像头、相册和使用浏览模式显示相册
#pragma mark --- 图片库
-(BOOL)isSourceTypePhotosAlbum
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

#pragma mark --- 列表形式浏览目录
-(BOOL)isSourceTypePhotoLibrary
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark --- 相机
-(BOOL)isSourceTypeCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
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
