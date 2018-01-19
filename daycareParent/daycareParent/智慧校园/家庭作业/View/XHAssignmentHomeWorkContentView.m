//
//  XHAssignmentHomeWorkContentView.m
//  daycareParent
//
//  Created by Git on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAssignmentHomeWorkContentView.h"

@interface XHAssignmentHomeWorkContentView ()

@property (nonatomic,strong) BaseButtonControl *kindContent; //!< 类别
@property (nonatomic,strong) BaseButtonControl *addPhotoContent; //!< 类别
@property (nonatomic,strong) BaseTextView *inputContent; //!< 输入类型
@property (nonatomic,strong) BaseButtonControl *dateContent; //!< 日期
@property (nonatomic,strong) BaseButtonControl *submitContent; //!< 发布

@end

@implementation XHAssignmentHomeWorkContentView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews:YES];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    //类型
    [self.kindContent resetFrame:CGRectMake(0, 0, frame.size.width, 60.0)];
    [self.kindContent setTitleEdgeFrame:CGRectMake(10, 0, 60, self.kindContent.height) withNumberType:0 withAllType:NO];
    [self.kindContent setTitleEdgeFrame:CGRectMake(80, 0, (frame.size.width-110.0), self.kindContent.height) withNumberType:1 withAllType:NO];
    [self.kindContent setImageEdgeFrame:CGRectMake((self.kindContent.width-30.0), ((self.kindContent.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.kindContent resetLineViewFrame:CGRectMake(0, self.kindContent.height-0.5, self.kindContent.width, 0.5) withNumberType:0 withAllType:NO];
    //添加图片
    [self.addPhotoContent resetFrame:CGRectMake(10, self.kindContent.bottom+10.0,(frame.size.width-30.0)*(2.0/5.0) , 90)];
    [self.addPhotoContent setImageEdgeFrame:CGRectMake(0, 0, self.addPhotoContent.width, self.addPhotoContent.height) withNumberType:0 withAllType:NO];
    //添加食谱描述
    [self.inputContent resetFrame:CGRectMake(self.addPhotoContent.right+10.0,self.addPhotoContent.top, (frame.size.width-30.0)*(3.0/5.0), self.addPhotoContent.height)];
    //添加日期
    [self.dateContent resetFrame:CGRectMake(0, self.addPhotoContent.bottom+10.0, self.kindContent.width, self.kindContent.height)];
    [self.dateContent setTitleEdgeFrame:CGRectMake(10, 0, 60, self.dateContent.height) withNumberType:0 withAllType:NO];
    [self.dateContent setTitleEdgeFrame:CGRectMake(80.0, 0, (frame.size.width-110.0), self.dateContent.height) withNumberType:1 withAllType:NO];
    [self.dateContent setImageEdgeFrame:CGRectMake((self.dateContent.width-30.0), ((self.dateContent.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.dateContent resetLineViewFrame:CGRectMake(0, 0.0, self.dateContent.width, 0.5) withNumberType:0 withAllType:NO];
    [self.dateContent resetLineViewFrame:CGRectMake(0, self.dateContent.height-0.5, self.dateContent.width, 0.5) withNumberType:1 withAllType:NO];
    
    //发布
    [self.submitContent resetFrame:CGRectMake(10, self.dateContent.bottom+60.0, (self.dateContent.width-20.0), 50.0)];
    [self.submitContent setTitleEdgeFrame:CGRectMake(0, 0, self.submitContent.width, self.submitContent.height) withNumberType:0 withAllType:NO];
    
    
    //重新设置当前滚动视图的可滚动区域
    [self setContentSize:CGSizeMake(frame.size.width, self.submitContent.bottom+20.0)];
}




-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.kindContent];
        [self addSubview:self.addPhotoContent];
        [self addSubview:self.inputContent];
        [self addSubview:self.dateContent];
        [self addSubview:self.submitContent];
    }
}

#pragma mark - Getter / Setter
-(BaseButtonControl *)kindContent
{
    if (!_kindContent)
    {
        _kindContent = [[BaseButtonControl alloc]init];
        [_kindContent setNumberLabel:2];
        [_kindContent setNumberImageView:1];
        [_kindContent setNumberLineView:1];
        [_kindContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_kindContent setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_kindContent setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [_kindContent setTextColor:[UIColor grayColor] withTpe:1 withAllType:NO];
        [_kindContent setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_kindContent setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
        [_kindContent setText:@"类别" withNumberType:0 withAllType:NO];
        [_kindContent setText:@"请选择" withNumberType:1 withAllType:NO];
    }
    return _kindContent;
}

-(BaseButtonControl *)addPhotoContent
{
    if (!_addPhotoContent)
    {
        _addPhotoContent = [[BaseButtonControl alloc]init];
        [_addPhotoContent setNumberImageView:1];
        [_addPhotoContent setImage:@"img_recipecover" withNumberType:0 withAllType:NO];
        [_addPhotoContent setIconImageViewBackGroundColor:RGB(238, 238, 238) withNumberType:0 withAllType:NO];
    }
    return _addPhotoContent;
}

-(BaseTextView *)inputContent
{
    if (!_inputContent)
    {
        _inputContent = [[BaseTextView alloc]init];
        [_inputContent setPlaceholder:@"添加菜谱描述"];
        [_inputContent setLayerCornerRadius:2.0];
        [_inputContent setLayerBorderWidth:0.5];
        [_inputContent setBorderColor:LineViewColor];
    }
    return _inputContent;
}


-(BaseButtonControl *)dateContent
{
    if (!_dateContent)
    {
        _dateContent = [[BaseButtonControl alloc]init];
        [_dateContent setNumberLabel:2];
        [_dateContent setNumberImageView:1];
        [_dateContent setNumberLineView:2];
        [_dateContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_dateContent setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_dateContent setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
        [_dateContent setTextColor:[UIColor grayColor] withTpe:1 withAllType:NO];
        [_dateContent setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
        [_dateContent setText:@"时间" withNumberType:0 withAllType:NO];
        [_dateContent setText:@"2018-01-19" withNumberType:1 withAllType:NO];
        [_dateContent setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _dateContent;
}


-(BaseButtonControl *)submitContent
{
    if (!_submitContent)
    {
        _submitContent = [[BaseButtonControl alloc]init];
        [_submitContent setNumberLabel:1];
        [_submitContent setBackgroundColor:MainColor];
        [_submitContent setText:@"发布" withNumberType:0 withAllType:NO];
        [_submitContent setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_submitContent setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_submitContent setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_submitContent setLayerCornerRadius:5.0];
    }
    return _submitContent;
}

@end
