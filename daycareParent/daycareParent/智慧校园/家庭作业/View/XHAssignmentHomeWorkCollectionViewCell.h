//
//  XHAssignmentHomeWorkCollectionViewCell.h
//  daycareParent
//
//  Created by Git on 2018/2/6.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPreviewModel.h"


@protocol XHAssignmentHomeWorkCollectionViewCellDeletage <NSObject>

-(void)deleteControlAction:(XHPreviewModel*)object;

@end


@interface XHAssignmentHomeWorkCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign) id <XHAssignmentHomeWorkCollectionViewCellDeletage> deletage;


@property (nonatomic,strong) XHPreviewModel *model;





@end
