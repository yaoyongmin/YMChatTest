//
//  AppDelegate.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "LoginViewController.h"
#import "AppDelegate+Configure.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
//    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (![UserConfig kIsLogin]) {
        
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [[LoginViewController alloc]init]];
    }else{
        self.window.rootViewController = [[RootTabBarController alloc]init];
    }
    [self.window makeKeyAndVisible];
    [self configure];
    
    return YES;
}

@end
