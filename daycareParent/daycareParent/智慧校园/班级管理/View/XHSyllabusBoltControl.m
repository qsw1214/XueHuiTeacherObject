//
//  XHSyllabusBoltControl.m
//  daycareParent
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSyllabusBoltControl.h"



@interface XHSyllabusBoltControl ()

@property (nonatomic,strong) UIImageView *boltImageView; //!< 锚点图片视图
@property (nonatomic,strong) UIView *boltView; //!< 锚点边缘视图


@end




@implementation XHSyllabusBoltControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.boltView];
        [self addSubview:self.boltImageView];
        
    }
    return self;
}




-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.boltImageView setFrame:CGRectMake(3.0, 3.0, frame.size.width-6.0, frame.size.height-6.0)];
    [self.boltView setFrame:CGRectMake(10.0, 0, frame.size.width-10.0, frame.size.height)];
    [self.boltView byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:(frame.size.height/2.0) withMasksToBounds:YES];
}


#pragma mark - Getter /  Setter
-(UIImageView *)boltImageView
{
    if (!_boltImageView)
    {
        _boltImageView = [[UIImageView alloc]init];
        [_boltImageView setImage:[UIImage imageNamed:@"ico_huan"]];
    }
    return _boltImageView;
}

-(UIView *)boltView
{
    if (!_boltView)
    {
        _boltView = [[UIView alloc]init];
        [_boltView setBackgroundColor:RGB(239,239,239)];
    }
    return _boltView;
}
@end
