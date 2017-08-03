//
//  RootViewController.m
//  Laugh_hahaha
//
//  Created by ljm on 2017/8/2.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "TabVarController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setControllers];
}

- (void) setControllers
{
    [self setupLaunch];
    
    [self setupTabbar];
}

#pragma mark -- set tabbar
- (void) setupTabbar
{
    TabVarController *tabbarvc = [[TabVarController alloc] init];
    [self.view addSubview:tabbarvc.view];
    [self addChildViewController:tabbarvc];
}

#pragma mark -- set launch
- (void) setupLaunch
{
    LoginViewController *loginvc = [[LoginViewController alloc] init];
    [self addChildViewController:loginvc];
    [self.view addSubview:loginvc.view];
}


@end
