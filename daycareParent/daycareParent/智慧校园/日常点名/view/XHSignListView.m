//
//  XHSignListView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSignListView.h"
#import "XHDayRollCallModel.h"
#define SIGN_TITLE @[@"未到",@"已到",@"请假"]
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
            [self addSubview:btn];
            [self.signControlArry addObject:btn];
            
        }
    }
    return self;
}
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    self.baseView.frame=CGRectMake(0, frame.size.height-1, frame.size.width, 1);
}
-(void)getNosignCount:(NSInteger)nosignCount signCount:(NSInteger)signCount askforCount:(NSInteger)askforCount
{
    ParentControl *nosignControl=[self viewWithTag:1];
    [nosignControl setLabelText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[0],nosignCount] withNumberIndex:0];
    
    ParentControl *signControl=[self viewWithTag:2];
    [signControl setLabelText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[1],signCount] withNumberIndex:0];
    
    ParentControl *control=[self viewWithTag:3];
    [control setLabelText:[NSString stringWithFormat:@"%@(%zd)",SIGN_TITLE[2],askforCount] withNumberIndex:0];
}

-(NSMutableArray *)signControlArry
{
    if (_signControlArry==nil)
    {
        _signControlArry=[[NSMutableArray alloc] init];
    }
    return _signControlArry;
}
@end
