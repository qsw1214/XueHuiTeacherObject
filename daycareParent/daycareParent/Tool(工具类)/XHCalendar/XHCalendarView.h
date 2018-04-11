//
//  XHCalendarView.h
//  LXCalendar
//
//  Created by chenergou on 2017/11/2.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XHCalendarViewDelegate<NSObject>

-(void)getCalendarDateStr:(NSString *)dateStr;

@end

@interface XHCalendarView : ParentView

-(instancetype)initWithDelegate:(id)delegate;
-(void)show;
//选中的回调
@property(nonatomic,assign)id <XHCalendarViewDelegate> delegate;

@end
