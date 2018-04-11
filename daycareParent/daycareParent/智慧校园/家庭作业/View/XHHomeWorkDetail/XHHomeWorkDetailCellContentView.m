//
//  XHHomeWorkDetailCellContentView.m
//  daycareParent
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHHomeWorkDetailCellContentView.h"
#import "XHHomeWorkCollectionView.h"



@interface XHHomeWorkDetailCellContentView ()


@property (nonatomic,strong) UILabel *contentLabel; //!< 内容标签
@property (nonatomic,strong) UILabel *classTipLabel; //!< 班级提示标签
@property (nonatomic,strong) UILabel *classLabel; //!< 班级内容标签
@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) XHHomeWorkCollectionView *collectionView; //!< 图片内容视图




@end



@implementation XHHomeWorkDetailCellContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:YES];
        [self addSubview:self.dateLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.classTipLabel];
        [self addSubview:self.classLabel];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setItemFrame:(XHHomeWorkDetailsFrame*)frame
{
    switch (frame.model.contentType)
    {
        case XHHomeWorkTextType:
        {
            [self.contentLabel setFrame:CGRectMake(10.0, 10.0, frame.contentSize.width, frame.contentSize.height)];
            [self.classTipLabel setFrame:CGRectMake(self.contentLabel.left, (self.contentLabel.bottom+10.0), 50.0, 20.0)];
            [self.classLabel setFrame:CGRectMake(self.classTipLabel.right+10.0, self.classTipLabel.top, 100.0, self.classTipLabel.height)];
            
        }
            break;
        case XHHomeWorkTextAndImageType:
        {
            
        }
            break;
    }
}






#pragma mark - Getter /  Setter
-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc]init];
    }
    return _contentLabel;
}


-(UILabel *)dateLabel
{
    if (!_dateLabel)
    {
        _dateLabel = [[UILabel alloc]init];
    }
    return _dateLabel;
}


-(UILabel *)classLabel
{
    if (!_classLabel)
    {
        _classLabel = [[UILabel alloc]init];
    }
    return _classLabel;
}

-(UILabel *)classTipLabel
{
    if (!_classTipLabel)
    {
        _classTipLabel = [[UILabel alloc]init];
    }
    return _classTipLabel;
}


-(XHHomeWorkCollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[XHHomeWorkCollectionView alloc]init];
    }
    return _collectionView;
}







@end
