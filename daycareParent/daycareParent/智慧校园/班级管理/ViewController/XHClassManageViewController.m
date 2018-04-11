//
//  XHClassManageViewController.m
//  daycareParent
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassManageViewController.h"
#import "XHClassManageContentView.h"

@interface XHClassManageViewController ()

@property (nonatomic,strong) XHClassManageContentView *contentView; //!< 内容视图


@end

@implementation XHClassManageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom,SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    
    }
}


#pragma mark - Getter /  Setter
-(XHClassManageContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHClassManageContentView alloc]init];
    }
    return _contentView;
}


@end
