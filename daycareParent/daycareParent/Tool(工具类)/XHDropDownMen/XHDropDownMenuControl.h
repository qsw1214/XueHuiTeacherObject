//
//  XHDropDownMenuControl.h
//  daycareParent
//
//  Created by Git on 2018/2/27.
//  Copyright © 2018年 XueHui. All rights reserved.
//

@protocol XHDropDownMenuControlDeletage <NSObject>

-(void)didSelectItemObjectAtIndexPath:(id)object;

@end





#import "BaseControl.h"
#import "XHDropDownMenuCell.h"


@interface XHDropDownMenuControl : BaseControl


-(instancetype)initWithDeletage:(id<XHDropDownMenuControlDeletage>)deletage;


-(void)show;




@end
