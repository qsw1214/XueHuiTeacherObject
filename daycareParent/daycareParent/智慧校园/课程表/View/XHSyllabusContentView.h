//
//  XHSyllabusContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "BaseMenuControl.h"
#import "XHClassListModel.h"
@interface XHSyllabusContentView : BaseControl
@property(nonatomic,strong)XHClassListModel *classListModel;
-(void)getModel:(XHClassListModel *)model;
@end
