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

+(UIAlertController *)actionSheetWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i=0; i<titleArry.count; i++)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:titleArry[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            indexBlock(i,titleArry[i]);
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    
    [controller presentViewController:alertController animated:YES completion:nil];
    return alertController;
}
+(UIAlertController *)alertWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i=0; i<titleArry.count; i++)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:titleArry[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            indexBlock(i,titleArry[i]);
        }]];
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
+(void)alertSubjectListWithController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    [[XHUserInfo sharedUserInfo] getSubjectList:^(BOOL isOK, NSMutableArray *subjectListArry) {
        if (isOK)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择科目列表" preferredStyle:UIAlertControllerStyleAlert];
            for (int i=0; i<subjectListArry.count; i++)
            {
                XHSubjectListModel *model=subjectListArry[i];
                [alertController addAction:[UIAlertAction actionWithTitle:model.subjectName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    indexBlock(i,model);
                }]];
            }
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
            [controller presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            [UIAlertController alertWithmessage:@"暂无数据" titlesArry:@[@"确定"] controller:controller indexBlock:^(NSInteger index, id object) {
            }];
        }
    }];
    
   
}
@end
