//
//  CustomCell.h
//  随手记
//
//  Created by OPSOFT on 13-12-31.
//  Copyright (c) 2013年 OPSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *TimeImage;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *DateSet;
@property (weak, nonatomic) IBOutlet UILabel *Revenue;
@property (weak, nonatomic) IBOutlet UILabel *Payment;

@end
