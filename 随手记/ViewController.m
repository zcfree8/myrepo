//
//  ViewController.m
//  随手记
//
//  Created by OPSOFT on 13-12-30.
//  Copyright (c) 2013年 OPSOFT. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "TopCell.h"
#import "InventoryViewController.h"
#import "BudgetViewController.h"
#import "InputViewController.h"
#define A self.ATableView
#define degreesToRadinas(x) (M_PI*(x)/180.0)
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    UIView *SubView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 350)];
    //SubView.layer.cornerRadius=10.0;
    SubView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_activity_bg_src"]];
    [self.view addSubview:SubView];
    
    UIButton *addBtn=[[UIButton alloc]initWithFrame:CGRectMake(30, 245, 260, 45)];
    [addBtn setTitle:@"记一笔" forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:24]];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    addBtn.layer.cornerRadius=10.0;
    addBtn.backgroundColor=[UIColor orangeColor];
    [addBtn addTarget:self action:@selector(InputClick:) forControlEvents:UIControlEventTouchUpInside];
    [SubView addSubview:addBtn];
    
    UIImageView *topView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 300, 200)];
    topView.image=[UIImage imageNamed:@"main_top_month_report_bg"];
    topView.userInteractionEnabled=YES;
    UIImageView *battery=[[UIImageView alloc]initWithFrame:CGRectMake(200, 25, 80, 150)];
    battery.image=[UIImage imageNamed:@"widget_battery_bg.9.png"];
    battery.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UserClick:)];
    [battery addGestureRecognizer:singleTap];
    [topView addSubview:battery];
    self.BTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 70, 180, 105)];
    self.BTableView.delegate=self;
    self.BTableView.scrollEnabled=NO;
    self.BTableView.dataSource=self;
    self.BTableView.backgroundColor=[UIColor clearColor];
    [topView addSubview:self.BTableView];
    
    NSDate *date=[NSDate date];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps=[calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:date];
    
    UILabel *LabMon=[[UILabel alloc]initWithFrame:CGRectMake(15, 20, 35, 35)];
    LabMon.textAlignment=NSTextAlignmentCenter;
    LabMon.text=[NSString stringWithFormat:@"%ld",(long)comps.month];
    LabMon.textColor=[UIColor redColor];
    LabMon.font=[UIFont fontWithName:nil size:30];
    [topView addSubview:LabMon];
    
    UILabel *LabYear=[[UILabel alloc]initWithFrame:CGRectMake(50, 32, 50, 20)];
    LabYear.text=[NSString stringWithFormat:@"/ %ld",(long)comps.year];
    LabYear.textColor=[UIColor brownColor];
    LabYear.font=[UIFont fontWithName:nil size:14];
    [topView addSubview:LabYear];
    [SubView addSubview:topView];
    
    self.ATableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 343, 320, 180)];
    self.ATableView.delegate=self;
    //self.ATableView.pagingEnabled=NO;
    self.ATableView.scrollEnabled=NO;
    self.ATableView.dataSource=self;
    [self.view addSubview:self.ATableView];
    
    self.progressView=[[LDProgressView alloc]initWithFrame:CGRectMake(8, 8, 64, 134)];
    self.progressView.animate=@YES;
    self.progressView.progress=0.4;
    self.progressView.borderRadius=@8;
    self.progressView.showText=@NO;
    //self.progressView.type=LDProgressSolid;
    self.progressView.color = [UIColor colorWithRed:0.7 green:0.6 blue:0.5 alpha:0.6];
    [battery addSubview:self.progressView];
    [self.progressView setTransform:CGAffineTransformMakeRotation(degreesToRadinas(180))];
    
    
    // Do any additional setup after loading the view from its nib.
}


-(void)UserClick:(id)sender{
    BudgetViewController *Budget=[[BudgetViewController alloc]initWithNibName:@"BudgetViewController" bundle:nil];
    [self.navigationController pushViewController:Budget animated:YES];
}

-(void)InputClick:(id)sender{
    InputViewController *Input=[[InputViewController alloc]initWithNibName:@"InputViewController" bundle:nil];
    [self.navigationController pushViewController:Input animated:YES];
    
}

#pragma mark tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==A) {
        return 60;
    }else{
        return 35;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==A){
        static NSString *CellIdentifier=@"Cell";
        BOOL nibsRegistered = NO;
        if(!nibsRegistered){
            UINib *nib=[UINib nibWithNibName:@"CustomCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
            nibsRegistered=YES;
        }
        CustomCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        NSDate *date=[NSDate date];
        NSCalendar *calendar=[NSCalendar currentCalendar];
        NSDateComponents *comps;
        if(indexPath.row==0){
            cell.Title.text=@"今天";
            comps=[calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
            cell.DateSet.text=[NSString stringWithFormat:@"%ld年%ld月%ld日",(long)[comps year],(long)[comps month],(long)[comps day]];
            cell.TimeImage.image=[UIImage imageNamed:@"main_today"];
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(8, 15, 20, 15)];
            lab.textAlignment=NSTextAlignmentCenter;
            lab.textColor=[UIColor grayColor];
            lab.text=[NSString stringWithFormat:@"%ld",(long)[comps day]];
            [cell.TimeImage addSubview:lab];
        }else if (indexPath.row==1){
            cell.Title.text=@"本周";
            NSString *WeekString=[self getBeginAndEndWith:date and:NSWeekCalendarUnit];
            cell.DateSet.text=WeekString;
            cell.TimeImage.image=[UIImage imageNamed:@"main_week"];
         }else{
            cell.Title.text=@"本月";
            NSString *MonthString=[self getBeginAndEndWith:date and:NSMonthCalendarUnit];
            cell.DateSet.text=MonthString;
            cell.TimeImage.image=[UIImage imageNamed:@"main_month"];
         }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        static NSString *CellIdentifier=@"Cell";
        BOOL nibsRegistered=NO;
        if(!nibsRegistered){
            UINib *nib=[UINib nibWithNibName:@"TopCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
            nibsRegistered=YES;
        }
        TopCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.backgroundColor=[UIColor clearColor];
        if(indexPath.row==0){
            cell.Title.text=@"收入总额:";
        }else if (indexPath.row==1){
            cell.Title.text=@"支出总额:";
        }else{
            cell.Title.text=@"预算余额:";
            cell.Value.text=@"";
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InventoryViewController *Inventory=[[InventoryViewController alloc]initWithNibName:@"InventoryViewController" bundle:nil];
    if(tableView==A){
        
    }else{
    
    
    }
    [self.navigationController pushViewController:Inventory animated:YES];
}

-(NSString *)getBeginAndEndWith:(NSDate *)newDate and:(NSCalendarUnit)calendarUnit{
    if(newDate==nil)
        newDate=[NSDate date];
    double interval=0;
    NSDate *beginDate=nil;
    NSDate *endDate=nil;
    NSCalendar *calendar=[NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    BOOL ok=[calendar rangeOfUnit:calendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    if(ok)
        endDate=[beginDate dateByAddingTimeInterval:interval-1];
    else
        return nil;
    NSDateFormatter *myDateFormatter=[[NSDateFormatter alloc]init];
    [myDateFormatter setDateFormat:@"MM月dd日"];
    NSString *beginString=[myDateFormatter stringFromDate:beginDate];
    NSString *endString=[myDateFormatter stringFromDate:endDate];
    NSString *str=[NSString stringWithFormat:@"%@-%@",beginString,endString];
    return str;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)arrow:(id)sender {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}





@end
