//
//  XHDropDownMenuControl.h
//  daycareParent
//
//  Created by Git on 2018/2/27.
//  Copyright © 2018年 XueHui. All rights reserved.
//

@protocol XHDropDownMenuControlDeletage <NSObject>

-(void)didSelectItemObjectAtIndexPath:(id)object;


@end



typedef NS_ENUM(NSInteger ,DropType)
{
    DropLeftType  = 1,
    DropCenterType = 2,
    DropRightType  = 3,
};


#import "BaseControl.h"
#import "XHDropDownMenuCell.h"


@interface XHDropDownMenuControl : BaseControl


/**
 
 初始化并设置代理对象
 
 
 XHDropDownMenuControl *dorp = [[XHDropDownMenuControl alloc]initWithDeletage:self];
 
 
 NSMutableArray *tempArray = [NSMutableArray array];
 for (int i=0; i<10; i++)
 {
 XHDropDownMenuModel *model = [[XHDropDownMenuModel alloc]init];
 [model setTitle:@"一年级三班"];
 [model setObjectID:@"ADSFOP1903LSW"];
 [tempArray addObject:model];
 }
 
 [dorp setDataArray:tempArray];
 [dorp show];

 @param deletage 代理对象
 @param type 气泡弹框类型
 @return 返回该类实例对象
 */
-(instancetype)initWithDeletage:(id<XHDropDownMenuControlDeletage>)deletage withType:(DropType)type;




/**
 呈现在kwindows上
 */
-(void)show;




@end
