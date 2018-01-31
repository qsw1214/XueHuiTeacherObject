//
//  XHHistoryHeadTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/18.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDayRollCallModel.h"
@interface XHHistoryHeadTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)UILabel *titleLabel;
-(void)setItemObject:(XHDayRollCallModel *)model;
@end
