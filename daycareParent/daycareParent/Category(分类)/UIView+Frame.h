
//  Created by Caoyq on 16/5/4.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import <UIKit/UIKit.h>




//以iphone5为基础 坐标都以iphone5为基准 进行代码的适配
//#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat left;



#pragma mark 设置layer的弧度
/**
 设置layer的弧度
 @param radius layer的弧度
 */
-(void)setLayerCornerRadius:(CGFloat)radius;

-(void)setLayerCornerRadius:(CGFloat)radius withMasksToBounds:(BOOL)masksToBounds;



//subLayer.frame=self.boardControl.frame;
//
//subLayer.cornerRadius=8;
//
//subLayer.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
//
//subLayer.masksToBounds=NO;
//
//subLayer.shadowColor=[UIColor grayColor].CGColor;
//
//subLayer.shadowOffset=CGSizeMake(10,10);
//
//subLayer.shadowOpacity=0.5;
//
//subLayer.shadowRadius=8;




#pragma mark 圆角和阴影并存
/**
 圆角和阴影并存

 @param radius 圆角半径
 @param backgroundColor 阴影的背景颜色
 @param shadowColor 阴影的颜色
 @param shadowOffset 隐形偏移量
 @param shadowOpacity 阴影透明度
 @param shadowRadius 阴影弧度
 */
-(void)setLayerShadowCornerRadius:(CGFloat)radius
              withBackgroundColor:(UIColor*)backgroundColor
                  withShadowColor:(UIColor*)shadowColor
                 withShadowOffset:(CGSize)shadowOffset
                withShadowOpacity:(CGFloat)shadowOpacity
                 withShadowRadius:(CGFloat)shadowRadius
                       withTarget:(UIView*)target;

#pragma mark 设置layer的弧度
/**
 设置layer的宽度
 @param width layer宽度
 */
-(void)setLayerBorderWidth:(CGFloat)width;
-(void)setBorderColor:(UIColor*)color;

/**
 对视图的某个角设置圆角

 @param corners UIRectCorner
 typedef NS_OPTIONS(NSUInteger, UIRectCorner) {
 UIRectCornerTopLeft     = 1 << 0,
 UIRectCornerTopRight    = 1 << 1,
 UIRectCornerBottomLeft  = 1 << 2,
 UIRectCornerBottomRight = 1 << 3,
 UIRectCornerAllCorners  = ~0UL
 };
 @param masksToBounds 是否切除外漏的视图
 @param radi 圆角半径
 */
-(void)byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)radi withMasksToBounds:(BOOL)masksToBounds;

/**
 对视图的某个角设置圆角
 
 @param corners UIRectCorner
 typedef NS_OPTIONS(NSUInteger, UIRectCorner) {
 UIRectCornerTopLeft     = 1 << 0,
 UIRectCornerTopRight    = 1 << 1,
 UIRectCornerBottomLeft  = 1 << 2,
 UIRectCornerBottomRight = 1 << 3,
 UIRectCornerAllCorners  = ~0UL
 };
 @param radi 圆角半径
 */
-(void)byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)radi;


@end
