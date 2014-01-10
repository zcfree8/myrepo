//
//  ViewController.h
//  随手记
//
//  Created by OPSOFT on 13-12-30.
//  Copyright (c) 2013年 OPSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "LDProgressView.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (IBAction)arrow:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *arrowTool;

@property(strong,nonatomic)UITableView *ATableView;
@property(strong,nonatomic)UITableView *BTableView;

@property(nonatomic,strong)LDProgressView *progressView;
@end
