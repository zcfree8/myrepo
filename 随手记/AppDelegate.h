//
//  AppDelegate.h
//  随手记
//
//  Created by OPSOFT on 13-12-30.
//  Copyright (c) 2013年 OPSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) IIViewDeckController *viewDeckController;
@property(strong,nonatomic) ViewController *viewController;
@end
