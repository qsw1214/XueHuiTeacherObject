//
//  UIAlertController+Category.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "UIAlertController+Category.h"
#import "XHClassListModel.h"
#import "XHSubjectListModel.h"
@implementation UIAlertController (Category)
+(UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message titlesArry:(NSArray *)titleArry alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle hiddenCancelButton:(BOOL)hiddenCancelButton cancleStyle:(UIAlertActionStyle)cancleStyle withController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertControllerStyle];
   
    for (int i=0; i<titleArry.count; i++)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:titleArry[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            indexBlock(i,titleArry[i]);
        }]];
    }
    if (!hiddenCancelButton) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:cancleStyle handler:^(UIAlertAction * _Nonnull action) {}]];
    }
    
    [controller presentViewController:alertController animated:YES completion:nil];
    return alertController;
}
+(UIAlertController *)alertClassListWithTitle:(NSString *)title message:(NSString *)message titlesArry:(NSArray *)titleArry alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle hiddenCancelButton:(BOOL)hiddenCancelButton cancleStyle:(UIAlertActionStyle)cancleStyle withController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i=0; i<titleArry.count; i++)
    {
        XHClassListModel *model=titleArry[i];
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@%@",model.grade,model.clazz] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            indexBlock(i,model);
        }]];
    }
    if (!hiddenCancelButton) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:cancleStyle handler:^(UIAlertAction * _Nonnull action) {}]];
    }
    
    [controller presentViewController:alertController animated:YES completion:nil];
    return alertController;
}
+(UIAlertController *)alertSubjectListWithTitle:(NSString *)title message:(NSString *)message titlesArry:(NSArray *)titleArry alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle hiddenCancelButton:(BOOL)hiddenCancelButton cancleStyle:(UIAlertActionStyle)cancleStyle withController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i=0; i<titleArry.count; i++)
    {
        XHSubjectListModel *model=titleArry[i];
        [alertController addAction:[UIAlertAction actionWithTitle:model.subjectName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            indexBlock(i,model);
        }]];
    }
    if (!hiddenCancelButton) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:cancleStyle handler:^(UIAlertAction * _Nonnull action) {}]];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
    return alertController;
}
@end
