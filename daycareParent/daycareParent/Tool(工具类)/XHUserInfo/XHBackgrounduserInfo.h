//
//  XHBackgroundView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHBackgrounduserInfo : NSObject
@property(nonatomic,strong)UIView *bgView;
+ (instancetype)shared;
-(void)getAdd:(BOOL)add;
@end
