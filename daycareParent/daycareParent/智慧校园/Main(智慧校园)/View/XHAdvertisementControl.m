//
//  XHAdvertisementControl.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAdvertisementControl.h"
#import "SDCycleScrollView.h"



@interface XHAdvertisementControl () <SDCycleScrollViewDelegate>




@property (nonatomic,strong) NSMutableArray *dataArray; //!< 数据数组
@property (nonatomic,strong) UIImageView *bannerView; //!< 弧度视图
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView; //!< 滚动视图


@end




@implementation XHAdvertisementControl



-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    NSArray *imagesURLStrings = @[@"placeholderImage",@"placeholderImage",@"placeholderImage"];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, frame.size.width, (frame.size.height-70.0)) shouldInfiniteLoop:YES imageNamesGroup:imagesURLStrings withCurrentPageDotImage:@"pageControlCurrentDot" withPageControlDot:@"pageControlDot"];
    [self.cycleScrollView setDelegate:self];
    [self.cycleScrollView setPageControlStyle:SDCycleScrollViewPageContolStyleAnimated];
    [self.cycleScrollView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self addSubview:self.cycleScrollView];
    [self addSubview:self.bannerView];
    [self.bannerView setFrame:CGRectMake(0, ((frame.size.height-70.0)-20.0),frame.size.width, 20.0)];
    [self setItemArray:self.dataArray];
    NSLog(@"%f=%f",self.bannerView.bottom,frame.size.height);
    //添加日常点名和发布作业
    [self.registerControl resetFrame:CGRectMake(40.0, (self.bannerView.bottom+15.0), ((frame.size.width-(40*3))/2.0), 40.0)];
    [self.registerControl setImageEdgeFrame:CGRectMake(10.0, 10.0, 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.registerControl setTitleEdgeFrame:CGRectMake(30.0, 0.0, self.registerControl.width-30.0, self.registerControl.height) withNumberType:0 withAllType:NO];
    [self.homeworkControl resetFrame:CGRectMake((self.registerControl.right+40), self.registerControl.top, self.registerControl.width, self.registerControl.height)];
    [self.homeworkControl setImageEdgeFrame:CGRectMake(10.0, 10.0, 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.homeworkControl setTitleEdgeFrame:CGRectMake(30.0, 0.0, self.homeworkControl.width-30.0, self.homeworkControl.height) withNumberType:0 withAllType:NO];
    [self addSubview:self.registerControl];
    [self addSubview:self.homeworkControl];
}


-(void)setItemArray:(NSMutableArray*)itemArray
{
    [self.cycleScrollView setImageURLStringsGroup:itemArray];
}



-(UIImageView *)bannerView
{
    if (_bannerView == nil)
    {
        _bannerView = [[UIImageView alloc]init];
        [_bannerView setImage:[UIImage imageNamed:@"bannerhu"]];
    }
    return _bannerView;
}


#pragma mark 日常点名
-(BaseButtonControl *)registerControl
{
    if (!_registerControl)
    {
        _registerControl = [[BaseButtonControl alloc]init];
        [_registerControl setNumberImageView:1];
        [_registerControl setNumberLabel:1];
        [_registerControl setBackgroundColor:RGB(140.0, 158.0, 255.0)];
        [_registerControl setImage:@"ico_name" withNumberType:0 withAllType:NO];
        [_registerControl setText:@"日常点名" withNumberType:0 withAllType:NO];
        [_registerControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_registerControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        
    }
    return _registerControl;
    
}

-(BaseButtonControl *)homeworkControl
{
    if (!_homeworkControl)
    {
        _homeworkControl = [[BaseButtonControl alloc]init];
        [_homeworkControl setNumberImageView:1];
        [_homeworkControl setNumberLabel:1];
        [_homeworkControl setBackgroundColor:RGB(140.0, 158.0, 255.0)];
        [_homeworkControl setImage:@"ico_release-homework" withNumberType:0 withAllType:NO];
        [_homeworkControl setText:@"发布作业" withNumberType:0 withAllType:NO];
        [_homeworkControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_homeworkControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        
    }
    return _homeworkControl;
    
}



@end
