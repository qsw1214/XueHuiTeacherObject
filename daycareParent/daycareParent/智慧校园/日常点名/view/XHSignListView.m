//
//  XHSignListView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSignListView.h"
#import "XHDayRollCallModel.h"
#define SIGN_TITLE @[@"未签到",@"已签到",@"请假"]
@implementation XHSignListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if (self=[super init])
    {
            self.baseView.backgroundColor=RGB(224, 224, 224);
            [self addSubview:self.baseView];
    }
    return self;
}
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    self.baseView.frame=CGRectMake(0, frame.size.height-1, frame.size.width, 1);
    for (int i=0; i<3; i++)
    {
        ParentControl *btn=[[ParentControl alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH/3.0, 0, SCREEN_WIDTH/3.0, 40)];
        [btn setNumberLabel:2];
         [btn setLabelCGRectMake:CGRectMake(0, 0, btn.width, btn.height-2) withNumberIndex:0];
        [btn setLabelText:SIGN_TITLE[i] withNumberIndex:0];
        [btn setLabelFont:kFont(16) withNumberIndex:0];
        [btn setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
        [btn setLabelTextColor:RGB(102, 102, 102) withNumberIndex:0];
        
        [btn setLabelCGRectMake:CGRectMake(btn.width*0.15, btn.height-2, btn.width*0.7, 2) withNumberIndex:1];
        btn.tag=1+i;
        if (i==0)
        {
            [btn setLabelTextColor:MainColor withNumberIndex:0];
            [btn setLabelBackgroundColor:MainColor withNumberIndex:1];
        }
        [self.signControlArry addObject:btn];
        [self addSubview:btn];
        
    }
}
-(void)setItemObjectArry:(NSMutableArray *)arry
{
    XHDayRollCallModel *model=arry.firstObject;
    switch (model.modelType) {
        case DayRollCallNOSignType:
        {
            ParentControl *control=[self viewWithTag:1];
            [control setLabelText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[0],arry.count] withNumberIndex:0];
            
        }
            break;
            
       case DayRollCallSignType:
        {
            ParentControl *control=[self viewWithTag:2];
            [control setLabelText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[1],arry.count] withNumberIndex:0];
        }
            break;
            case DayRollCallOtherType:
        {
            ParentControl *control=[self viewWithTag:3];
            [control setLabelText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[2],arry.count] withNumberIndex:0];
        }
            break;
    }
}
-(NSMutableArray *)signControlArry
{
    if (_signControlArry==nil) {
        _signControlArry=[[NSMutableArray alloc] init];
    }
    return _signControlArry;
}
@end
