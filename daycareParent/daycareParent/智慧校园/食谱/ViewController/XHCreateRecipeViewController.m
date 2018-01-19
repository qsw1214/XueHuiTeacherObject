//
//  XHCreateRecipeViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCreateRecipeViewController.h"
#import "XHCreateRecipeContentView.h"


@interface XHCreateRecipeViewController ()

@property (nonatomic,strong) XHCreateRecipeContentView *contentView;  //!< 创建食谱内容视图





@end

@implementation XHCreateRecipeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"发布食谱"];
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
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
    }
}



#pragma mark - Getter / Setter
-(XHCreateRecipeContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHCreateRecipeContentView alloc]init];
    }
    return _contentView;
}


@end
