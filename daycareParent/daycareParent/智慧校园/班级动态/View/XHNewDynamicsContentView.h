//
//  XHNewDynamicsContentView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseScrollView.h"

@protocol XHNewDynamicsContentViewDeletage <NSObject>

-(void)newDynamicsAction:(BaseButtonControl*)sender;

@end

typedef NS_ENUM(NSInteger,XHNewDynamicsContentModelType)
{
    XHNewDynamicsImgContentModelType=1,//!<  发送图片
    
    XHNewDynamicsVideoContentModelType=2,//!< 发送视频
    
};

@interface XHNewDynamicsContentView : BaseScrollView


@property (nonatomic,weak) id <XHNewDynamicsContentViewDeletage> dynamicsDynamicsDeletage;
@property (nonatomic,strong) NSData *videoData;//!< 视频data

@property(nonatomic,assign)XHNewDynamicsContentModelType modelType;
@property(nonatomic,strong)UIViewController *currentVC;
-(void)setItemArray:(NSMutableArray*)array;

@end
