//
//  XHAllSelectView.h
//  daycareParent
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentView.h"

@protocol XHAllSelectViewDelegate<NSObject>

-(void)getSelectControl:(ParentControl *)control;

@end

@interface XHAllSelectView : ParentView

@property(nonatomic,assign)id<XHAllSelectViewDelegate>delegate;
-(void)selectNumber:(NSInteger)selectNumber withDataArry:(NSMutableArray *)dataArry;
@end
