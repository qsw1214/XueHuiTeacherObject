//
//  XHAddressBookSection.m
//  daycareParent
//
//  Created by Git on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddressBookSection.h"


@interface XHAddressBookSection ()

@property (nonatomic,strong) NSMutableArray <XHAddressBookFrame*> *markArray;  //!< 选中状态

@end

@implementation XHAddressBookSection


//-(void)setMarkType:(XHAddressBookSectionMarktType)markType
//{
////    [self.markArray setArray:self.itemArray];
//    switch (markType)
//    {
//        case XHAddressBookSectionNormalType:
//        {
//            [self.itemArray removeAllObjects];
//        }
//            break;
//        case XHAddressBookSectionSelectType:
//        {
//            [self.itemArray setArray:self.markArray];
//        }
//            break;
//    }
//}



/**
 设置数据源数组

 @param array 数据源数组
 */
-(void)setArray:(NSMutableArray <XHAddressBookFrame*> *)array
{
    [self.itemArray setArray:array];
    [self.markArray setArray:array];
}





#pragma mark - Getter / Setter
-(NSMutableArray<XHAddressBookFrame *> *)itemArray
{
    if (!_itemArray)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}


-(NSMutableArray<XHAddressBookFrame *> *)markArray
{
    if (!_markArray)
    {
        _markArray = [NSMutableArray array];
    }
    return _markArray;
}

@end
