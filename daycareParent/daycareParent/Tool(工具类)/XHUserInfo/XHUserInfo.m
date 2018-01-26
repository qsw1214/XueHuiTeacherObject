//
//  XHUserInfo.m
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHUserInfo.h"

@implementation XHUserInfo

static XHUserInfo *userInfo = nil;

/**
 单例初始化方法
 
 @return 单例对象
 */
+ (instancetype)sharedUserInfo
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    userInfo = [[self alloc]init];
    });
    
   return userInfo;
    
}

-(void)setItemObject:(NSDictionary*)object
{
    _sessionId=[object objectItemKey:@"sessionId"];
    _token=[object objectItemKey:@"token"];
    NSDictionary *dic=[object objectItemKey:@"user"];
    _birthdate=[dic  objectItemKey:@"birthdate"];
    _headPic=[dic objectItemKey:@"headPic"];
    _ID=[dic objectItemKey:@"id"];
    _loginName=[dic objectItemKey:@"loginName"];
     _nickName=[dic objectItemKey:@"nickName"];
    _selfId=[dic objectItemKey:@"selfId"];
      _sex=[dic objectItemKey:@"sex"];
     _signature=[dic objectItemKey:@"signature"];
    _telphoneNumber=[dic objectItemKey:@"telphoneNumber"];
     _userType=[dic  objectItemKey:@"userType"];
    _loginIp=[dic objectItemKey:@"loginIp"];
    _isActive=[dic objectItemKey:@"isActive"];
    _isRoot=[dic objectItemKey:@"isRoot"];
    _schoolId=[dic objectItemKey:@"relationCode"];
    _primaryFamilyId=[[object objectItemKey:@"propValue"] objectItemKey:@"primaryFamilyId"];
    _guardianModel=[[XHGuardianInfo alloc] initWithDic:[[object objectItemKey:@"propValue"] objectItemKey:@"guardian"]];
    switch ([self.sex integerValue])
    {
        case 0:
        {
            _sexName=@"女";
        }
            break;
        case 1:
        {
            _sexName=@"男";
            
        }
            break;
    }
}

-(NSMutableArray *)childListArry
{
    if (!_childListArry)
    {
        _childListArry = [NSMutableArray array];
    }
    return _childListArry;
}


                  


@end
