//
//  SegmentedControlViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "SegmentedControlViewController.h"

@interface SegmentedControlViewController ()
{
    UIViewController *_currentController;
    int _selectNumber;
}
@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@property (nonatomic,strong) NSArray *itemsArray; //!< 数组
@property (nonatomic,strong) NSArray *controllersArray; //!< 视图控制器数组

@end

@implementation SegmentedControlViewController
-(instancetype)initHiddenWhenPushHidden
{
    self = [super init];
    if (self)
    {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:RGB(235.0, 235.0, 235.0)];
    [self.navigationController.navigationBar setHidden:YES];
    [self setNavtionColor:MainColor];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setItemContentItemHiddenWithType:NavigationRightType withHidden:YES];
    [self setItemContentType:NavigationIconAndTitle withItemType:NavigationItemLeftType withIconName:@"ico_return" withTitle:@"返回"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [kWindow addSubview:self.navigationView];
    [kWindow addSubview:_segmentedControl];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_segmentedControl removeFromSuperview];
    [_navigationView removeFromSuperview];
}
#pragma mark 设置标题和数量
-(void)setSegmentedControlItems:(NSArray*)itemArry WithControllersArry:(NSArray *)controllersArry
{
    self.itemsArray=itemArry;
    [kWindow addSubview:self.segmentedControl];
    self.controllersArray=controllersArry;
    for (int i=0; i<self.controllersArray.count; i++) {
        UIViewController *vc=self.controllersArray[i];
        [self addChildViewController:vc];
        if (i==0) {
            [self.view addSubview:vc.view];
            _currentController=vc;
        }
    }
}
#pragma mark 设置按钮的样式
-(void)setItemContentType:(BaseNavigationControlItemContentType)contentType withItemType:(BaseNavigationControlItemType)itemType withIconName:(NSString*)iconName withTitle:(NSString*)title
{
    [self.navigationView setItemContentType:contentType withItemType:itemType withIconName:iconName withTitle:title];
}

#pragma mark 设置按钮的隐藏类型
-(void)setItemContentItemHiddenWithType:(BaseNavigationControlItemHiddenType)hiddenType withHidden:(BOOL)hidden
{
    [self.navigationView setItemContentItemHiddenWithType:hiddenType withHidden:hidden];
}
#pragma mark 设置标题的颜色
-(void)setNavtionColor:(UIColor*)color
{
    [self.navigationView setBackgroundColor:color];
}



#pragma mark 设置左右标题的颜色
-(void)setItemTextColor:(UIColor*)color withItemType:(BaseNavigationControlItemType)type
{
    [self.navigationView setItemTextColor:color withItemType:type];
}




#pragma mark 设置左标题
-(void)setLeftItemTitle:(NSString*)title
{
    [self.navigationView setLeftItemTitle:title];
}
#pragma mark 设置右标题
-(void)setRightItemTitle:(NSString*)title
{
    [self.navigationView setRightItemTitle:title];
}



#pragma mark 设置左图标
-(void)setLeftImageName:(NSString*)imageName
{
    [self.navigationView setLeftImageName:imageName];
}



#pragma mark 设置右图标
-(void)setRightImageName:(NSString*)imageName
{
    [self.navigationView setRightImageName:imageName];
}

#pragma mark 左侧按钮相应的方法
-(void)letfItemAction:(BaseNavigationControlItem*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    
}


#pragma mark 隐藏导航左右按钮
-(void)navtionItemHidden:(BaseNavigationControlItemType)item
{
    switch (item)
    {
        case NavigationItemLeftType:
        {
            [self.navigationView.letfItem setHidden:YES];
        }
            break;
        case NavigationItemRightype:
        {
            [self.navigationView.rightItem setHidden:YES];
        }
            break;
        case NavigationItemLeftAndRightype:
        {
            [self.navigationView.letfItem setHidden:YES];
            [self.navigationView.rightItem setHidden:YES];
        }
    }
}
-(UISegmentedControl *)segmentedControl
{
    if (_segmentedControl==nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:self.itemsArray];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.tintColor = [UIColor whiteColor];
        if (self.itemsArray.count<4) {
            _segmentedControl.frame = CGRectMake(0, 0, 50*self.itemsArray.count, 28);
        }
        else
        {
            _segmentedControl.frame = CGRectMake(0, 0, 200, 28);
        }
        _segmentedControl.center=CGPointMake(SCREEN_WIDTH/2.0, 42);
        [_segmentedControl addTarget:self action:@selector(changeMail:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}
-(BaseNavigationView *)navigationView
{
    if (_navigationView == nil)
    {
        _navigationView = [[BaseNavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0)];
        [_navigationView.letfItem addTarget:self action:@selector(letfItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView.rightItem addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationView;
}

-(NSArray *)itemsArray
{
    if (_itemsArray == nil)
    {
        _itemsArray = [NSArray array];
    }
    return _itemsArray;
}
- (void)changeMail:(UISegmentedControl *)control
{
    
    for (int i=0; i<self.controllersArray.count; i++)
    {
        UIViewController *vc=self.controllersArray[i];
        if (control.selectedSegmentIndex==i) {
            
            if (_currentController == vc)
            { return; }
            if (_selectNumber<i)
            {
                [self transitionFromViewController:_currentController toViewController:vc duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    CATransition *transtion = [CATransition animation];
                    transtion.duration = 0.25;
                    transtion.type = kCATransitionPush;
                    transtion.subtype = kCATransitionFromRight;
                    [[self.view layer] addAnimation:transtion forKey:@"animation"];
                    
                    
                    
                } completion:^(BOOL finished) {
                    _currentController = vc;
                }];
                
            }
            else
            {
                [self transitionFromViewController:_currentController toViewController:vc duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                CATransition *transtion = [CATransition animation];
                transtion.duration = 0.25;
                transtion.type = kCATransitionPush;
                transtion.subtype = kCATransitionFromLeft;

                [[self.view layer] addAnimation:transtion forKey:@"animation"];
                    
                                } completion:^(BOOL finished) {
                                    _currentController = vc;
                                }];
            }
            _selectNumber=(int)control.selectedSegmentIndex;
        }

    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
