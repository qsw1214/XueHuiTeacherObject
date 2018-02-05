//
//  XHAddressBookHelper.m
//  daycareParent
//
//  Created by Git on 2018/2/2.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddressBookHelper.h"

@implementation XHAddressBookHelper

static XHAddressBookHelper *addressBook = nil;

/**
 单例初始化方法
 
 @return 单例对象
 */
+ (instancetype)sharedAddressBook
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        addressBook = [[self alloc]init];
    });
    
    return addressBook;
    
}


#pragma mark 获取教师通讯录列表
/**
 获取教师通讯录列表
 
 @param succeedBlock 回调的通讯录数组succeedBlock
 */
-(void)getTeachersAddressBook:(SucceedBlock)succeedBlock
{
   
    if (addressBook.isTeachersAddressBook)
    {
        MAIN(^{
            succeedBlock(YES,addressBook.teachersAddressBookArray);
        });
        
    }
    else
    {
        XHNetWorkConfig *netWorkConfig = [[XHNetWorkConfig alloc]init];
        [netWorkConfig setObject:[XHUserInfo sharedUserInfo].schoolId forKey:@"schoolId"];
        [netWorkConfig postWithUrl:@"zzjt-app-api_notice001" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 [addressBook setIsTeachersAddressBook:YES];
                 NSDictionary *objectDictionary = [object objectItemKey:@"object"];
                 NSArray *itemArray = [objectDictionary objectItemKey:@"list"];
                 if ([NSObject isArray:itemArray])
                 {
                     [addressBook.teachersAddressBookArray setArray:itemArray];
                 }
                 
                 MAIN(^{
                     
                     succeedBlock(YES,addressBook.teachersAddressBookArray);
                 });
             }
             else
             {
                 succeedBlock(NO,addressBook.teachersAddressBookArray);
             }
         } error:^(NSError *error)
         {
             succeedBlock(NO,addressBook.teachersAddressBookArray);
         }];
    }
}



#pragma mark 获取家长通讯录列表
/**
 获取家长通讯录列表
 
 @param succeedBlock 回调的通讯录数组succeedBlock
 */
-(void)getParentsAddressBook:(SucceedBlockl)succeedBlock
{
    if (addressBook.isparentsAddressBook)
    {
        succeedBlock(YES,self.parentsAddressBookArray);
    }
    else
    {
        XHNetWorkConfig *netWorkConfig = [[XHNetWorkConfig alloc]init];
        [netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
        [netWorkConfig postWithUrl:@"zzjt-app-api_notice003" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 [addressBook setIsparentsAddressBook:YES];
                 NSArray *objectArray = [object objectItemKey:@"object"];
                 if ([NSObject isArray:objectArray])
                 {
                     
                     succeedBlock(YES,objectArray);
                 }
                 else
                 {
                     succeedBlock(YES,self.parentsAddressBookArray);
                 }
             }
             else
             {
                 succeedBlock(NO,self.parentsAddressBookArray);
             }
             
         } error:^(NSError *error)
         {
             succeedBlock(NO,self.parentsAddressBookArray);
         }];
    }
}


#pragma mark - Getter / Setter
-(NSMutableArray *)teachersAddressBookArray
{
    if (!_teachersAddressBookArray)
    {
        _teachersAddressBookArray = [NSMutableArray array];
    }
    return _teachersAddressBookArray;
}

-(NSMutableArray *)parentsAddressBookArray
{
    if (!_parentsAddressBookArray)
    {
        _parentsAddressBookArray = [NSMutableArray array];
    }
    return _parentsAddressBookArray;
}

@end
