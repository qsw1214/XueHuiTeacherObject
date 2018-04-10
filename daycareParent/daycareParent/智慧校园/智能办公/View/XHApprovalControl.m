//
//  XHApprovalControl.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHApprovalControl.h"

@interface XHApprovalControl ()


@property (nonatomic,strong) UIImageView *tipImageView; //!< 提醒图片视图
@property (nonatomic,strong) UILabel *tipLabel; //!< 提醒标签




@end

@implementation XHApprovalControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tipImageView];
        [self addSubview:self.tipLabel];
    }
    return self;
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.tipImageView setFrame:CGRectMake(10.0, 10.0, 20.0, 20.0)];
    [self.tipLabel setFrame:CGRectMake(self.tipImageView.right+10.0, 0, (frame.size.width-(self.tipImageView.right+20.0)), frame.size.height)];
    
}

#pragma mark - Getter /  Setter
-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setText:@"审批提醒"];
    }
    return _tipLabel;
}

-(UIImageView *)tipImageView
{
    if (!_tipImageView)
    {
        _tipImageView = [[UIImageView alloc]init];
    }
    return _tipImageView;
}



@end

