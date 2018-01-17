//
//  XHNewChageTypeTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/17.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XHNewChageTypeTableViewCell : UITableViewCell
@property (strong, nonatomic)  XHBaseLabel *titleLabel;//!< 标题标签

@property (strong, nonatomic)  XHBaseLabel *selectLabel;//!< 选择标签

@property(strong,nonatomic) BaseButtonControl *melodyBtn;//!< 调课

@property(strong,nonatomic) BaseButtonControl *otherBtn;//!< 代课

@end
