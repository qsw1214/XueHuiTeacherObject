//
//  XHNewTextFieldTypeTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHNewTextFieldTypeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet XHBaseLabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *textFeild;
@property (strong, nonatomic) IBOutlet XHBackLabel *selectLabel;

@end
