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



@property (nonatomic,strong) BaseButtonControl *registerControl; //!< 日常点名
@property (nonatomic,strong) BaseButtonControl *homeworkControl; //!< 家庭作业
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
    }
    return _registerControl;
    
}



@end
