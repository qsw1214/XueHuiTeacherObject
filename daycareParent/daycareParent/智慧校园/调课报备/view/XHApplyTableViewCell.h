//
//  XHApplyTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/18.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark-------------发起人显示--------------
@interface XHApplyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *selectImageV;
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)XHBaseLabel *nameLabel;
@property(nonatomic,strong)XHBackLabel *dateLabel;
@property(nonatomic,strong)XHBaseLabel *applyLabel;
@end
