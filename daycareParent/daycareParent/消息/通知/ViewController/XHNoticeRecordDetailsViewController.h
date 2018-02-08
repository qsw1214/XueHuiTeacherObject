//
//  XHNoticeRecordDetailsViewController.h
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseViewController.h"
#import "XHHomeWorkContentView.h"

typedef void (^BackRefeshBlock) (BOOL isRefesh);


@interface XHNoticeRecordDetailsViewController : BaseViewController
@property (nonatomic,copy) BackRefeshBlock refeshBlock;


-(void)setItemObjet:(XHHomeWorkFrame*)objet;

@end

