//
//  XHSyllabusBoardControl.h
//  daycareParent
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"

typedef void (^XHSyllabusBackBlock) (CGFloat height,BOOL refresh);

@interface XHSyllabusBoardControl : BaseControl


-(void)setItemObject:(id)object withBlock:(XHSyllabusBackBlock)blcok;

@end
