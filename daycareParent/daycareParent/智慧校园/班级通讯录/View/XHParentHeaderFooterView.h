//
//  XHParentHeaderFooterView.h
//  daycareParent
//
//  Created by Git on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHParentAddressBookSectionBar.h"


@protocol XHParentHeaderFooterViewDeletage <NSObject>

-(void)sectionBarAction:(XHParentAddressBookSectionBar*)sender;

@end



@interface XHParentHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong) XHParentAddressBookSectionBar *sectionBar;



-(instancetype)initWithDeletage:(id)deletage;

-(void)resetFrame:(CGRect)frame;

-(void)setItemFrame:(id)object;



@end
