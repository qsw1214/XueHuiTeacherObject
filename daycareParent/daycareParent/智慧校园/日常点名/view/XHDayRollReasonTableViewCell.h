//
//  XHDayRollReasonTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,XHReasonModelType)
{
    XHDayRollCallDetailType=0,//!< 课程报备请假详情

    XHAskforLeaveDetailType=1,//!< 请假列表详情

};

@interface XHDayRollReasonTableViewCell : UITableViewCell
@property(nonatomic,strong)XHBaseLabel *titleLabel;
@property(nonatomic,strong)XHBackLabel *reasonLabel;
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,assign)XHReasonModelType modelType;
-(void)setItemObject:(id)object;
@end
