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
            scrollView.frame=CGRectMake(0, 0, [self getWidth], 30*arry.count);
        }
        else
        {
            scrollView.frame=CGRectMake(0, 0, [self getWidth], 30*5);
        }
        scrollView.contentSize=CGSizeMake([self getWidth], 30*arry.count);
        for (int i=0; i<arry.count; i++) {
            XHClassListModel *model = arry[i];
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 30*i, [self getWidth], 30)];
            self.backgroundColor=[UIColor whiteColor];
            btn.titleLabel.font=FontLevel2;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag=i+100;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"%@%@",model.grade,model.clazz] forState:UIControlStateNormal];
            [scrollView addSubview:btn];

        }
        [self getWidth];
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
-(CGFloat)getWidth
{
    NSMutableArray *originalArray=[NSMutableArray array];
    for (XHClassListModel *model in [XHUserInfo sharedUserInfo].classListArry)
    {
        CGFloat width=[self getCustomWidth:model.gradeAndClassName];
        [originalArray addObject:[NSString stringWithFormat:@"%f",width]];
    }
    NSComparator finderSort = ^(id string1,id string2)
    {
        
        if ([string1 floatValue] > [string2 floatValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 floatValue] < [string2 floatValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    
    //数组排序：
    NSArray *resultArray = [originalArray sortedArrayUsingComparator:finderSort];
    NSInteger width=[resultArray.lastObject integerValue];
    if (width<130)
    {
        if (width<50)
        {
            return 50.0;
        }
        else
        {
           return [resultArray.lastObject floatValue];
        }
        
    }
    else
    {
        return 130.0;
    }
     
}
-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:FontLevel2};
    
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
        return textSize.width+6;
}
@end
