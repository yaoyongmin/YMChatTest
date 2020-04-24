//
//  BaseViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)popVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationItem:(NSString *)title imageName:(NSString *)name position:(ItemPosition)position addTarget:(id)target action:(SEL)action{
    
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [item.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    switch (position) {
        case itemLeft:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:item];
            break;
        case itemRight:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:item];
            break;
        default:
            break;
    }
}

- (void)setNavigationItemWithButton:(UIButton *)button position:(ItemPosition)position{
    
    switch (position) {
        case itemLeft:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
            break;
        case itemRight:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
            break;
        default:
            break;
    }
}

-(void)dealloc{
    NSLog(@"%@已释放!",[self class]);
}

@end
