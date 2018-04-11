//
//  XHHomeWorkContentView.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园->家庭作业记录->内容承载视图


#import "BaseControl.h"
#import "XHHomeWorkTableViewCell.h"

@protocol XHHomeWorkContentViewDeletage <NSObject>


@optional

-(void)didSelectAtIndex:(XHHomeWorkFrame*)frame;

@end

@interface XHHomeWorkContentView : BaseControl


-(instancetype)initWithDeletage:(id)deletage;








@end
