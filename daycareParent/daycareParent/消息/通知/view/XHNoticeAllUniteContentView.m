//
//  XHNoticeAllUniteContentView.m
//  daycareParent
//
//  Created by Git on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeAllUniteContentView.h"

@interface XHNoticeAllUniteContentView ()


@property (nonatomic,strong) BaseButtonControl *allSelectControl; //!< 全部选择
@property (nonatomic,strong) UILabel *titleLabel;  //!< 标题
@property (nonatomic,strong) UILabel *describeLabel;  //<!描述





@end

@implementation XHNoticeAllUniteContentView


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
        [self addSubview:self.allSelectControl];
        [self addSubview:self.titleLabel];
        [self addSubview:self.describeLabel];
    }
}

-(void)addAllSelectTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.allSelectControl addTarget:target action:action forControlEvents:controlEvents];
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.allSelectControl resetFrame:CGRectMake(0, 0,40.0, frame.size.height)];
    [self.allSelectControl setImageEdgeFrame:CGRectMake(10,(self.allSelectControl.height-20.0)/2.0 , 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.titleLabel setFrame:CGRectMake(40.0, 0, (frame.size.width-50.0)/2.0, frame.size.height)];
    [self.describeLabel setFrame:CGRectMake(self.titleLabel.right, 0, self.titleLabel.width, self.titleLabel.height)];
    
    
}


#pragma mark - Getter / Setter
-(BaseButtonControl *)allSelectControl
{
    if (!_allSelectControl)
    {
        _allSelectControl = [[BaseButtonControl alloc]init];
        [_allSelectControl setNumberImageView:1];
        [_allSelectControl setImage:@"ico_allnoselect" withNumberType:0 withAllType:NO];
    }
    return _allSelectControl;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:FontLevel2];
        [_titleLabel setText:@"全选"];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setFont:FontLevel2];
        [_describeLabel setText:@"全选"];
        [_describeLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _describeLabel;
}




@end
