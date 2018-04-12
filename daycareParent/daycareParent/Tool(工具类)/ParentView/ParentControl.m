//
//  ParentControl.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentControl.h"
@interface ParentControl()
@property(nonatomic,strong)NSMutableArray *numberLabelArry;
@property(nonatomic,strong)NSMutableArray *numberImageViewArry;
@property(nonatomic,strong)NSMutableArray *numberTextFeildArry;
@end


@implementation ParentControl
-(instancetype)init
{
    if (self=[super init]) {
       
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
    
    }
    return self;
}
#pragma mark-----UILabel
-(void)setNumberLabel:(NSInteger)number
{
    for (int i=0; i<number; i++) {
        ParentLabel *label=[[ParentLabel alloc] init];
        [self addSubview:label];
        [self.numberLabelArry addObject:label];
    }
    
}
-(void)setLabelCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    [label setFrame:rect];
}
-(void)setLabelText:(NSString *)text withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    [label setText:[NSString safeString:text]];
}
-(void)setLabelNumberOfLines:(NSInteger)numberOfLines withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    [label setNumberOfLines:numberOfLines];
}
-(void)setLabelAlpha:(CGFloat)alpha withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    [label setAlpha:alpha];
}
-(void)setLabelAddTapGestureRecognizerTarget:(id)target action:(SEL)action withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:target
                                                    action:action];
    [label addGestureRecognizer:tapGestureRecognizer];
}

-(void)setLabelAddGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    
    [label addGestureRecognizer:gestureRecognizer];
}

-(void)setLabelTextAlignment:(NSTextAlignment)textAlignment withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    [label setTextAlignment:textAlignment];
}

-(void)setLabelFont:(UIFont *)font withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    [label setFont:font];
}
-(void)setLabelTextColor:(UIColor *)color withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    [label setTextColor:color];
}

-(void)setLabelCornerRadius:(CGFloat)radius withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    label.layer.cornerRadius=radius;
    label.layer.masksToBounds=YES;
}

-(void)setLabelBackgroundColor:(UIColor *)color withNumberIndex:(NSInteger)index
{
    ParentLabel *label=self.numberLabelArry[index];
    [label setBackgroundColor:color];
}

-(void)setNumberImageView:(NSInteger)number
{
    for (int i=0; i<number; i++) {
        ParentImageView *imageView=[[ParentImageView alloc] init];
        [self addSubview:imageView];
        [self.numberImageViewArry addObject:imageView];
    }
}

-(void)setImageViewCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    [imageView setFrame:rect];
}
-(void)setImageViewAlpha:(CGFloat)alpha withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    imageView.alpha=alpha;
}
-(void)setImageViewName:(NSString *)imageName withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    if ([[NSString safeString:imageName] containsString:@"http"])
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"addman"]];
    }
    else
    {
         imageView.image=[UIImage imageNamed:imageName];
    }
   
}
-(void)setImageViewBackgroundColor:(UIColor *)color withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    [imageView setBackgroundColor:color];
}

-(void)setImageViewCornerRadius:(CGFloat)radius withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    imageView.layer.cornerRadius=radius;
    imageView.layer.masksToBounds=YES;
}

-(void)setImageViewBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    imageView.layer.borderColor=borderColor.CGColor;
    imageView.layer.borderWidth=borderWidth;
    imageView.layer.masksToBounds=YES;
}

-(void)setImageViewAddTapGestureRecognizerTarget:(id)target action:(SEL)action withNumberIndex:(NSInteger)index
{
   ParentImageView *imageView=self.numberImageViewArry[index];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:target
                                                    action:action];
    [imageView addGestureRecognizer:tapGestureRecognizer];
}

-(void)setImageViewAddGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withNumberIndex:(NSInteger)index
{
   ParentImageView *imageView=self.numberImageViewArry[index];
    [imageView addGestureRecognizer:gestureRecognizer];
}


-(void)setNumberTextFeild:(NSInteger)number
{
    for (int i=0; i<number; i++)
    {
        ParentTextFeild *textFeild=[[ParentTextFeild alloc] init];
        [self addSubview:textFeild];
        [self.numberTextFeildArry addObject:textFeild];
    }
}
-(void)setTextFeildCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
    [textFeild setFrame:rect];
}

-(void)setTextFeildBorderStyle:(UITextBorderStyle)textBorderStyle withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
    [textFeild setBorderStyle:textBorderStyle];
}

-(void)setTextFeildKeyboardType:(UIKeyboardType)keyboardType withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
    [textFeild setKeyboardType:keyboardType];
}
-(void)setTextFeildPlaceholder:(NSString *)placeholder withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
    [textFeild setPlaceholder:[NSString safeString:placeholder]];
}
-(void)setTextFeildPlaceholderColor:(UIColor *)color withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
     [textFeild setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}
-(void)setTextFeildPlaceholderFont:(UIFont *)font withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
    [textFeild setValue:font forKeyPath:@"_placeholderLabel.font"];
}
-(void)setTextFeildText:(NSString *)text withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
    [textFeild setText:[NSString safeString:text]];
}
-(void)setTextFeildTextColor:(UIColor *)color withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
    [textFeild setTextColor:color];
}
-(void)setTextFeildTextFont:(UIFont *)font withNumberIndex:(NSInteger)index
{
    ParentTextFeild *textFeild=self.numberTextFeildArry[index];
    [textFeild setFont:font];
}

-(void)setHeadPic:(NSString*)pic withName:(NSString*)name withType:(XHHeadType)type
{
    [self setLabelTextColor:[UIColor whiteColor] withNumberIndex:0];
    [self setLabelFont:kFont(18.0) withNumberIndex:0];
    
    pic = [NSString safeString:pic];
    if ([pic isEqualToString:@""])
    {
        [self setImageViewBackgroundColor:kHeaderColor withNumberIndex:0];
        [self setImageViewName:nil withNumberIndex:0];
        NSInteger length = name.length;
        NSString *makeName = name;
        if ([name isEqualToString:@""])
        {
            [self setLabelText:name withNumberIndex:0];
        }
        else
        {
            //        2.截取我们想要的字符串内容
            switch (type)
            {
                case XHTeacherType:
                {
                    makeName = [name substringWithRange:NSMakeRange(0,1)];
                }
                    break;
                case XHstudentType:
                {
                    makeName = [name substringWithRange:NSMakeRange((length-1),1)];
                }
                    break;
            }
             [self setLabelText:makeName withNumberIndex:0];
        }
        
    }
    else
    {
        [self setImageViewBackgroundColor:[UIColor whiteColor] withNumberIndex:0];
        [self setLabelText:nil withNumberIndex:0];
        [self setImageViewName:ALGetFileHeadThumbnail(pic) withNumberIndex:0];
    }
}
-(NSMutableArray *)numberLabelArry
{
    if (_numberLabelArry==nil) {
        _numberLabelArry=[[NSMutableArray alloc] init];
    }
    return _numberLabelArry;
}


-(NSMutableArray *)numberImageViewArry
{
    if (_numberImageViewArry==nil)
    {
        _numberImageViewArry=[[NSMutableArray alloc] init];
    }
    return _numberImageViewArry;
}

-(NSMutableArray *)numberTextFeildArry
{
    if (_numberTextFeildArry==nil)
    {
        _numberTextFeildArry=[[NSMutableArray alloc] init];
    }
    return _numberTextFeildArry;
}
@end
