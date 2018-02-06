//
//  XHAssignmentHomeWorkCollectionViewCell.m
//  daycareParent
//
//  Created by Git on 2018/2/6.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAssignmentHomeWorkCollectionViewCell.h"

@interface XHAssignmentHomeWorkCollectionViewCell ()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) BaseButtonControl *deleteControl;


@end

@implementation XHAssignmentHomeWorkCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.deleteControl];
        [self.deleteControl resetFrame:CGRectMake(frame.size.width-30.0, 0.0, 30.0, 30.0)];
        [self.deleteControl setImageEdgeFrame:CGRectMake(10.0, 0.0, 20.0, 20.0) withNumberType:0 withAllType:NO];
        [self.imageView setFrame:CGRectMake(0, 5, (frame.size.width-10.0), (frame.size.height-10.0))];
    }
    return self;
}



-(void)setModel:(XHPreviewModel *)model
{
    _model = model;
    [self.imageView setImage:model.previewImage];
    [self.deleteControl setPreviewModel:model];
}



-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}

-(BaseButtonControl *)deleteControl
{
    if (!_deleteControl)
    {
        _deleteControl = [[BaseButtonControl alloc]init];
        [_deleteControl setNumberImageView:1];
        [_deleteControl setImage:@"ico_wrong" withNumberType:0 withAllType:NO];
        [_deleteControl addTarget:self action:@selector(deleteControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteControl;
}


-(void)deleteControlAction:(BaseButtonControl*)sender
{
    if ([self.deletage respondsToSelector:@selector(deleteControlAction:)])
    {
        [self.deletage deleteControlAction:sender.previewModel];
    }
    
}


@end
