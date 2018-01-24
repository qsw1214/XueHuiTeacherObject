//
//  XHDatePickerView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHCustomDatePickerViewDelegate <NSObject>

- (void)getDateStr:(NSString *)dateStr;

@end

@interface XHCustomDatePickerView : UIView
{
    UIDatePicker *datePickerView;
    NSString *_dateStr;
}
@property(nonatomic,strong)UIView *view;
@property(nonatomic,assign)id <XHCustomDatePickerViewDelegate> delegate;
@end
