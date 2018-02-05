//
//  XHNoticeUniteItemContentView.m
//  daycareParent
//
//  Created by Git on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeUniteItemContentView.h"
#import "XHNoticeRecipientGroupFrame.h"
#import "XHAddressBookHelper.h"


@interface XHNoticeUniteItemContentView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BaseButtonControl *confirmationControl;


@end



@implementation XHNoticeUniteItemContentView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews:YES];
    }
    return self;
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self addSubview:self.confirmationControl];
    }
}



-(void)setItemArray:(NSArray *)array
{
    [self.dataArray setArray:array];
    [self.tableView refreshReloadData];
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-50.0)];
    [self.confirmationControl resetFrame:CGRectMake(0, self.tableView.bottom, self.tableView.width, 50.0)];
    [self.confirmationControl setTitleEdgeFrame:CGRectMake(0, 0, self.confirmationControl.width, self.confirmationControl.height) withNumberType:0 withAllType:NO];
    
}

#pragma mark - Deletage Method
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}




- (XHNoticeRecipientGroupTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNoticeRecipientGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHNoticeRecipientGroupTableViewCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.deletage respondsToSelector:@selector(didSelectRowAtIndexObject:)])
    {
        [self.deletage didSelectRowAtIndexObject:[self.dataArray objectAtIndex:indexPath.row]];
    }
}




-(BaseButtonControl *)confirmationControl
{
    if (!_confirmationControl)
    {
        _confirmationControl = [[BaseButtonControl alloc]init];
        [_confirmationControl setBackgroundColor:MainColor];
        [_confirmationControl setNumberLabel:1];
        [_confirmationControl setText:@"确认选择" withNumberType:0 withAllType:NO];
        [_confirmationControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_confirmationControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_confirmationControl addTarget:self action:@selector(confirmationControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmationControl;
}



@end

