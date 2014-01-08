//
//  BudgetViewController.m
//  随手记
//
//  Created by OPSOFT on 14-1-2.
//  Copyright (c) 2014年 OPSOFT. All rights reserved.
//

#import "BudgetViewController.h"
#import "UINavigationBar+customBar.h"
@interface BudgetViewController ()

@end

@implementation BudgetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"一级预算";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *barBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_action_bar_refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem=barBtn;
    self.navigationController.navigationBarHidden=NO;
}


-(void)refresh:(id)sender{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    self.navigationController.navigationBar.barTintColor=[UIColor lightGrayColor];
    [self.navigationController.navigationBar customNavigationBar];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
