//
//  UIAlertController+Category.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^indexBlock)(NSInteger index,id object);


typedef NS_ENUM(NSInteger,XHSubjectAndClassModelType)
{
    XHSubjectListModelType=1,//!< 科目列表

    XHClassListModelType=2,//!< 班级列表

}
;

@interface UIAlertController (Category)

/**
 班级列表提示框
 
 @param title 标题
 @param message 描述
 @param titleArry 详细列表
 @param alertControllerStyle 提示框格式
 @param hiddenCancelButton 是否隐藏取消按钮
 @param cancleStyle 取消按钮格式
 @param controller 当前视图控制器
 @param indexBlock 选择按钮index
 @return 班级列表提示框
 */
+(UIAlertController *)alertClassListWithTitle:(NSString *)title message:(NSString *)message titlesArry:(NSArray *)titleArry alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle hiddenCancelButton:(BOOL)hiddenCancelButton cancleStyle:(UIAlertActionStyle)cancleStyle withController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;

+(void)alertSubjectListWithController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;
+(UIAlertController *)actionSheetWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;
+(UIAlertController *)alertWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;
@end
