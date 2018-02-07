//
//  VideoManager.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,VideoType)
{
    VideoSourceTypeCamera = 1,
    VideoSourceTypeHeadPortraitCamera = 2, //!< 前置摄像头
    VideoSourceTypeSavedPhotosAlbum = 3, //保存相册
    VideoSourceTypeHeadPortraitSavedPhotosAlbum = 4,
};

@protocol VideoManagerViewControllerDeletage <NSObject>

-(void)videoPickerControllerdidFinishPickingMediaWithImage:(UIImage*_Nullable)image videoData:(NSData *_Nonnull)videoData;

@end

@interface VideoManagerViewController : UIImagePickerController

@property (nonnull,nonatomic,strong) id <VideoManagerViewControllerDeletage> videoDelegate;

/**
 WithType:
 1.从照相机拍照
 2.从相册拾取视频
 */
-(nullable id)initWithVideoManageWithType:(VideoType)Type setDeletate:(nullable id)videoDelegate;
@end
