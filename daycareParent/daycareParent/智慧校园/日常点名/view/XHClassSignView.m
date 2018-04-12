//
//  XHClassSignView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassSignView.h"


@interface XHClassSignView()
@property(nonatomic,strong)UILabel *classLabel;//!< 班级名字

@property(nonatomic,strong)UILabel *signLabel;//!< 签到人数
@property(nonatomic,strong)UILabel *allClassLabel;//!< 总人数
@property(nonatomic,strong)UILabel *rosterLabel;//!< 出勤率标签
@property(nonatomic,strong)UILabel *attendanceLabel;//!< 出勤率数据
@end


@implementation XHClassSignView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=MainColor;
        [self setLayerCornerRadius:9];
        [self.classLabel setText:@"三四班"];
        [self.signLabel setText:@"人数:150"];
        [self.allClassLabel setText:@"/150"];
        [self.attendanceLabel setText:@"100%"];
        
        [self addSubview:self.classLabel];
        [self addSubview:self.signLabel];
        [self addSubview:self.allClassLabel];
        [self addSubview:self.rosterLabel];
        [self addSubview:self.attendanceLabel];
    }
    return self;
}
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    self.classLabel.frame=CGRectMake(15, 15, frame.size.width, 20);
    self.signLabel.frame=CGRectMake(15, self.classLabel.bottom+15, [self.signLabel getWidthWithTitle:self.signLabel.text font:kFont(15)], 15);
    self.allClassLabel.frame=CGRectMake(self.signLabel.right,self.classLabel.bottom+15 , [self.allClassLabel getWidthWithTitle:self.allClassLabel.text font:kFont(15)], 15);
    self.rosterLabel.frame=CGRectMake(self.allClassLabel.right+20, self.classLabel.bottom+15, [self.rosterLabel getWidthWithTitle:self.rosterLabel.text font:kFont(15)], 15);
    self.attendanceLabel.frame=CGRectMake(self.rosterLabel.right, self.classLabel.bottom+15, 50, 15);
}
-(UILabel *)classLabel
{
    if (_classLabel==nil) {
        _classLabel=[[UILabel alloc] init];
        _classLabel.font=kFont(20);
        _classLabel.textColor=[UIColor whiteColor];
    }
    return _classLabel;
}
-(UILabel *)signLabel
{
    if (_signLabel==nil) {
        _signLabel=[[UILabel alloc] init];
        _signLabel.font=kFont(15);
         _signLabel.textColor=[UIColor whiteColor];
        
    }
    return _signLabel;
}
-(UILabel *)allClassLabel
{
    if (_allClassLabel==nil) {
        _allClassLabel=[[UILabel alloc] init];
        _allClassLabel.font=kFont(15);
         _allClassLabel.textColor=[UIColor whiteColor];
    }
    return _allClassLabel;
}
-(UILabel *)rosterLabel
{
    if (_rosterLabel==nil) {
        _rosterLabel=[[UILabel alloc] init];
        _rosterLabel.font=kFont(15);
         _rosterLabel.textColor=[UIColor whiteColor];
        [_rosterLabel setText:@"出勤率:"];
    }
    return _rosterLabel;
}
-(UILabel *)attendanceLabel
{
    if (_attendanceLabel==nil) {
        _attendanceLabel=[[UILabel alloc] init];
        _attendanceLabel.font=kFont(15);
        [_attendanceLabel setTextColor:RGB(242, 133, 15)];
    }
    return _attendanceLabel;
}
@end
