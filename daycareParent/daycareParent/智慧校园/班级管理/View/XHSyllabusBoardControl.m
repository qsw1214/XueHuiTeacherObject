//
//  XHSyllabusBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSyllabusBoardControl.h"
#import "XHWeekCollectionView.h"
#import "XHSyllabusCollectionView.h"
#import "XHSyllabusHeaderBoardControl.h"
#import "XHSyllabusBoltControl.h"


@interface XHSyllabusBoardControl () <XHWeekCollectionViewDeletage,UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSMutableArray *firstArry;
@property (nonatomic,strong) NSMutableArray *twoArry;
@property (nonatomic,strong) XHSyllabusBoltControl *topBoltControl;  //!< 顶部铆钉图标
@property (nonatomic,strong) XHSyllabusBoltControl *bottomBoltControl; //!< 底部铆钉图标
@property (nonatomic,strong) UILabel *weekTipLabel; //!< 星期提示标签
@property (nonatomic,strong) XHSyllabusHeaderBoardControl *syllabusHeaderBoardControl;
@property (nonatomic,strong) XHSyllabusCollectionView *syllabusCollectionView; //!< 课程表内容


@end
@implementation XHSyllabusBoardControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:RGB(239,239,239)];
        [self addSubview:self.weekTipLabel];
        [self addSubview:self.syllabusHeaderBoardControl];
        [self addSubview:self.syllabusCollectionView];
        [self addSubview:self.topBoltControl];
        [self addSubview:self.bottomBoltControl];
        
        
        
        
    }
    return self;
}

#pragma mark - Delegate Method
#pragma mark XHWeekCollectionViewDeletage 代理方法
-(void)didSelectItemObjectAtIndexPath:(XHWeekFrame*)object
{
    [self.syllabusCollectionView setItemArray:object.model.syllabusArray];
}


#pragma mark 填充班级id用户获取当前班级的课程表
-(void)setItemObject:(id)object withBlock:(XHSyllabusBackBlock)blcok
{
    [self getSyllabusWithClassid:object withBlock:blcok];
}

#pragma mark - NetWorkData
-(void)getSyllabusWithClassid:(NSString*)classid withBlock:(XHSyllabusBackBlock)blcok
//{
//
//    NSInteger werrk = [XHHelper weekdayWithNowDate:[NSDate date]];
//    [self.syllabusHeaderBoardControl setWeekMake:werrk];
//    NSArray *syllabusArray = @[@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"化学",@"地理"];
//
//
//
//    NSArray *itemArray = [self getSubjectWithdataArry:syllabusArray];
//    [NSArray enumerateObjectsWithArray:itemArray usingforceBlock:^(id itemArrayobj, NSUInteger idx, BOOL *stop,BOOL forceStop)
//     {
//         if (forceStop)
//         {
//             XHWeekFrame *frame = [[XHWeekFrame alloc]init];
//             XHWeekModel *model = [[XHWeekModel alloc]init];
//             [model setType:XHWeekSyllabusType];
//             [model setMarkType:werrk];
//
//             [NSArray enumerateObjectsWithArray:itemArrayobj usingforceBlock:^(id obj, NSUInteger idx, BOOL *stop, BOOL forceStop)
//              {
//                  switch (idx)
//                  {
//                      case 0:
//                      {
//                          [model setMonday:obj];
//                      }
//                          break;
//                      case 1:
//                      {
//                          [model setTuesday:obj];
//                      }
//                          break;
//                      case 2:
//                      {
//                          [model setWednesday:obj];
//                      }
//                          break;
//                      case 3:
//                      {
//                          [model setThursday:obj];
//                      }
//                          break;
//                      case 4:
//                      {
//                          [model setFriday:obj];
//                      }
//                          break;
//                  }
//              }];
//
//             [frame setModel:model];
//             [self.dataArray addObject:frame];
//
//         }
//     }];
//
//    [self.syllabusCollectionView setItemArray:self.dataArray];
//
//
//}
{


    NSInteger werrk = [XHHelper weekdayWithNowDate:[NSDate date]];
    [self.syllabusHeaderBoardControl setWeekMake:werrk];

    if (classid)
    {
        [XHShowHUD showTextHud];


        XHNetWorkConfig *netWorkconfig = [[XHNetWorkConfig alloc]init];
        [netWorkconfig setObject:classid forKey:@"classId"];
        [netWorkconfig postWithUrl:@"zzjt-app-api_smartCampus020" sucess:^(id object, BOOL verifyObject)
         {
             [self.dataArray removeAllObjects];
             object = [object objectItemKey:@"object"];
             NSArray *dateArray = [object objectForKey:@"date"];
             NSArray *syllabusArray = [object objectForKey:@"syllabus"];

             /**
              syllabusArray = @[@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"化学",@"地理"];
              */



             NSArray *itemArray = [self getSubjectWithdataArry:syllabusArray];


             [NSArray enumerateObjectsWithArray:itemArray usingforceBlock:^(id obj, NSUInteger idx, BOOL *stop,BOOL forceStop)
              {
                  if (forceStop)
                  {
                      XHWeekFrame *frame = [[XHWeekFrame alloc]init];
                      XHWeekModel *model = [[XHWeekModel alloc]init];
                      [model setType:XHWeekSyllabusType];
                      [model setMarkType:werrk];

                      [NSArray enumerateObjectsWithArray:obj usingforceBlock:^(id obj, NSUInteger idx, BOOL *stop, BOOL forceStop)
                       {
                           switch (idx)
                           {
                               case 0:
                               {
                                   [model setMonday:obj];
                               }
                                   break;
                               case 1:
                               {
                                   [model setTuesday:obj];
                               }
                                   break;
                               case 2:
                               {
                                   [model setWednesday:obj];
                               }
                                   break;
                               case 3:
                               {
                                   [model setThursday:obj];
                               }
                                   break;
                               case 4:
                               {
                                   [model setFriday:obj];
                               }
                                   break;
                           }
                       }];

                      [frame setModel:model];
                      [self.dataArray addObject:frame];

                  }
              }];


             
             [self resetSyllabusHeight:self.dataArray withBlock:blcok];
            


         } error:^(NSError *error)
         {
             [self resetSyllabusHeight:self.dataArray withBlock:blcok];
         }];
    }
}


