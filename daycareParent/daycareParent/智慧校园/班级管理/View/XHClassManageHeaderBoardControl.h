//
//  XHClassManageHeaderBoardControl.h
//  daycareParent
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#pragma mark - 班级管理头部面板

#import "BaseControl.h"


typedef void (^XHClassManageHeaderBoardBackBlock) (BOOL refresh);

@interface XHClassManageHeaderBoardControl : BaseControl


-(void)setItemObject:(id)object withBlock:(XHClassManageHeaderBoardBackBlock)block;

@end
