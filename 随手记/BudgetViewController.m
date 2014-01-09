//
//  BudgetViewController.m
//  随手记
//
//  Created by OPSOFT on 14-1-2.
//  Copyright (c) 2014年 OPSOFT. All rights reserved.
//

#import "BudgetViewController.h"
#import "UINavigationBar+customBar.h"
#import "BudgetCell.h"
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
    NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
    NSDictionary *plistDic=[[NSDictionary alloc]initWithContentsOfFile:plistPath];
    self.InfoArr=[plistDic valueForKey:@"ys"];
    
    self.view.backgroundColor=[UIColor grayColor];
    self.navigationController.navigationBar.barTintColor=[UIColor lightGrayColor];
    [self.navigationController.navigationBar customNavigationBar];
    
    self.TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    self.TopView.backgroundColor=[UIColor brownColor];
    [self.view addSubview:self.TopView];
    
    self.DTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 150, 320, 418)];
    self.DTableView.delegate=self;
    [self.DTableView setDataSource:self];
    [self.DTableView setScrollEnabled:NO];
    self.DTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.DTableView];
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.InfoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    BOOL nibsRegistered=NO;
    if(!nibsRegistered){
        UINib *nib=[UINib nibWithNibName:@"BudgetCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered=YES;
    }
    BudgetCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.topic.text=[[self.InfoArr objectAtIndex:indexPath.row]valueForKey:@"name"];
    cell.topPic.image=[UIImage imageNamed:[[self.InfoArr objectAtIndex:indexPath.row] valueForKey:@"pic"]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
