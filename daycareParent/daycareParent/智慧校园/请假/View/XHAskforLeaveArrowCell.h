//
//  XHAskforLeaveArrowCell.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseControl.h"

@interface XHAskforLeaveArrowCell : BaseControl


@property (nonatomic,strong) XHChildListModel *model;
@property (nonatomic,strong) UIView *topLineView; //!< 上面的分割线
@property (nonatomic,strong) UIView *bottomLineView; //!< 下面的分割线
@property (nonatomic,strong) UILabel *describeLabel; //!< 描述标题


/**
 设置标题

 @param title 标题内容
 */
-(void)setTitle:(NSString*)title;

/**
 设置图标

 @param imageName 图标名称
 */
-(void)setImageName:(NSString*)imageName;

/**
 设置描述

 @param describe 描述内容
 */
-(void)setDescribe:(NSString*)describe;


/**
 获取描述标题

 @return 描述标题
 */
-(NSString*)describe;





@end
