//
//  BaseNavigationController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseNavigationController.h"




#import "UserInfoViewController.h"
#import "MessageSearchVC.h"
#import "UIColor+YM.h"
@interface BaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    self.navigationBar.barTintColor = [UIColor ym_colorFromHexString:@"#3D8BEC"];
    self.navigationBar.translucent = NO;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
    NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    
    self.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

///隐藏导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[MessageSearchVC class]]||
        [viewController isKindOfClass:[UserInfoViewController class]]
        ) {
        [self setNavigationBarHidden:YES animated:YES];
    }else{
        [self setNavigationBarHidden:NO animated:YES];
    }
}

///隐藏显示tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}
@end
