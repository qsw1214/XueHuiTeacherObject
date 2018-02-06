//
//  XHAchievementContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHXHAchievementCell.h"
@interface XHAchievementContentView : BaseControl

@property(nonatomic,strong)XHClassListModel *classListModel;
-(void)getModel:(XHClassListModel *)model withIndex:(NSInteger)index;
@end
