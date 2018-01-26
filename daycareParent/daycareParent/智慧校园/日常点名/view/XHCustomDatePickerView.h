//
//  XHDatePickerView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XHCustomDatePickerViewModelType)
{
    XHCustomDatePickerViewModelAllDayType = 0,   //!< 年月日
    XHCustomDatePickerViewModelMouthAndDayType=1, //!< 月日
};

@protocol XHCustomDatePickerViewDelegate <NSObject>

- (void)getDateStr:(NSString *)dateStr;


@end

@interface XHCustomDatePickerView : UIView
{
    NSString *_dateStr;
}
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)  UIDatePicker *datePickerView;
@property(nonatomic,assign)XHCustomDatePickerViewModelType modelyTpe;
@property(nonatomic,assign)id <XHCustomDatePickerViewDelegate> delegate;
-(void)setItemMaxiDate:(NSDate *)date;
-(void)setItemMiniDate:(NSDate *)date;
@end
