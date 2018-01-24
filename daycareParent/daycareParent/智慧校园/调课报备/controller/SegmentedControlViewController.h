//
//  SegmentedControlViewController.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationView.h"
@interface SegmentedControlViewController : UIViewController
@property (nonatomic,strong) BaseNavigationView  *navigationView;
#pragma mark 初始化Tabbar自动隐藏
-(instancetype)initHiddenWhenPushHidden;


#pragma mark 设置按钮的样式
/**
 设置按钮的样式
 @param contentType 设置按钮的类型（标题、标题加图片、图片）
 @param itemType  设置那边的按钮 （左边、右边）
 @param iconName 图片的名字
 @param title 标题
 */
-(void)setItemContentType:(BaseNavigationControlItemContentType)contentType withItemType:(BaseNavigationControlItemType)itemType withIconName:(NSString*)iconName withTitle:(NSString*)title;

#pragma mark 设置按钮的隐藏类型
-(void)setItemContentItemHiddenWithType:(BaseNavigationControlItemHiddenType)hiddenType withHidden:(BOOL)hidden;
#pragma mark 设置标题颜色
-(void)setNavtionColor:(UIColor*)color;
#pragma mark 设置标题和数量
-(void)setSegmentedControlItems:(NSArray*)itemArry WithControllersArry:(NSArray *)controllersArry;
#pragma mark 设置左标题
-(void)setLeftItemTitle:(NSString*)title;
#pragma mark 设置右标题
-(void)setRightItemTitle:(NSString*)title;
#pragma mark 设置左右标题的颜色
-(void)setItemTextColor:(UIColor*)color withItemType:(BaseNavigationControlItemType)type;

#pragma mark 设置左图标
-(void)setLeftImageName:(NSString*)imageName;
#pragma mark 设置右图标
-(void)setRightImageName:(NSString*)imageName;


#pragma mark 左侧按钮相应的方法
-(void)letfItemAction:(BaseNavigationControlItem*)sender;

#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender;


#pragma mark 隐藏导航左右按钮
-(void)navtionItemHidden:(BaseNavigationControlItemType)item;

@end
