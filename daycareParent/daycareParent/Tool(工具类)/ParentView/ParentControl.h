//
//  ParentControl
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Category.h"
@interface ParentControl : UIControl

-(void)setNumberLabel:(NSInteger)number;
-(void)setLabelCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index;
-(void)setLabelText:(NSString *)text withNumberIndex:(NSInteger)index;
-(void)setLabelTextAlignment:(NSTextAlignment)textAlignment withNumberIndex:(NSInteger)index;
-(void)setLabelFont:(UIFont *)font withNumberIndex:(NSInteger)index;
-(void)setLabelTextColor:(UIColor *)color withNumberIndex:(NSInteger)index;
-(void)setLabelCornerRadius:(CGFloat)radius withNumberIndex:(NSInteger)index;
-(void)setLabelBackgroundColor:(UIColor *)color withNumberIndex:(NSInteger)index;
-(void)setLabelNumberOfLines:(NSInteger)numberOfLines withNumberIndex:(NSInteger)index;
-(void)setLabelAlpha:(CGFloat)alpha withNumberIndex:(NSInteger)index;
-(void)setLabelAddTapGestureRecognizerTarget:(id)target action:(SEL)action withNumberIndex:(NSInteger)index;
-(void)setLabelAddGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withNumberIndex:(NSInteger)index;
-(void)setLabelchageMarkColor:(UIColor *)markcolor allColor:(UIColor *)allColor startString:(NSString *)startString endString:(NSString *)endString MarkFondSize:(CGFloat)fondSize withNumberIndex:(NSInteger)index;

-(void)setNumberImageView:(NSInteger)number;
-(void)setImageViewCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index;
-(void)setImageViewName:(NSString *)imageName withNumberIndex:(NSInteger)index;
-(void)setImageViewBackgroundColor:(UIColor *)color withNumberIndex:(NSInteger)index;
-(void)setImageViewCornerRadius:(CGFloat)radius withNumberIndex:(NSInteger)index;
-(void)setImageViewAlpha:(CGFloat)alpha withNumberIndex:(NSInteger)index;
-(void)setImageViewBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth withNumberIndex:(NSInteger)index;
-(void)setImageViewAddTapGestureRecognizerTarget:(id)target action:(SEL)action withNumberIndex:(NSInteger)index;
-(void)setImageViewAddGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withNumberIndex:(NSInteger)index;

-(void)setNumberTextFeild:(NSInteger)number;
-(void)setTextFeildCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index;
-(void)setTextFeildBorderStyle:(UITextBorderStyle)textBorderStyle withNumberIndex:(NSInteger)index;
-(void)setTextFeildKeyboardType:(UIKeyboardType)keyboardType withNumberIndex:(NSInteger)index;
-(void)setTextFeildPlaceholder:(NSString *)placeholder withNumberIndex:(NSInteger)index;
-(void)setTextFeildPlaceholderColor:(UIColor *)color withNumberIndex:(NSInteger)index;
-(void)setTextFeildPlaceholderFont:(UIFont *)font withNumberIndex:(NSInteger)index;
-(void)setTextFeildText:(NSString *)text withNumberIndex:(NSInteger)index;
-(void)setTextFeildTextColor:(UIColor *)color withNumberIndex:(NSInteger)index;
-(void)setTextFeildTextFont:(UIFont *)font withNumberIndex:(NSInteger)index;

-(void)setHeadPic:(NSString*)pic withName:(NSString*)name withType:(XHHeadType)type;
@end
