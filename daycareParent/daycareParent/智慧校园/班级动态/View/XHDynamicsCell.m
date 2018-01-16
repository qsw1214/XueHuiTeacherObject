//
//  XHDynamicsCell.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsCell.h"



@interface XHDynamicsCell ()

{
    id Ddelegate;
}
@property (nonatomic,strong) XHDynamicsCellContentView *cellContentView; //!< 单元格内容视图



@end

@implementation XHDynamicsCell



- (instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        Ddelegate=deletage;
        [self.contentView addSubview:self.cellContentView];
        [self.cellContentView setDeletage:deletage];
        
    }
    return self;
}



-(void)setItemFrame:(XHDynamicsFrame*)frame withIndexPath:(NSIndexPath*)index
{
    [frame.model setTage:index.row];
    [frame.model.playModel setIndexPath:index];
    [frame.model.playModel setFatherViewTag:index.row];
    [frame.model setPlayModel:frame.model.playModel];
    [self.cellContentView resetFrame:frame.itemFrame];
    [self.cellContentView setItemFrame:frame withIndexPath:index];
}




#pragma mark - Getter / Setter
-(XHDynamicsCellContentView *)cellContentView
{
    if (!_cellContentView)
    {
        _cellContentView = [[XHDynamicsCellContentView alloc]initWith:Ddelegate];
    }
    return _cellContentView;
}




@end
