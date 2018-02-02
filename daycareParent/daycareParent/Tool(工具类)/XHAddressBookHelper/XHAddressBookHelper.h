//
//  XHAddressBookHelper.h
//  daycareParent
//
//  Created by Git on 2018/2/2.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SucceedBlock)(BOOL isOK,NSArray *array);

@interface XHAddressBookHelper : NSObject

@property(nonatomic,assign) BOOL isTeachersAddressBook;//!< 是否请求过教师通讯录列表
@property(nonatomic,assign) BOOL isparentsAddressBook;//!< 是否请求过家长通讯录列表

@property (nonatomic,strong) NSMutableArray *teachersAddressBookArray; //!< 教师通讯录
@property (nonatomic,strong) NSMutableArray *parentsAddressBookArray;  //!< 家长通讯录


/**
 单例初始化方法
 
 @return 单例对象
 */


+ (instancetype)sharedAddressBook;


#pragma mark 获取教师通讯录列表
/**
 获取教师通讯录列表
 
 @param block 回调的通讯录数组block
 */
-(void)getTeachersAddressBook:(SucceedBlock)block;



#pragma mark 获取家长通讯录列表
/**
 获取家长通讯录列表
 
 @param block 回调的通讯录数组block
 */
-(void)getParentsAddressBook:(SucceedBlock)block;


@end