-(void)resetSyllabusHeight:(NSMutableArray*)array withBlock:(XHSyllabusBackBlock)blcok
{
    
    [self.syllabusCollectionView setItemArray:self.dataArray];
    CGFloat height = (self.syllabusCollectionView.bottom+30.0);
    [self setHeight:height];
    if (self.syllabusCollectionView.height >= 50.0)
    {
        
        //!< 顶部铆钉
        [self.topBoltControl resetFrame:CGRectMake(-5.0, self.syllabusHeaderBoardControl.bottom-7.5, 30.0, 15.0)];
        [self.topBoltControl setLayerCornerRadius:5.0];
        
        if (self.syllabusCollectionView.height >= 150.0)
        {
            [self.bottomBoltControl resetFrame:CGRectMake(self.topBoltControl.left, self.height-(80+(15.0/2.0)), 30.0, 15.0)];
            [self.bottomBoltControl setLayerCornerRadius:5.0];
        }
    }
    
    blcok(height,YES);
}





#pragma mark - Getter /  Setter
- (void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self setLayerCornerRadius:5.0 withMasksToBounds:NO];
    [self.weekTipLabel setFrame:CGRectMake(0, 0, frame.size.width, 30.0)];
    [self.weekTipLabel setText:@"课程表"];
    

    
    [self.syllabusHeaderBoardControl resetFrame:CGRectMake(15.0, self.weekTipLabel.bottom, self.weekTipLabel.width-20.0, 40.0)];
   
    //!< 课程表
    [self.syllabusCollectionView resetFrame:CGRectMake(self.syllabusHeaderBoardControl.left, self.syllabusHeaderBoardControl.bottom, self.syllabusHeaderBoardControl.width, 0)];
    
}


-(XHSyllabusBoltControl *)topBoltControl
{
    if (!_topBoltControl)
    {
        _topBoltControl = [[XHSyllabusBoltControl alloc]init];
    }
    return _topBoltControl;
}

-(XHSyllabusBoltControl *)bottomBoltControl
{
    if (!_bottomBoltControl)
    {
        _bottomBoltControl = [[XHSyllabusBoltControl alloc]init];
    }
    return _bottomBoltControl;
}



-(UILabel *)weekTipLabel
{
    if (!_weekTipLabel)
    {
        _weekTipLabel = [[UILabel alloc]init];
        [_weekTipLabel setText:@"课程表"];
        [_weekTipLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_weekTipLabel setTextColor:RGB(81,200,162)];
        [_weekTipLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _weekTipLabel;
}


-(XHSyllabusHeaderBoardControl *)syllabusHeaderBoardControl
{
    if (!_syllabusHeaderBoardControl)
    {
        _syllabusHeaderBoardControl = [[XHSyllabusHeaderBoardControl alloc]init];
    }
    return _syllabusHeaderBoardControl;
}


-(XHSyllabusCollectionView *)syllabusCollectionView
{
    if (!_syllabusCollectionView)
    {
        _syllabusCollectionView = [[XHSyllabusCollectionView alloc]init];
    }
    return _syllabusCollectionView;
}





#pragma mark - Private Method
-(NSMutableArray *)firstArry
{
    if (_firstArry==nil)
    {
        _firstArry=[[NSMutableArray alloc] init];
    }
    return _firstArry;
}


-(NSMutableArray *)twoArry
{
    if (_twoArry==nil) {
        _twoArry=[[NSMutableArray alloc] init];
    }
    return _twoArry;
}

-(NSArray *)getSubjectWithdataArry:(NSArray *)dataArry
{
    
    if (dataArry && [dataArry count])
    {
        NSMutableString *string=[[NSMutableString alloc] init];
        NSMutableArray *mutableArry = [[NSMutableArray alloc] init];
        [NSArray enumerateObjectsWithArray:dataArry usingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
         {
             if (idx%5==0&&idx!=0)
             {
                 [string appendFormat:@"%@",@"(*)"];
                 [string appendFormat:@"%@ ",obj];
             }
             else
             {
                 [string appendFormat:@"%@ ",obj];
             }
             
         }];
        
        NSArray *arr = [string componentsSeparatedByString:@"(*)"];
        
        for (NSString *str in arr)
        {
            NSArray *arr=[str componentsSeparatedByString:@" "];
            
            NSMutableArray *temmpArray = [[NSMutableArray alloc]initWithArray:arr];
            [temmpArray  removeLastObject];
            [mutableArry addObject:temmpArray];
            
        }
        
        return mutableArry;
    }
    else
    {
        return nil;
    }
}





@end
