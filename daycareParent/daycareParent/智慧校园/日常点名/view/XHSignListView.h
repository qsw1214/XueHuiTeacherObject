//
//  XHSignListView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentView.h"

@interface XHSignListView : ParentView
@property(nonatomic,strong)NSMutableArray *signControlArry;
-(void)getNosignCount:(NSInteger)nosignCount signCount:(NSInteger)signCount askforCount:(NSInteger)askforCount;
@end
