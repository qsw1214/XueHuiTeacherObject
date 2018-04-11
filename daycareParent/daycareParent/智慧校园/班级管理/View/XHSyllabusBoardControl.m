//
//  XHSyllabusBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSyllabusBoardControl.h"

@implementation XHSyllabusBoardControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor orangeColor]];
    }
    return self;
}

- (void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
}

@end
