//
//  XHNewDynamicsViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewDynamicsViewController.h"
#import "XHNewDynamicsContentView.h"
@interface XHNewDynamicsViewController ()

@property (nonatomic,strong) XHNewDynamicsContentView *contentView;
@end

@implementation XHNewDynamicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"新增"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    switch (self.index) {
        case 0:
        {
            self.contentView.modelType=XHNewDynamicsImgContentModelType;
        }
            break;
            
        case 1:
        {
            self.contentView.modelType=XHNewDynamicsVideoContentModelType;
        }
            break;
    }
}
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        self.contentView.currentVC=self;
    }
}

#pragma mark - Getter / Setter
-(XHNewDynamicsContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHNewDynamicsContentView alloc]init];
    }
    return _contentView;
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
