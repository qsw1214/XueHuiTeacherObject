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
@property (nonatomic,strong) XHClassListModel *classModel; //!< 班级id

-(void)setItemObject:(id)object withBlock:(XHClassManageHeaderBoardBackBlock)block;


@end
