//
//  XHWeekCollectionView.h
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseCollectionView.h"
#import "XHWeekCollectionViewCell.h"


@protocol XHWeekCollectionViewDeletage <NSObject>

-(void)didSelectItemObjectAtIndexPath:(id)object;


@end



@interface XHWeekCollectionView : BaseCollectionView <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,weak) id <XHWeekCollectionViewDeletage> weekDeletage; //!< 代理对象




@end
