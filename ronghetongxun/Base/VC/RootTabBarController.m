//
//  RootTabBarController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "RootTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseTabBar.h"
#import "UIImage+Extend.h"
@interface RootTabBarController ()<UITabBarControllerDelegate>

@end

static NSString *const tabbar_image_1_highlighted = @"icon_tabbar_msg2";
static NSString *const tabbar_image_2_highlighted = @"icon_tabbar_work2";
static NSString *const tabbar_image_3_highlighted = @"";
static NSString *const tabbar_image_4_highlighted = @"icon_tabbar_Telephone2";
static NSString *const tabbar_image_5_highlighted = @"icon_tabbar_my2";

static NSString *const tabbar_image_1 = @"icon_tabbar_msg1";
static NSString *const tabbar_image_2 = @"icon_tabbar_work1";
static NSString *const tabbar_image_3 = @"";
static NSString *const tabbar_image_4 = @"icon_tabbar_Telephone1";
static NSString *const tabbar_image_5 = @"icon_tabbar_my1";

static NSString *const tabbar_vc_1 = @"MessageViewController";
static NSString *const tabbar_vc_2 = @"WorkViewController";
static NSString *const tabbar_vc_3 = @"MailListViewController";
static NSString *const tabbar_vc_4 = @"TelephoneViewController";
static NSString *const tabbar_vc_5 = @"MyViewController";

static NSString *const tabbar_title_1 = @"消息";
static NSString *const tabbar_title_2 = @"工作";
static NSString *const tabbar_title_3 = @"通讯录";
static NSString *const tabbar_title_4 = @"电话";
static NSString *const tabbar_title_5 = @"我的";

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setValue:[[BaseTabBar alloc] init] forKeyPath:@"tabBar"];
    
    [self addChildViewControllerClassName:tabbar_vc_1 title:tabbar_title_1 imageName:tabbar_image_1 selectImageName:tabbar_image_1_highlighted];
    [self addChildViewControllerClassName:tabbar_vc_2 title:tabbar_title_2 imageName:tabbar_image_2 selectImageName:tabbar_image_2_highlighted];
    [self addChildViewControllerClassName:tabbar_vc_3 title:tabbar_title_3 imageName:tabbar_image_3 selectImageName:tabbar_image_3_highlighted];
    [self addChildViewControllerClassName:tabbar_vc_4 title:tabbar_title_4 imageName:tabbar_image_4 selectImageName:tabbar_image_4_highlighted];
    [self addChildViewControllerClassName:tabbar_vc_5 title:tabbar_title_5 imageName:tabbar_image_5 selectImageName:tabbar_image_5_highlighted];
    
    //    self.tabBar.layer.borderWidth = 0.50; self.tabBar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    if (@available(iOS 13, *)) {
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        appearance.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
        appearance.shadowImage = [UIImage imageWithColor:[UIColor clearColor]];
        // 官方文档写的是 重置背景和阴影为透明
        //        [appearance configureWithTransparentBackground];
        self.tabBar.standardAppearance = appearance;
    } else {
        self.tabBar.backgroundImage = [UIImage new];
        self.tabBar.shadowImage = [UIImage new];
    }
    
    //添加阴影
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
    self.tabBar.layer.shadowOpacity = 0.6;
    
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
}



- (void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImg{
    UIViewController *viewController = [[NSClassFromString(className) alloc]init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:viewController];
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage=[[UIImage imageNamed:selectImg]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    [self addChildViewController:nav];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(nonnull UIViewController *)viewController{
    if ([viewController.tabBarItem.title isEqualToString:@"通讯录"]) {
        UIViewController *vc3 = [[NSClassFromString(tabbar_vc_3) alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc3 animated:YES completion:nil];
        return NO;
    }
    return YES;
}

-(void)dealloc{
    NSLog(@"%@已释放!",[self class]);
}
@end
