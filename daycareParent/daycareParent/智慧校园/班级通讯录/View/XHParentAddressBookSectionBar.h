//
//  XHParentAddressBookSectionBar.h
//  daycareParent
//
//  Created by Git on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHAddressBookSection.h"

@interface XHParentAddressBookSectionBar : BaseControl


@property (nonatomic,strong) XHAddressBookSection *section;



-(void)resetFrame:(CGRect)frame;
-(void)addSubViews:(BOOL)subview;


@end
