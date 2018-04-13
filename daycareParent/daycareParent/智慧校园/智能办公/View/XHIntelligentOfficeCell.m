//
//  XHIntelligentOfficeCell.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeCell.h"
#import "XHIntelligentOfficeContentControl.h"


@interface XHIntelligentOfficeCell ()

@property (nonatomic,strong) XHIntelligentOfficeContentControl *contentControl; //!< 内容视图






@end

@implementation XHIntelligentOfficeCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        [self.contentView setBackgroundColor:RGB(229.0, 229.0, 229.0)];
        [self.contentView addSubview:self.contentControl];
      
    }
    return self;
}

-(void)setItemFrame:(XHIntelligentOfficeFrame*)frame
{
    [self.contentControl setItemFrame:frame];
    
    [self.contentControl setLayerCornerRadius:5.0];
    
//    [self setLayerShadowCornerRadius:5.0 withBackgroundColor:[UIColor grayColor] withShadowColor:RGB(229.0, 229.0, 229.0) withShadowOffset:CGSizeMake(10.0, 10.0) withShadowOpacity:1.0 withShadowRadius:5.0 withTarget:self.contentControl];
}



#pragma mark - Getter /  Setter

-(XHIntelligentOfficeContentControl *)contentControl
{
    if (!_contentControl)
    {
        _contentControl = [[XHIntelligentOfficeContentControl alloc]init];
    }
    return _contentControl;
}






@end
