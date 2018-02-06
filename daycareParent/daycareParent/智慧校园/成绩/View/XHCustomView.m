//
//  XHCustomView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/20.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCustomView.h"

@implementation XHCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init
{
    if (self=[super init]) {
        NSArray *arry=[XHUserInfo sharedUserInfo].classListArry;
        UIScrollView *scrollView=[[UIScrollView alloc] init];
        [self addSubview:scrollView];
        if (arry.count<5) {
            scrollView.frame=CGRectMake(0, 0, 120, 30*arry.count);
        }
        else
        {
            scrollView.frame=CGRectMake(0, 0, 120, 30*5);
        }
        scrollView.contentSize=CGSizeMake(120, 30*arry.count);
        for (int i=0; i<arry.count; i++) {
            XHClassListModel *model = arry[i];
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 30*i, 120, 30)];
            self.backgroundColor=[UIColor whiteColor];
            btn.titleLabel.font=FontLevel2;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag=i+100;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"%@%@",model.grade,model.clazz] forState:UIControlStateNormal];
            [scrollView addSubview:btn];
//            UILabel *bgLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 30*i+29, 120, 1)];
//            bgLabel.backgroundColor=MainColor;
//            [scrollView addSubview:bgLabel];
//            self.layer.borderWidth=1;
//            self.layer.borderColor=MainColor.CGColor
        }
    }
    return self;
}
-(void)BtnClick:(UIButton *)btn
{
    XHClassListModel *model=[XHUserInfo sharedUserInfo].classListArry[btn.tag-100];
    if ([_delegate respondsToSelector:@selector(getClassListModel:withIndex:)]) {
        [_delegate getClassListModel:model withIndex:btn.tag-100];
        self.isExist=NO;
        [self removeFromSuperview];
    }
}

@end
