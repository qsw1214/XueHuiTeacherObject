//
//  ShootVideoViewController.h
//  VideoRecord
//
//  Created by guimingsu on 15/5/4.
//  Copyright (c) 2015年 guimingsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIView+Tools.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@class ShootVideoViewController;
@protocol ShootVideoViewControllerDelegate <NSObject>
- (void)videoStatrToMp4Finished:(NSData *)data image:(UIImage *)image;
@end

@interface ShootVideoViewController : UIViewController
@property (nonatomic,weak) id<ShootVideoViewControllerDelegate> delegate;

@property float totalTime; //视频总长度 默认10秒

@end
