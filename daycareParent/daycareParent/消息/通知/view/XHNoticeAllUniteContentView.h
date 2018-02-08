//
//  XHNoticeAllUniteContentView.h
//  daycareParent
//
//  Created by Git on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"

#pragma mark 全选的视图


@interface XHNoticeAllUniteContentView : BaseControl

@property (nonatomic,strong) UILabel *titleLabel;  //!< 标题
@property (nonatomic,strong) UILabel *describeLabel;  //!<描述
@property (nonatomic,strong) UIView *lineView;  //!< 分割线
@property (nonatomic,copy) NSString *describe;

@property (nonatomic,assign) BOOL isAction; //!< 是否选中



@end
