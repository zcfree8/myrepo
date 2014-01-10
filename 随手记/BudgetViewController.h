//
//  BudgetViewController.h
//  随手记
//
//  Created by OPSOFT on 14-1-2.
//  Copyright (c) 2014年 OPSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BudgetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *DTableView;
@property(nonatomic,strong)UIView *TopView;
@property(nonatomic,retain)NSArray *InfoArr;
@property(nonatomic,strong)UILabel *labelAll;
@property(nonatomic,strong)UILabel *labelEnable;
@property(nonatomic,strong)UILabel *labelable;
@property(nonatomic,strong)UILabel *labelshow;

@end
