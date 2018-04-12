//
//  XHIntelligentOfficeSignInView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeSignInView.h"
#import "XHSignCollectionViewCell.h"
@interface XHIntelligentOfficeSignInView()<UICollectionViewDelegate,
UICollectionViewDataSource>
@property(nonatomic,strong)ParentImageView *bgImageView;
@property(nonatomic,strong)ParentControl *signControl;
@property(nonatomic,strong)UIButton  *signHistoryButton;
@property(nonatomic,strong)ParentControl *signListControl;
@property(nonatomic,strong)UICollectionView *signListCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *colletionLayout;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation XHIntelligentOfficeSignInView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.bgImageView];
        [self addSubview:self.signControl];
        [self addSubview:self.signHistoryButton];
        [self addSubview:self.signListCollectionView];
    }
    return self;
}
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    self.signListCollectionView.frame=CGRectMake(5, frame.size.height-20-50, frame.size.width-85, 50);
    
    self.signHistoryButton.frame=CGRectMake(SCREEN_WIDTH-65-10, frame.size.height-20-40, 65, 30);
}
-(void)addTimer
{
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(function) userInfo:nil repeats:YES];
}
-(void)invalidate
{
    //取消定时器
    [self.timer invalidate];
    self.timer = nil;
}
-(void)function
{
    [self.signControl setLabelText:[NSDate getDateStrWithDateFormatter:HH_DEFAULT_TIME_FORM Date:[NSDate date]] withNumberIndex:1];
}
#pragma mark- 签到方法
-(void)controlMethod:(UIControl *)control
{
    kNSLog(@"时间签到");
}
#pragma mark- collectionDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XHSignCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItemObject:nil withIndexPathRow:indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (UI_SCREEN_WIDTH - 85) / 4;
    return CGSizeMake(width, width);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}
-(ParentImageView *)bgImageView
{
    if (_bgImageView==nil) {
        _bgImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 118)];
        _bgImageView.image=[UIImage imageNamed:@"pic_top"];
        [_bgImageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _bgImageView;
}
-(ParentControl *)signControl
{
    if (_signControl==nil) {
        _signControl=[[ParentControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2.0, 55, 100, 100)];
        _signControl.layer.cornerRadius=50;
        _signControl.layer.masksToBounds=YES;
        [_signControl setNumberImageView:1];
        [_signControl setImageViewCGRectMake:CGRectMake(0, 0, 100, 100) withNumberIndex:0];
        [_signControl setImageViewName:@"bg_qiandao" withNumberIndex:0];
       
        [_signControl setNumberLabel:2];
        
        
        [_signControl setLabelCGRectMake:CGRectMake(30, 25, 40, 15) withNumberIndex:0];
        [_signControl setLabelFont:kFont(16) withNumberIndex:0];
        [_signControl setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
        [_signControl setLabelTextColor:[UIColor whiteColor] withNumberIndex:0];
        [_signControl setLabelAlpha:0.6 withNumberIndex:0];
        [_signControl setLabelText:@"签到" withNumberIndex:0];
        
        [_signControl setLabelCGRectMake:CGRectMake(10, 50, 80, 20) withNumberIndex:1];
        [_signControl setLabelFont:kFont(27) withNumberIndex:1];
        [_signControl setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:1];
        [_signControl setLabelTextColor:[UIColor whiteColor] withNumberIndex:1];
        [_signControl setLabelText:[NSDate getDateStrWithDateFormatter:HH_DEFAULT_TIME_FORM Date:[NSDate date]] withNumberIndex:1];
        [_signControl setTag:1];
        [_signControl addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signControl;
}
-(ParentControl *)signListControl
{
    if (_signListControl==nil) {
        _signListControl=[[ParentControl alloc] init];
        [_signListControl setNumberLabel:9];
        [_signListControl setNumberImageView:4];
        
    }
    return _signListControl;
}
-(UICollectionView *)signListCollectionView
{
    if (_signListCollectionView==nil) {
        _signListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT) collectionViewLayout:self.colletionLayout];
        _signListCollectionView.delegate = self;
        _signListCollectionView.dataSource = self;
        _signListCollectionView.showsVerticalScrollIndicator = NO;
        _signListCollectionView.scrollsToTop = YES;
        _signListCollectionView.alwaysBounceVertical = YES;
        [_signListCollectionView registerClass:[XHSignCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _signListCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _signListCollectionView;
}

-(UICollectionViewFlowLayout *)colletionLayout{
    if (!_colletionLayout) {
        _colletionLayout = [[UICollectionViewFlowLayout alloc]init];
    }
    return _colletionLayout;
}
-(UIButton *)signHistoryButton
{
    if (_signHistoryButton==nil) {
        _signHistoryButton=[[UIButton alloc] init];
        _signHistoryButton.backgroundColor=MainColor;
        [_signHistoryButton setLayerCornerRadius:7.0];
        [_signHistoryButton setTitle:@"签到记录" forState:UIControlStateNormal];
        _signHistoryButton.titleLabel.font =kFont(14);
        [_signHistoryButton setTag:2];
        [_signHistoryButton addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _signHistoryButton;
}
-(NSMutableArray *)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
