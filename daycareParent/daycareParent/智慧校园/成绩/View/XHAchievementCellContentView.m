//
//  XHAchievementCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAchievementCellContentView.h"

@interface XHAchievementCellContentView ()

@property (nonatomic,strong) UILabel *subjectLabel; //!< 科目
@property (nonatomic,strong) UILabel *batchLabel; //!< 开学成绩
@property (nonatomic,strong) UILabel *scoreLabel; //!< 其中成绩
@property (nonatomic,strong) UILabel *endLabel; //!< 其末成绩


@end


@implementation XHAchievementCellContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.subjectLabel];
        [self addSubview:self.batchLabel];
        [self addSubview:self.scoreLabel];
        [self addSubview:self.endLabel];
    }
    return self;
}

-(void)setTextColor:(UIColor*)color
{
    [self.subjectLabel setTextColor:color];
    [self.batchLabel setTextColor:color];
    [self.scoreLabel setTextColor:color];
    [self.endLabel setTextColor:color];
}

-(void)setFont:(UIFont*)font
{
    [self.subjectLabel setFont:font];
    [self.batchLabel setFont:font];
    [self.scoreLabel setFont:font];
    [self.endLabel setFont:font];
}
-(void)setSubject:(NSString*)subject
{
    [self.subjectLabel setText:subject];
}
-(void)setBatch:(NSString*)batch
{
    [self.batchLabel setText:batch];
}

-(void)setScore:(NSString*)score
{
    [self.scoreLabel setText:score];
}

-(void)setEnd:(NSString *)end
{
     [self.endLabel setText:end];
}


-(void)setItemFrame:(XHAchievementFrame*)frame
{
    [self resetFrame:frame.itemFrame];
    
    switch (frame.model.contentType)
    {
        case XHAchievementTitleType:
        {
            [self setBackgroundColor:RGB(255, 239, 213)];
        }
            break;
        case XHAchievementContentType:
        {
            [self setBackgroundColor:[UIColor whiteColor]];
        }
            break;
    }
    
    //!< 赋值
    [self.subjectLabel setText:frame.model.subject];
    [self.batchLabel setText:frame.model.batch];
    [self.scoreLabel setText:frame.model.score];
    [self.endLabel setText:frame.model.end];
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    
    [self.subjectLabel setFrame:CGRectMake(0, 0, frame.size.width/4.0, frame.size.height)];
    [self.batchLabel setFrame:CGRectMake(self.subjectLabel.right, 0, self.subjectLabel.width, self.subjectLabel.height)];
    [self.scoreLabel setFrame:CGRectMake(self.batchLabel.right, self.subjectLabel.top, self.subjectLabel.width, self.subjectLabel.height)];
    [self.endLabel setFrame:CGRectMake(self.scoreLabel.right, self.subjectLabel.top, self.subjectLabel.width, self.subjectLabel.height)];
}


#pragma mark - Getter / Setter
-(UILabel *)subjectLabel
{
    if (_subjectLabel == nil)
    {
        _subjectLabel = [[UILabel alloc]init];
        [_subjectLabel setTextAlignment:NSTextAlignmentCenter];
        [_subjectLabel setNumberOfLines:0];
        [_subjectLabel setLayerBorderWidth:0.5];
        [_subjectLabel setBorderColor:LineViewColor];
    }
    return _subjectLabel;
}

-(UILabel *)batchLabel
{
    if (_batchLabel == nil)
    {
        _batchLabel = [[UILabel alloc]init];
        [_batchLabel setTextAlignment:NSTextAlignmentCenter];
        [_batchLabel setNumberOfLines:0];
        [_batchLabel setLayerBorderWidth:0.5];
        [_batchLabel setBorderColor:LineViewColor];
        
    }
    return _batchLabel;
}


-(UILabel *)scoreLabel
{
    if (_scoreLabel == nil)
    {
        _scoreLabel = [[UILabel alloc]init];
        [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
        [_scoreLabel setNumberOfLines:0];
        [_scoreLabel setLayerBorderWidth:0.5];
        [_scoreLabel setBorderColor:LineViewColor];
    }
    return _scoreLabel;
}

-(UILabel *)endLabel
{
    if (_endLabel == nil)
    {
        _endLabel = [[UILabel alloc]init];
        [_endLabel setTextAlignment:NSTextAlignmentCenter];
        [_endLabel setNumberOfLines:0];
        [_endLabel setLayerBorderWidth:0.5];
        [_endLabel setBorderColor:LineViewColor];
    }
    return _endLabel;
}
@end
