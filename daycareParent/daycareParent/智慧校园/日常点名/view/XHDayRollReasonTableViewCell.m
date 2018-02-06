//
//  XHDayRollReasonTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollReasonTableViewCell.h"
#import "XHDayRollCallModel.h"
#import "XHApproveDetailModel.h"
@implementation XHDayRollReasonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(20, 0, 35, 50)];
        [self.contentView addSubview:_titleLabel];
       // _titleLabel.backgroundColor=[UIColor orangeColor];
        _reasonLabel=[[XHBackLabel alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-70, 0)];
        _reasonLabel.numberOfLines=0;
       // _reasonLabel.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:_reasonLabel];
        _imageV=[[BaseButtonControl alloc] init];
        //_imageV.backgroundColor=[UIColor redColor];
        _imageV.layer.cornerRadius=10;
        _imageV.layer.masksToBounds=YES;
        [self.contentView addSubview:_imageV];
    }
    return self;
}
-(void)setItemObject:(id)object
{
    switch (self.modelType) {
        case XHDayRollCallDetailType:
        {
            XHDayRollCallModel *model=object;
            _reasonLabel.frame=CGRectMake(60, 0, SCREEN_WIDTH-70, [self getCellHeight:model]);
            _reasonLabel.text=model.content;
            if (![model.picUrl isEqualToString:@""]) {
                _imageV.frame=CGRectMake(20, _reasonLabel.bottom+10, 50, 50);
                [_imageV setNumberImageView:1];
                [_imageV setImageEdgeFrame:CGRectMake(0, 0, 50, 50) withNumberType:0 withAllType:NO];
                [_imageV sd_setImageWithURL:ALGetFileHeadThumbnail(model.picUrl) withNumberType:0 withAllType:NO];
            }
        }
            break;
            
       case XHAskforLeaveDetailType:
        {
            XHApproveDetailModel *model=object;
            _reasonLabel.frame=CGRectMake(60, 0, SCREEN_WIDTH-70, [self getCellHeight:model]);
            _reasonLabel.text=model.content;
            if (![model.picUrl isEqualToString:@""]) {
                _imageV.frame=CGRectMake(20, _reasonLabel.bottom+10, 50, 50);
                [_imageV setNumberImageView:1];
                [_imageV setImageEdgeFrame:CGRectMake(0, 0, 50, 50) withNumberType:0 withAllType:NO];
                 [_imageV sd_setImageWithURL:ALGetFileHeadThumbnail(model.picUrl) withNumberType:0 withAllType:NO];
            }
            
        }
            break;
    }
    
}

-(CGFloat )getCellHeight:(id)object
{
    switch (self.modelType) {
        case XHDayRollCallDetailType:
        {
            XHDayRollCallModel *model=object;
            if ([NSString contentSizeWithTitle:model.content withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height<50) {
                return 50;
            }
            else
            {
                return [NSString contentSizeWithTitle:model.content withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height;
            }
        }
            break;
            
       case XHAskforLeaveDetailType:
        {
            XHApproveDetailModel *model=object;
            if ([NSString contentSizeWithTitle:model.content withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height<50) {
                return 50;
            }
            else
            {
                return [NSString contentSizeWithTitle:model.content withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height;
            }
        }
            break;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
