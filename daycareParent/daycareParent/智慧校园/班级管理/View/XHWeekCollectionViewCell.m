//
//  XHWeekCollectionViewCell.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHWeekCollectionViewCell.h"

@interface XHWeekCollectionViewCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UILabel *describeLanel; //!< 描述标签



@end

@implementation XHWeekCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.describeLanel];
        
    }
    return self;
}




#pragma mark - Getter /  Setter
-(void)setItemObject:(XHWeekFrame*)object
{
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.describeLanel setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
   
    //!< 首先重置Frame
    switch (object.model.type)
    {
        case XHWeekTipType:
        {
            [self.titleLabel setFrame:CGRectMake(0, 0, object.itemSize.width, object.itemSize.height-0.5)];
            [self.describeLanel setFrame:CGRectMake(0, (object.itemSize.height-0.5), object.itemSize.width, 0.5)];
            
            
            switch (object.model.selectType)
            {
                case XHWeekNormalType:
                {
                    [self.describeLanel setBackgroundColor:[UIColor clearColor]];
                }
                    break;
                case XHWeekSelectType:
                {
                    [self.describeLanel setBackgroundColor:LineViewColor];
                }
                    break;
            }
            
        }
            break;
        case XHWeekSyllabusType:
        {
            [self.titleLabel setFrame:CGRectMake(0, 0, object.itemSize.width, (object.itemSize.height/2.0))];
            [self.describeLanel setFrame:CGRectMake(0, self.titleLabel.bottom, object.itemSize.width, self.titleLabel.height)];
            [self.describeLanel setText:object.model.describe];
             [self.contentView setBackgroundColor:[UIColor grayColor]];
            
        }
            break;
    }
    
    
    //!< 赋值
    [self.titleLabel setText:object.model.title];
}





-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}


-(UILabel *)describeLanel
{
    if (!_describeLanel)
    {
        _describeLanel = [[UILabel alloc]init];
        [_describeLanel setTextAlignment:NSTextAlignmentCenter];
        
    }
    return _describeLanel;
}




@end
