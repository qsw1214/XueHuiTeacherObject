//
//  OSSImageUploader.h
//  daycareParent
//
//  Created by Git on 2018/02/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "OSSImageUploader.h"
#import <AliyunOSSiOS/OSSService.h>

@implementation OSSImageUploader
static NSString *const AccessKey = @"LTAIkxSxT02rGsIf";
static NSString *const SecretKey = @"Uh9QqhIbVNqs9Zk9TTdBdjEM74nvtC";
static NSString *const BucketName = @"ixuehui";
static NSString *const AliYunHost = @"img.ixuehui.cn";

+ (void)asyncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:YES complete:complete];
}

+ (void)syncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:NO complete:complete];
}

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    [self uploadImages:images isAsync:YES complete:complete];
}

+ (void)syncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    [self uploadImages:images isAsync:NO complete:complete];
}

+ (void)uploadImages:(NSArray<UIImage *> *)images isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey                                                                                                            secretKey:SecretKey];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:AliYunHost credentialProvider:credential];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = images.count;
    
    NSMutableArray *callBackNames = [NSMutableArray array];
    int i = 0;
    for (UIImage *image in images)
    {
        if (image)
        {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                //任务执行
                OSSPutObjectRequest * put = [OSSPutObjectRequest new];
                put.bucketName = BucketName;
                NSString *imageName = [XHHelper createGuid];
                put.objectKey = [NSString stringWithFormat:@"xh/%@",imageName];   //正式环境
                [callBackNames addObject:imageName];
                NSData *data = UIImageJPEGRepresentation(image, 0.3);
                put.uploadingData = data;
                
                OSSTask * putTask = [client putObject:put];
                [putTask waitUntilFinished]; // 阻塞直到上传完成
                if (!putTask.error)
                {
                    NSLog(@"upload object success!");
                }
                else
                {
                    NSLog(@"upload object failed, error: %@" , putTask.error);
                }
                if (isAsync)
                {
                    if (image == images.lastObject)
                    {
                        NSLog(@"upload object finished!");
                        if (complete)
                        {
                            complete([NSArray arrayWithArray:callBackNames] ,UploadImageSuccess);
                        }
                    }
                }
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
        }
        i++;
    }
    if (!isAsync) {
        [queue waitUntilAllOperationsAreFinished];
        NSLog(@"haha");
        if (complete) {
            if (complete) {
                complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
            }
        }
    }
}


@end
