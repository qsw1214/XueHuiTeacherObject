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
 班级列表

 @param controller 视图控制器
 @param indexBlock 选择班级对象block
 */
+(void)alertClassListWith:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;

/**
 科目列表

 @param controller 视图控制器
 @param indexBlock 选择科目对象block
 */
+(void)alertSubjectListWithController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;

/**
 actionSheet

 @param message message
 @param titleArry 列表
 @param controller 视图控制器
 @param indexBlock 选择对象block
 @return actionSheet
 */
+(UIAlertController *)actionSheetWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;

/**
 alertview

 @param message message
 @param titleArry 列表
 @param controller 视图控制器
 @param indexBlock 选择对象block
 @return alertview
 */
+(UIAlertController *)alertWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;
+(UIAlertController *)addtextFeildWithController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;
+(UIAlertController *)addtextFeildWithmessage:(NSString *)message controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock;
@end
