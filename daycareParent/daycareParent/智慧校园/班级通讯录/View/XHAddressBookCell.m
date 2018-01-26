//
//  XHAddressBookCell.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookCell.h"


@interface XHAddressBookCell ()

@property (nonatomic,strong) UIImageView *headerImageView; //!< 头像视图
@property (nonatomic,strong) UILabel *nameLabel; //!< 名字标签
@property (nonatomic,strong) UILabel *phoneLabel; //!< 手机标签
@property (nonatomic,strong) UIImageView *accessoryImageView; //!< 附件
@property (nonatomic,strong) XHAddressBookToolBar *teacherToolBar; //!< 教师工具条
@property (nonatomic,strong) XHParentAddressBookToolBar *parentToolBar;  //!< 家长工具条

@property (nonatomic,strong) UIView *lineView; //!< 分割线



@end




@implementation XHAddressBookCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:NO];
        [self addSubViews:YES];
    }
    return self;
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.accessoryImageView];
        [self.contentView addSubview:self.teacherToolBar];
        [self.contentView addSubview:self.parentToolBar];
        [self.contentView addSubview:self.lineView];
    }
}


-(void)setItemFrame:(XHAddressBookFrame*)frame
{
    [self.headerImageView setFrame:CGRectMake(10.0, 10.0, 40.0, 40.0)];
    [self.headerImageView setLayerCornerRadius:(self.headerImageView.height/2.0)];
    [self.accessoryImageView setFrame:CGRectMake(frame.itemFrame.size.width-20.0, (60.0-20.0)/2.0, 20.0, 20.0)];
    
    [self.nameLabel setFrame:CGRectMake(self.headerImageView.right+10.0,self.headerImageView.top ,frame.itemFrame.size.width-(self.headerImageView.right+self.accessoryImageView.width+20.0),20.0)];
    [self.phoneLabel setFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom, self.nameLabel.width, self.nameLabel.height)];
    
    
    [self.teacherToolBar resetFrame:CGRectMake(10.0, (self.headerImageView.bottom+5.0), frame.itemFrame.size.width, 45.0)];
    [self.parentToolBar resetFrame:self.teacherToolBar.frame];
    
    [self.lineView setFrame:CGRectMake(self.teacherToolBar.left,frame.itemFrame.size.height-0.5 , frame.itemFrame.size.width, 0.5)];
    
    
    [self.teacherToolBar setHidden:YES];
    [self.parentToolBar setHidden:YES];
    
    //根据数据模型类型设置图片的转动方向
    switch (frame.model.selectType)
    {
        case XHAddressBookModelNormalType:
        {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [self.accessoryImageView setTransform:CGAffineTransformMakeRotation(0)];
                
            }];
            
            switch (frame.model.modelType)
            {
                case XHAddressBookTeacherType:
                {
                    [self.teacherToolBar setHidden:YES];
                }
                    break;
                case XHAddressBookParentType:
                {
                    [self.parentToolBar setHidden:YES];
                }
                    break;
            }    
        }
            break;
        case XHAddressBookSelectType:
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                [self.accessoryImageView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
                
            }];
            
        
            switch (frame.model.modelType)
            {
                case XHAddressBookTeacherType:
                {
                    [self.teacherToolBar setHidden:NO];
                }
                    break;
                case XHAddressBookParentType:
                {
                    [self.parentToolBar setHidden:NO];
                }
                    break;
            }
            
          
        }
            break;
    }
    
    //赋值
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:frame.model.headerUrl] placeholderImage:[UIImage imageNamed:@"addman"]];
    [self.nameLabel setText:frame.model.teacherName];
    [self.phoneLabel setText:frame.model.phone];
    [self.teacherToolBar setItemFrame:frame];
    [self.parentToolBar setItemFrame:frame];
}








#pragma mark - Getter / Setter
-(UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc]init];
        [_headerImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _headerImageView;
}


-(UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setFont:FontLevel3];
        [_nameLabel setTextColor:RGB(14, 14, 14)];
    }
    return _nameLabel;
}


-(UILabel *)phoneLabel
{
    if (!_phoneLabel)
    {
        _phoneLabel = [[UILabel alloc]init];
        [_phoneLabel setFont:FontLevel3];
        [_phoneLabel setTextColor:RGB(14, 14, 14)];
    }
    return _phoneLabel;
}

-(UIImageView *)accessoryImageView
{
    if (!_accessoryImageView)
    {
        _accessoryImageView = [[UIImageView alloc]init];
        [_accessoryImageView setImage:[UIImage imageNamed:@"ico_arrow"]];
        [_accessoryImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _accessoryImageView;
}

-(XHAddressBookToolBar *)teacherToolBar
{
    if (!_teacherToolBar)
    {
        _teacherToolBar = [[XHAddressBookToolBar alloc]init];
        [_teacherToolBar setHidden:YES];
    }
    return _teacherToolBar;
}


-(XHParentAddressBookToolBar *)parentToolBar
{
    if (!_parentToolBar)
    {
        _parentToolBar = [[XHParentAddressBookToolBar alloc]init];
        [_parentToolBar setHidden:YES];
    }
    return _parentToolBar;
}


-(UIView *)lineView
{
    if (!_lineView )
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.headerImageView setBackgroundColor:[UIColor orangeColor]];
        [self.nameLabel setBackgroundColor:[UIColor purpleColor]];
        [self.phoneLabel setBackgroundColor:[UIColor magentaColor]];
        [self.teacherToolBar setBackgroundColor:[UIColor cyanColor]];
        [self.parentToolBar setBackgroundColor:[UIColor brownColor]];
        [self.accessoryImageView setBackgroundColor:[UIColor greenColor]];
    }
}
@end
