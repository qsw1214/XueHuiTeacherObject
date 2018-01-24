//
//  XHDayRollCollectionViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDayRollCallModel.h"
@interface XHDayRollCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *headImgView;
@property(nonatomic,strong)XHBaseLabel *nameLabel;
@property(nonatomic,strong)UIImageView *selectImgView;
-(void)setItemObject:(XHDayRollCallModel *)model;
@end
