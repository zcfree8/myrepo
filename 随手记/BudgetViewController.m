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
    
    self.navigationController.navigationBarHidden=NO;
}


-(void)refresh:(id)sender{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *barBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_action_bar_refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem=barBtn;
    NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
    NSDictionary *plistDic=[[NSDictionary alloc]initWithContentsOfFile:plistPath];
    self.InfoArr=[plistDic valueForKey:@"bz"];
    
    self.view.backgroundColor=[UIColor grayColor];
    self.navigationController.navigationBar.barTintColor=[UIColor lightGrayColor];
    [self.navigationController.navigationBar customNavigationBar];
    
    self.TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 150)];
    self.TopView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:self.TopView];
    [self setTopView];
    self.DTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 150, 320, 418)];
    self.DTableView.delegate=self;
    [self.DTableView setDataSource:self];
    if([self.InfoArr count]<=6){
       [self.DTableView setScrollEnabled:NO];
    }
    self.DTableView.backgroundColor=[UIColor whiteColor];
    self.DTableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.DTableView];
    // Do any additional setup after loading the view from its nib.
}


-(void)setTopView{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
    line.backgroundColor=[UIColor blackColor];
    UIView *cline=[[UIView alloc]initWithFrame:CGRectMake(159.5, 43, 1, 43)];
    cline.backgroundColor=[UIColor blackColor];
    [self.TopView addSubview:cline];
    [self.TopView addSubview:line];
    
    UILabel *labelzys=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 20)];
    labelzys.text=@"总预算:";
    labelzys.textColor=[UIColor whiteColor];
    labelzys.font=[UIFont fontWithName:@"Helvetica-Bold" size:17];
    [self.TopView addSubview:labelzys];
    
    UILabel *labelyy=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 30, 15)];
    labelyy.text=@"已用:";
    labelyy.textColor=[UIColor whiteColor];
    labelyy.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.TopView addSubview:labelyy];
    
    UILabel *labelky=[[UILabel alloc]initWithFrame:CGRectMake(170, 55, 30, 15)];
    labelky.text=@"可用:";
    labelky.textColor=[UIColor whiteColor];
    labelky.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.TopView addSubview:labelky];
    
    self.labelAll=[[UITextField alloc]initWithFrame:CGRectMake(275, 10, 50, 20)];
    self.labelAll.text=@"0.00";
    self.labelAll.textColor=[UIColor whiteColor];
    self.labelAll.returnKeyType=UIReturnKeyDone;
    [self.labelAll addTarget:self action:@selector(didEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.labelAll addTarget:self action:@selector(appendHighlightedColor) forControlEvents:UIControlEventTouchDown];
    [self.labelAll addTarget:self action:@selector(removeHighlightColor) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragOutside|UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventEditingDidEndOnExit];
    self.labelAll.delegate=self;
    self.labelAll.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    self.labelAll.font=[UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.TopView addSubview:self.labelAll];

    
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head_icon_edit"]];
    imageView.frame=CGRectMake(self.labelAll.frame.origin.x-35, 12, 15, 15);
    [self.TopView addSubview:imageView];
    
    UILabel *labelP=[[UILabel alloc]initWithFrame:CGRectMake(self.labelAll.frame.origin.x-12, 12, 15, 15)];
    labelP.text=@"¥";
    labelP.textColor=[UIColor whiteColor];
    labelP.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
    [self.TopView addSubview:labelP];
    
    self.labelEnable=[[UILabel alloc]initWithFrame:CGRectMake(110, 55, 40, 15)];
    self.labelEnable.text=@"¥ 0.00";
    self.labelEnable.textColor=[UIColor whiteColor];
    self.labelEnable.font=[UIFont fontWithName:@"Helvetica-Bold"  size:14];
    [self.TopView addSubview:self.labelEnable];
    
    self.labelable=[[UILabel alloc]initWithFrame:CGRectMake(270, 55, 40, 15)];
    self.labelable.text=@"¥ 0.00";
    self.labelable.textColor=[UIColor whiteColor];
    self.labelable.font=[UIFont fontWithName:@"Helvetica-Bold"  size:14];
    [self.TopView addSubview:self.labelable];
    
    self.labelshow=[[UILabel alloc]initWithFrame:CGRectMake(115, 12, 100, 15)];
    self.labelshow.text=@"<点击设置预算>";
    self.labelshow.textColor=[UIColor whiteColor];
    self.labelshow.font=[UIFont fontWithName:@"Helvetica-Bold"  size:12];
    [self.TopView addSubview:self.labelshow];
    [self.labelshow setUserInteractionEnabled:TRUE];
    UIControl *actionView=[[UIControl alloc]initWithFrame:self.labelshow.bounds];
    [actionView setBackgroundColor:[UIColor clearColor]];
    [actionView addTarget:self action:@selector(Tap) forControlEvents:UIControlEventTouchUpInside];
    [self.labelshow addSubview:actionView];
    [self.labelshow sendSubviewToBack:actionView];
    
}


#pragma mark
-(void)appendHighlightedColor{
    self.labelAll.textColor=[UIColor redColor];
}

-(void)removeHighlightColor{
    self.labelAll.textColor=[UIColor whiteColor];
}

- (void)didEndOnExit:(id)sender {
    [sender resignFirstResponder];
    self.labelable.text=[NSString stringWithFormat:@"¥ %@",self.labelAll.text];
}

-(void)Tap{
    [self.labelAll becomeFirstResponder];
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
