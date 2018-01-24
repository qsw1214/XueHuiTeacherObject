//
//  XHDayRollReasonTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDayRollCallModel.h"
@interface XHDayRollReasonTableViewCell : UITableViewCell
@property(nonatomic,strong)XHBaseLabel *titleLabel;
@property(nonatomic,strong)XHBackLabel *reasonLabel;
@property(nonatomic,strong)UIImageView *imageV;
-(void)setItemObject:(XHDayRollCallModel *)model;
@end
