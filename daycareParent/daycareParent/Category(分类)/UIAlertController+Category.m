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
#import "XHBackgrounduserInfo.h"
@implementation UIAlertController (Category)

+(UIAlertController *)actionSheetWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    [[XHBackgrounduserInfo shared] getAdd:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i=0; i<titleArry.count; i++)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:titleArry[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[XHBackgrounduserInfo shared] getAdd:NO];
            indexBlock(i,titleArry[i]);
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[XHBackgrounduserInfo shared] getAdd:NO];
    }]];
    
    [controller presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}
+(UIAlertController *)addtextFeildWithController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    [[XHBackgrounduserInfo shared] getAdd:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入上课班级" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alertController.textFields.firstObject.text.length==0)
        {
            [XHShowHUD showNOHud:@"班级不能为空"];
        }
        else
        {
         indexBlock(0,alertController.textFields.firstObject.text);
        }
        [[XHBackgrounduserInfo shared] getAdd:NO];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[XHBackgrounduserInfo shared] getAdd:NO];
    }]];
    [controller presentViewController:alertController animated:YES completion:nil];

    return alertController;
}
+(UIAlertController *)alertWithmessage:(NSString *)message titlesArry:(NSArray *)titleArry controller:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    [[XHBackgrounduserInfo shared] getAdd:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i=0; i<titleArry.count; i++)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:titleArry[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          [[XHBackgrounduserInfo shared] getAdd:NO];
            indexBlock(i,titleArry[i]);
        }]];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
    return alertController;
}
+(void)alertClassListWith:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
   
    [[XHUserInfo sharedUserInfo] getClassList:^(BOOL isOK, NSMutableArray *classListArry) {
        if (isOK)
        {
            [[XHBackgrounduserInfo shared] getAdd:YES];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择班级列表" preferredStyle:UIAlertControllerStyleAlert];
            for (int i=0; i<classListArry.count; i++)
            {
                XHClassListModel *model=classListArry[i];
                [alertController addAction:[UIAlertAction actionWithTitle:model.gradeAndClassName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   [[XHBackgrounduserInfo shared] getAdd:NO];
                    indexBlock(i,model);
                }]];
            }
           [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [[XHBackgrounduserInfo shared] getAdd:NO];
           }]];
            [controller presentViewController:alertController animated:YES completion:nil];

        }
        else
        {
            
            [UIAlertController alertWithmessage:@"暂无数据" titlesArry:@[@"确定"] controller:controller indexBlock:^(NSInteger index, id object) {
                [[XHBackgrounduserInfo shared] getAdd:NO];
            }];
        }
    }];
    
    
}
+(void)alertSubjectListWithController:(UIViewController *)controller indexBlock:(indexBlock)indexBlock
{
    [[XHUserInfo sharedUserInfo] getSubjectList:^(BOOL isOK, NSMutableArray *subjectListArry) {
        if (isOK)
        {
              [[XHBackgrounduserInfo shared] getAdd:YES];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择科目列表" preferredStyle:UIAlertControllerStyleAlert];
            for (int i=0; i<subjectListArry.count; i++)
            {
                XHSubjectListModel *model=subjectListArry[i];
                [alertController addAction:[UIAlertAction actionWithTitle:model.subjectName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[XHBackgrounduserInfo shared] getAdd:NO];
                    indexBlock(i,model);
                }]];
            }
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             [[XHBackgrounduserInfo shared] getAdd:NO];
        }]];
            [controller presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
           
          [UIAlertController alertWithmessage:@"暂无数据" titlesArry:@[@"确定"] controller:controller indexBlock:^(NSInteger index, id object) {
            [[XHBackgrounduserInfo shared] getAdd:NO];
          }];
        }
    }];
    
   
}

@end
