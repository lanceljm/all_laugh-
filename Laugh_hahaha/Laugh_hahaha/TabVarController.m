//
//  TabVarController.m
//  Laugh_hahaha
//
//  Created by ljm on 2017/8/2.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "TabVarController.h"

@interface TabVarController ()

@end

@implementation TabVarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initWithNavigationAndTabbar];
    }
    return self;
}

#pragma mark -- 设置状态栏和导航栏
- (void) initWithNavigationAndTabbar
{
    /** TextViewController **/
    [self addChildViewControllerWithClassName:  @"TextViewController"
                                    withTitle:  @"笑话"
                                withImageName:  @"text"
                        withSelectedImageName:  @"text_selected"];
    
    /** ImageViewController **/
    [self addChildViewControllerWithClassName:  @"ImageViewController"
                                    withTitle:  @"图片"
                                withImageName:  @"image"
                        withSelectedImageName:  @"image_selected"];

    /** GifViewController **/
    [self addChildViewControllerWithClassName:  @"GifViewController"
                                    withTitle:  @"动图"
                                withImageName:  @"gif"
                        withSelectedImageName:  @"gif_selected"];
    
}

#pragma mark -- 自定义导航栏和状态栏
- (void) addChildViewControllerWithClassName : (NSString *) className withTitle : (NSString *) title withImageName : (NSString *) imageName withSelectedImageName : (NSString *) selectedImageNmae
{
    
    UIViewController *vc    =   [[NSClassFromString(className) alloc] init];
    vc.title                =   title;
    vc.tabBarItem           =   [[UITabBarItem alloc] init];
    vc.tabBarItem.title     =   title;
    vc.tabBarItem.image     =   [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageNmae] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nvc.navigationBar.barTintColor = RGBColor(90, 190, 250, 1.f);
    nvc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    nvc.navigationBar.tintColor = [UIColor whiteColor];
    
    [self addChildViewController:nvc];
    
}


@end
