//
//  XHNoticeAllUniteContentView.m
//  daycareParent
//
//  Created by Git on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeAllUniteContentView.h"

@interface XHNoticeAllUniteContentView ()


@property (nonatomic,strong) UIImageView *allSelectControl; //!< 全部选择
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


-(void)setDescribe:(NSString *)describe
{
    _describe = describe;
    
    [self.describeLabel setText:describe];
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.allSelectControl setFrame:CGRectMake(10,(frame.size.height-20.0)/2.0 , 20.0, 20.0)];
    [self.titleLabel setFrame:CGRectMake(40.0, 0, (frame.size.width-50.0)/2.0, frame.size.height)];
    [self.describeLabel setFrame:CGRectMake(self.titleLabel.right, 0, self.titleLabel.width, self.titleLabel.height)];
    
    
}


-(void)setIsAction:(BOOL)isAction
{
    _isAction = isAction;
    if (isAction)
    {
        [self.allSelectControl setImage:[UIImage imageNamed:@"ico_allselect"]];
    }
    else
    {
        [self.allSelectControl setImage:[UIImage imageNamed:@"ico_allnoselect"]];
    }
    
}


#pragma mark - Getter / Setter
-(UIImageView *)allSelectControl
{
    if (!_allSelectControl)
    {
        _allSelectControl = [[UIImageView alloc]init];
        [_allSelectControl setImage:[UIImage imageNamed:@"ico_allnoselect"]];
        [_allSelectControl setContentMode:UIViewContentModeScaleAspectFit];
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
