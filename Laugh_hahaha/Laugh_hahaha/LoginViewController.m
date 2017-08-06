//
//  LoginViewController.m
//  Laugh_hahaha
//
//  Created by EPIC_IOS on 2017/8/1.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LoginViewController.h"
#import "TabVarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,kselfWidth,kselfHeight)];
    image.image = [UIImage imageNamed:@"launch"];
    [self.view addSubview:image];
    [self performSelector:@selector(DismissVc:) withObject:self afterDelay:1.0f];
    
}

#pragma mark -- 定时消失
- (void) DismissVc : (id) sender
{
    [self presentViewController: [TabVarController new] animated:YES completion:nil];
    
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}


@end
