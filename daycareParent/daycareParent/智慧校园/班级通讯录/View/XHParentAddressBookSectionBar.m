//
//  XHParentAddressBookSectionBar.m
//  daycareParent
//
//  Created by Git on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHParentAddressBookSectionBar.h"


@interface XHParentAddressBookSectionBar ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *markImageView;
@property (nonatomic,strong) UIView *lineView;



@end

@implementation XHParentAddressBookSectionBar




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews:YES];
    }
    return self;
}





-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.markImageView];
        [self addSubview:self.lineView];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    [self.titleLabel setFrame:CGRectMake(10, 0, frame.size.width*(2.0/3.0), frame.size.height)];
    [self.markImageView setFrame:CGRectMake((frame.size.width-30.0),(frame.size.height-15.0)/2.0 , 15.0, 15.0)];
    [self.lineView setFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
}


#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}


-(UIImageView *)markImageView
{
    if (!_markImageView)
    {
        _markImageView = [[UIImageView alloc]init];
        [_markImageView setImage:[UIImage imageNamed:@"ico_calssarrow"]];
        [_markImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _markImageView;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}


-(void)setSection:(XHAddressBookSection *)section
{
    _section = section;
    
    [self.titleLabel setText:section.sectionTitle];
    
    //根据数据模型类型设置图片的转动方向
    switch (section.markType)
    {
        case XHAddressBookSectionNormalType:
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.markImageView setTransform:CGAffineTransformMakeRotation(0)];
                
            }];
        }
            break;
        case XHAddressBookSectionSelectType:
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.markImageView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
                
            }];
        }
            break;
    }
}







@end
