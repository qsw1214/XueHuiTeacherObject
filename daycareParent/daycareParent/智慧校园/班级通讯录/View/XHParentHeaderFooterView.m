//
//  XHParentHeaderFooterView.m
//  daycareParent
//
//  Created by Git on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHParentHeaderFooterView.h"


@interface XHParentHeaderFooterView ()


@property (nonatomic,weak) id <XHParentHeaderFooterViewDeletage> deletage;


@end

@implementation XHParentHeaderFooterView

- (instancetype)initWithDeletage:(id)deletage
{
    self = [super initWithReuseIdentifier:HeaderSectionIdentifier];
    if (self)
    {
        [self addSubViews:YES];
        [self setDeletage:deletage];
    }
    return self;
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.contentView addSubview:self.sectionBar];
        [self.contentView setBackgroundColor:[UIColor redColor]];
    }
}

-(XHParentAddressBookSectionBar *)sectionBar
{
    if (!_sectionBar)
    {
        _sectionBar = [[XHParentAddressBookSectionBar alloc]init];
    }
    return _sectionBar;
}


-(void)resetFrame:(CGRect)frame
{
    [self.sectionBar resetFrame:frame];
    [self.sectionBar addTarget:self action:@selector(sectionBarAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setItemFrame:(XHAddressBookSection*)object
{
    [self.sectionBar setSection:object];
}


-(void)sectionBarAction:(XHParentAddressBookSectionBar*)sender
{
    if ([self.deletage respondsToSelector:@selector(sectionBarAction:)])
    {
        [self.deletage sectionBarAction:sender];
    }
}


@end
