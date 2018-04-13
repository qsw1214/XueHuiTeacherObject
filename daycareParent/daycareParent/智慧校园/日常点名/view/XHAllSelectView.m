//
//  XHAllSelectView.m
//  daycareParent
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAllSelectView.h"

@implementation XHAllSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        label.backgroundColor=RGB(224, 224, 224);
        [self addSubview:label];
        for (int i=0; i<4; i++) {
            ParentControl *btn=[[ParentControl alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH/4.0, 0, SCREEN_WIDTH/4.0, 50)];
            btn.tag=50+i;
            [btn addTarget:self action:@selector(selectBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [btn setNumberLabel:1];
            switch (i) {
                case 0:
                {
                    [btn setNumberImageView:1];
                    [btn setImageViewCGRectMake:CGRectMake(10, 15, 20, 20) withNumberIndex:0];
                    [btn setImageViewName:@"dot_all" withNumberIndex:0];
                    [btn setLabelCGRectMake:CGRectMake(40, 0, btn.width-40, 50) withNumberIndex:0];
                    [btn setLabelText:@"全选" withNumberIndex:0];
                    [btn setLabelTextColor:RGB(87, 211, 171) withNumberIndex:0];
                }
                    break;
                case 1:
                {
                    [btn setLabelCGRectMake:CGRectMake(0, 0, btn.width, 50) withNumberIndex:0];
                    [btn setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
                    [btn setLabelText:@"已选0人" withNumberIndex:0];
                    [btn setLabelchageMarkColor:RGB(231, 160, 83) allColor:RGB(87, 211, 171) startString:@"选" endString:@"人" MarkFondSize:16 withNumberIndex:0];
                }
                    break;
                case 2:
                {
                    [btn setLabelCGRectMake:CGRectMake(0, 0, btn.width, 50) withNumberIndex:0];
                    [btn setLabelText:@"请假" withNumberIndex:0];
                    [btn setLabelBackgroundColor:RGB(231, 160, 83) withNumberIndex:0];
                    [btn setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
                    [btn setLabelTextColor:[UIColor whiteColor] withNumberIndex:0];
                }
                    break;
                case 3:
                {
                    [btn setLabelCGRectMake:CGRectMake(0, 0, btn.width, 50) withNumberIndex:0];
                    [btn setLabelText:@"签到" withNumberIndex:0];
                    [btn setLabelBackgroundColor:RGB(68, 196, 155) withNumberIndex:0];
                    [btn setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
                    [btn setLabelTextColor:[UIColor whiteColor] withNumberIndex:0];
                }
                    break;
            }
            [self addSubview:btn];
        }
    }
    return self;
}
-(void)selectNumber:(NSInteger)selectNumber withDataArry:(NSMutableArray *)dataArry
{
    ParentControl *selectbtn=[self viewWithTag:50];
    ParentControl *btn=[self viewWithTag:51];
    [btn setLabelText:[NSString stringWithFormat:@"已选%zd人",selectNumber] withNumberIndex:0];
    [btn setLabelchageMarkColor:RGB(231, 160, 83) allColor:RGB(87, 211, 171) startString:@"选" endString:@"人" MarkFondSize:16 withNumberIndex:0];
    if (selectNumber!=0)
    {
        [selectbtn setImageViewName:@"dot_all" withNumberIndex:0];
    }
    else
    {
        selectbtn.selected=NO;
        [selectbtn setImageViewName:@"dot_no_all" withNumberIndex:0];
    }
}
-(void)selectBtnMethod:(ParentControl *)control
{
    if ([self.delegate respondsToSelector:@selector(getSelectControl:)])
    {
        [self.delegate getSelectControl:control];
    }
}
@end
