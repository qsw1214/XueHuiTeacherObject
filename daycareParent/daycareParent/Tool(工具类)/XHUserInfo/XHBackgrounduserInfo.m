//
//  XHBackgroundView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHBackgrounduserInfo.h"

@implementation XHBackgrounduserInfo
static XHBackgrounduserInfo *backgrounduserInfo = nil;

/**
 单例初始化方法
 
 @return 单例对象
 */
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        backgrounduserInfo = [[self alloc]init];
    });
    
    return backgrounduserInfo;
    
}
-(void)getAdd:(BOOL)add
{
    if (add)
    {
        [kWindow addSubview:self.bgView];
    }
    else
    {
        [_bgView  removeFromSuperview];
    }
}
-(UIView *)bgView
{
    if (_bgView==nil) {
        _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    }
    return _bgView;
}
@end
