//
//  CallLogViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/30.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "CallLogViewController.h"
#import "AllCallViewController.h"
#import "UIColor+YM.h"
@interface CallLogViewController ()
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *missedBtn;

@property (strong, nonatomic) UIViewController *currentVC;
@property (strong, nonatomic) AllCallViewController *missedCallVC;
@property (strong, nonatomic) AllCallViewController *allCallVC;

@end

@implementation CallLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通话记录";
    self.view.frame = CGRectMake(0, 0, kScreenWidth(), kScreenHeight()-kNavigationStatusHeight());
    
    self.allCallVC = [[AllCallViewController alloc] init];
    self.allCallVC.isAll = YES;
    [self addChildViewController:self.allCallVC];
    [self.allCallVC didMoveToParentViewController:self];
    [self.allCallVC.view setFrame:CGRectMake(0, 60, kScreenWidth(), kScreenHeight()-kNavigationStatusHeight()-60)];
    self.currentVC = self.allCallVC;
    [self.view addSubview:self.currentVC.view];
    
    self.missedCallVC = [[AllCallViewController alloc] init];
    self.missedCallVC.isAll = NO;
    [self.missedCallVC.view setFrame:CGRectMake(0, 60, kScreenWidth(), kScreenHeight()-kNavigationStatusHeight()-60)];
}
- (IBAction)allBtnAction:(UIButton *)sender {
    sender.selected = YES;
    
    [sender setBackgroundColor:[UIColor whiteColor]];
    [self.missedBtn setBackgroundColor:[UIColor ym_colorFromHexString:@"F1F2F3"]];
    
    if (self.currentVC != self.allCallVC) {
        [self changeControllerFromOldController:self.currentVC toNewController:self.allCallVC];
    }
}
- (IBAction)missedBtnAction:(UIButton *)sender {
    sender.selected = YES;
    
    [sender setBackgroundColor:[UIColor whiteColor]];
    [self.allBtn setBackgroundColor:[UIColor ym_colorFromHexString:@"F1F2F3"]];
    
    if (self.currentVC !=self.missedCallVC) {
        [self changeControllerFromOldController:self.currentVC toNewController:self.missedCallVC];
    }
}

#pragma mark - 切换viewController
- (void)changeControllerFromOldController:(UIViewController *)oldController toNewController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    
    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
            self.currentVC = oldController;
        }
    }];
}

@end
