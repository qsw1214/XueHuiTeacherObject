//
//  XHAddressBookSection.h
//  daycareParent
//
//  Created by Git on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//


typedef NS_ENUM(NSInteger,XHAddressBookSectionMarktType)
{
    XHAddressBookSectionNormalType = 0,  //!< 未选中状态
    XHAddressBookSectionSelectType = 1,  //!< 选中状态
};




#import "BaseModel.h"
#import "XHAddressBookFrame.h"


@interface XHAddressBookSection : BaseModel


@property (nonatomic,strong) NSString *sectionTitle;  //!< 分组标题
@property (nonatomic,assign) XHAddressBookSectionMarktType markType;  //!< 选中状态
@property (nonatomic,strong) NSMutableArray <XHAddressBookFrame*> *itemArray; //!< 内容数组


#pragma mark 设置数据源数组
-(void)setArray:(NSMutableArray <XHAddressBookFrame*> *)array;




@end
