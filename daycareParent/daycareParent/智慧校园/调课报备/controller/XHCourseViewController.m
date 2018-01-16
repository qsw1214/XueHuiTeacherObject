//
//  XHCourseViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCourseViewController.h"
#import "XHNewBulidViewController.h"
#import "XHHistoryViewController.h"
@interface XHCourseViewController ()
{
    XHNewBulidViewController *new;
    XHHistoryViewController *history;
    UIViewController *currentController;
    UISegmentedControl *_sc;
}
@end

@implementation XHCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"课程报备"];
    _sc = [[UISegmentedControl alloc] initWithItems:@[@"新建",@"记录"]];
    _sc.selectedSegmentIndex = 0;
    _sc.tintColor = [UIColor whiteColor];
    _sc.frame = CGRectMake(0, 0, 100, 28);
    _sc.center=CGPointMake(SCREEN_WIDTH/2.0, 42);
    [_sc addTarget:self action:@selector(changeMail:) forControlEvents:UIControlEventValueChanged];
    [kWindow addSubview:_sc];
    new = [[XHNewBulidViewController alloc] init];
    [self addChildViewController:new];
    history = [[XHHistoryViewController alloc] init];
    [self addChildViewController:history];
    currentController = new;
    [self.view  addSubview:new.view];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    [kWindow addSubview:_sc];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_sc removeFromSuperview];
}
- (void)changeMail:(UISegmentedControl *)control
{
    
    switch (control.selectedSegmentIndex) {
        case 1:
        {
            if (currentController == history) {
                return;
            }
            [self transitionFromViewController:currentController toViewController:history duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                CATransition *transtion = [CATransition animation];
                transtion.duration = 0.25;
                transtion.timingFunction = UIViewAnimationCurveEaseInOut;
                transtion.type = kCATransitionPush;
                transtion.subtype = kCATransitionFromRight;
                [[self.view layer] addAnimation:transtion forKey:@"animation"];
            } completion:^(BOOL finished) {
                currentController = history;
            }];
            break;
        }
        case 0:
        {
            if (currentController == new)
            {
                return;
            }
            [self transitionFromViewController:currentController toViewController:new duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                
                CATransition *transtion = [CATransition animation];
                transtion.duration = 0.25;
                transtion.timingFunction = UIViewAnimationCurveEaseInOut;
                transtion.type = kCATransitionPush;
                transtion.subtype = kCATransitionFromLeft;
                
                [[self.view layer] addAnimation:transtion forKey:@"animation"];
                
            } completion:^(BOOL finished) {
                currentController = new;
            }];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
