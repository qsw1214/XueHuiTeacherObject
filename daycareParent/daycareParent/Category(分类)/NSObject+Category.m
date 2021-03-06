//
//  NSObject+Category.m
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "NSObject+Category.h"
#import "NSString+Category.h"

@implementation NSObject (Category)

+(BOOL)isArray:(id)object
{
    if ([object isKindOfClass:[NSArray class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)isDictionary:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



// 判断密码
+(BOOL)verifyPassword:(NSString *)pass
{
    // 判断长度大于6位后再接着判断是否同时包含数字和字符
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:pass];
}


//判断手机号
+(BOOL)verifyPhone:(NSString*)phone
{
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}



#pragma mark --- 验证是否是数字符合规则
/**
 验证码是否符合规则
 */
+(BOOL)verifyNumberMatch:(id)phoneNumber
{
    //11位点化号码
    NSString *regex = @"^[0-9]{1,100}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}



#pragma mark --- 验证是否是数字和字母符合规则
/**
 验证是否是数字和字母符合规则
 */
+(BOOL)verifyIDentityMatch:(id)phoneNumber
{
    //验证身份证，数字或者数字+字母
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}

#pragma mark --- 验证码是否符合规则
/**
 验证码是否符合规则
 */
+(BOOL)verifyCodeMatch:(id)phoneNumber
{
    //11位点化号码
    NSString *regex = @"^[0-9]{4,6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}



#pragma mark --- 验证电话号码是否符合规则
/**
 验证电话号码是否符合规则
 */
+(BOOL)verifyPhoneNumberMatch:(id)phoneNumber
{
    //11位点化号码
    NSString *regex = @"^[0-9]{11}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}



#pragma mark --- 验证密码是否符合规则
/**
 验证密码是否符合规则
 */
+(BOOL)verifyPasswordMatch:(id)password
{
    //11位点化号码
    NSString *regex = @"[a-zA-Z0-9_]{6,30}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
}



+ (BOOL)empty:(NSObject *)o
{
    if (o==nil)
    {
        return YES;
    }
    if (o==NULL)
    {
        return YES;
    }
    if (o==[NSNull new])
    {
        return YES;
    }
    
    if ([o isKindOfClass:[NSString class]])
    {
        return [NSString isBlankString:(NSString *)o];
    }
    
    if ([o isKindOfClass:[NSData class]])
    {
        return [((NSData *)o) length]<=0;
    }
    
    if ([o isKindOfClass:[NSDictionary class]])
    {
        return [((NSDictionary *)o) count] <= 0;
    }
    
    if ([o isKindOfClass:[NSArray class]])
    {
        return [((NSArray *)o) count] <= 0;
    }
    
    if ([o isKindOfClass:[NSSet class]])
    {
        return [((NSSet *)o) count]<=0;
    }
    return NO;
}



#pragma mark 计算文本的宽度和高度
-(CGSize)contentSizeWithTitle:(NSString*)content withFontOfSize:(UIFont*)font withWidth:(CGFloat)maxWidth
{
    //=========得到content的内容高度===========
    NSDictionary *AttriButes = @{NSFontAttributeName: font};
    CGSize ContentSize = [content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                               options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:AttriButes
                                               context:nil].size;
    //译文本高度
    return ContentSize;
}
#pragma mark 计算文本的宽度
- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
#pragma mark 计算文本的高度
- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
#pragma mark 计算文本的宽度和高度
+(CGSize)contentSizeWithTitle:(NSString*)content withFontOfSize:(UIFont*)font withWidth:(CGFloat)maxWidth
{
    //=========得到content的内容高度===========
    NSDictionary *AttriButes = @{NSFontAttributeName: font};
    CGSize ContentSize = [content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                               options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:AttriButes
                                               context:nil].size;
    //译文本高度
    return ContentSize;
}
/*
 *x*y
 *改变字符start 和 end 之间的字符的颜色 和 字体大小
 */
- (void)messageAction:(UILabel *)theLab startString:(NSString *)start endString:(NSString *)end andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize
{
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    // 'x''y'字符的范围
    NSRange tempRange = NSMakeRange(0, 0);
    if (![[NSString safeString:start] isEqualToString:@""]) {
        tempRange = [tempStr rangeOfString:start];
    }
    NSRange tempRangeOne = NSMakeRange([strAtt length], 0);
    if (![[NSString safeString:end] isEqualToString:@""]) {
        tempRangeOne =  [tempStr rangeOfString:end];
    }
    // 更改字符颜色
    NSRange markRange = NSMakeRange(tempRange.location+tempRange.length, tempRangeOne.location-(tempRange.location+tempRange.length));
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    // 更改字体
    // [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] range:NSMakeRange(0, [strAtt length])];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    theLab.attributedText = strAtt;
}
@end
