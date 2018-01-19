//
//  XHAdvertisementControl.h
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园主页->内容承载视图->广告预览视图



#import <UIKit/UIKit.h>

@interface XHAdvertisementControl : UIControl

@property (nonatomic,strong) BaseButtonControl *registerControl; //!< 日常点名
@property (nonatomic,strong) BaseButtonControl *homeworkControl; //!< 家庭作业

-(instancetype)init;
-(void)resetFrame:(CGRect)frame;
-(void)setItemArray:(NSMutableArray*)itemArray;


@end
