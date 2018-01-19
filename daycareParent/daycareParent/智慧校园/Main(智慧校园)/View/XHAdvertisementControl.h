//
//  XHAdvertisementControl.h
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园主页->内容承载视图->广告预览视图


@protocol XHAdvertisementControlDeletage <NSObject>

-(void)advertisementAction:(BaseButtonControl*)sender;

@end


#import <UIKit/UIKit.h>

@interface XHAdvertisementControl : UIControl


@property (nonatomic,weak) id <XHAdvertisementControlDeletage> deletage;//!< 代理对象




-(instancetype)init;
-(void)resetFrame:(CGRect)frame;
-(void)setItemArray:(NSMutableArray*)itemArray;


@end
