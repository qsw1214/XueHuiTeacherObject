
//  Created by Caoyq on 16/5/4.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "UIView+Frame.h"




@implementation UIView (Frame)

/**
 @param   x  新设置的值
 */
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


/**
 返回一个Origin.x
 */
- (CGFloat)x
{
    return self.frame.origin.x;
}

/**
 @param   y   设置新的Origin.Y
 */
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/**
 返回一个Origin.y
 */
- (CGFloat)y
{
    return self.frame.origin.y;
}

/**
 @param   origin   设置新的Origin
 */
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

/**
    返回一个Origin
 */
- (CGPoint)origin
{
    return self.frame.origin;
}

/**
 @param   width   设置新的Size.Width
 */
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/**
 返回一个Size.Width
 */
- (CGFloat)width
{
    return self.frame.size.width;
}

/**
 @param   height   设置新的Size.Height
 */
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

/**
 返回一个Size.Height
 */
- (CGFloat)height
{
    return self.frame.size.height;
}

/**
 @param   size   设置新的Size
 */
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

/**
 返回一个Size
 */
- (CGSize)size
{
    return self.frame.size;
}


-(void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

-(CGFloat)left
{
    return (self.frame.origin.x);
}


-(void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right;
    self.frame = frame;
}


-(CGFloat)right
{
    return (self.frame.origin.x+self.frame.size.width);
}

-(void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}


-(CGFloat)top
{
    return self.frame.origin.y;
}


-(void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom;
    self.frame = frame;
}

-(CGFloat)bottom
{
    return (self.frame.origin.y+self.frame.size.height);
}



-(void)setLayerCornerRadius:(CGFloat)radius
{
    [self.layer setCornerRadius:radius];
    [self.layer setMasksToBounds:YES];
    
}

-(void)setLayerCornerRadius:(CGFloat)radius withMasksToBounds:(BOOL)masksToBounds
{
    [self.layer setCornerRadius:radius];
    [self.layer setMasksToBounds:masksToBounds];
}

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
                       withTarget:(UIView*)target
{
    CALayer *subLayer = [CALayer layer];
    subLayer.frame = target.frame;
    
    subLayer.cornerRadius = radius;
    
    subLayer.backgroundColor = [backgroundColor colorWithAlphaComponent:0.5].CGColor;
    
    subLayer.masksToBounds=NO;
    
    subLayer.shadowColor=[shadowColor CGColor];
    
    subLayer.shadowOffset=shadowOffset;
    
    subLayer.shadowOpacity=shadowOpacity;
    
    subLayer.shadowRadius=shadowRadius;
    
    [self.layer insertSublayer:subLayer below:target.layer];
}

-(void)setLayerBorderWidth:(CGFloat)width
{
    [self.layer setBorderWidth:width];
}

-(void)setBorderColor:(UIColor*)color
{
    [self.layer setBorderColor:[color CGColor]];
}


-(void)byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)radi
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners  cornerRadii:CGSizeMake(radi, radi)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    [maskLayer setPath:maskPath.CGPath];
    [self.layer setMask:maskLayer];
    [self.layer setMasksToBounds:YES];
}


-(void)byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)radi withMasksToBounds:(BOOL)masksToBounds
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners  cornerRadii:CGSizeMake(radi, radi)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    [maskLayer setPath:maskPath.CGPath];
    [self.layer setMask:maskLayer];
//    [self.layer setMasksToBounds:masksToBounds];
}




@end
