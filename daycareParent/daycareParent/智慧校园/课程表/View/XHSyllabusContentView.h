//
//  XHSyllabusContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "BaseMenuControl.h"
#import "XHChildListModel.h"
#import "XHClassListModel.h"
@interface XHSyllabusContentView : BaseControl
@property(nonatomic,strong)XHChildListModel *childModel;
-(void)getModel:(XHChildListModel *)model;
-(void)getClassListModel:(XHClassListModel *)classListModel;
@end
