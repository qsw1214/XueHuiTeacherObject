//
//  XHClassManageViewController.m
//  daycareParent
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassManageViewController.h"
#import "XHClassManageContentView.h"

@interface XHClassManageViewController () <XHDropDownMenuControlDeletage>

@property (nonatomic,strong) XHClassManageContentView *contentView; //!< 内容视图
@property (nonatomic,strong) BaseButtonControl *dropDownControl; //!< 下来菜单


@end

@implementation XHClassManageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionColor:MainColor];
    [self setItemContentItemHiddenWithType:NavigationLeftType withHidden:YES];
    
    @WeakObj(self);
    [[XHUserInfo sharedUserInfo] getClassList:^(BOOL isOK, NSMutableArray *classListArry)
     {
         @StrongObj(self);
         if ([classListArry count])
         {
             XHClassListModel *model = [classListArry firstObject];
             [self.dropDownControl setHidden:NO];
             [self.dropDownControl setText:model.gradeAndClassName withNumberType:0 withAllType:NO];
             [self.contentView setItemObject:model];
         }
     }];
    
    
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
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom,SCREEN_WIDTH, (SCREEN_HEIGHT-self.navigationView.height-50.0))];
        [self.view addSubview:self.dropDownControl];
    
        [self.dropDownControl resetFrame:CGRectMake(0, self.navigationView.bottom-44.0, self.navigationView.width, 44.0)];
        [self.dropDownControl setTitleEdgeFrame:CGRectMake(0, 0, (SCREEN_WIDTH/2.0+60.0), 44.0) withNumberType:0 withAllType:NO];
        [self.dropDownControl setImageEdgeFrame:CGRectMake((SCREEN_WIDTH/2.0+65.0), (self.dropDownControl.height-15.0)/2.0, 15.0, 15.0) withNumberType:0 withAllType:NO];
    }
}


#pragma mark - Private Method
#pragma mark 切换班级
-(void)dropDownControlAction:(BaseButtonControl*)sender
{
    
    NSMutableArray *itt = [NSMutableArray array];
    [[XHUserInfo sharedUserInfo] getClassList:^(BOOL isOK, NSMutableArray *classListArry)
     {
         if (isOK)
         {
             [NSArray enumerateObjectsWithArray:classListArry usingBlock:^(XHClassListModel *obj, NSUInteger idx, BOOL *stop)
             {
                 
                 XHDropDownMenuModel *model = [[XHDropDownMenuModel alloc]init];
                 [model setTitle:obj.gradeAndClassName];
                 [model setObjectID:obj.clazzId];
                 [model setModel:obj];
                 [itt addObject:model];
             }];
             
             
             XHDropDownMenuControl *drop = [[XHDropDownMenuControl alloc]initWithDeletage:self withType:DropCenterType];
             [drop setItemArray:itt];
             
             [drop show];
         }
         
         
     }];
}



#pragma mark - Delegate Method
#pragma mark XHDropDownMenuControlDeletage
-(void)didSelectItemObjectAtIndexPath:(XHDropDownMenuModel*)object
{
    [self.contentView setItemObject:object.model];
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



-(BaseButtonControl *)dropDownControl
{
    if (!_dropDownControl)
    {
        _dropDownControl = [[BaseButtonControl alloc]init];
        [_dropDownControl setNumberLabel:1];
        [_dropDownControl setNumberImageView:1];
        [_dropDownControl setImage:@"ico_changeclass" withNumberType:0 withAllType:NO];
        [_dropDownControl addTarget:self action:@selector(dropDownControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_dropDownControl setTextAlignment:NSTextAlignmentRight withNumberType:0 withAllType:NO];
        [_dropDownControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_dropDownControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        
    }
    return _dropDownControl;
}

@end
