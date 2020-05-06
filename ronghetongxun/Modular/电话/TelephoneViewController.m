//
//  TelephoneViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "TelephoneViewController.h"
#import "UIView+RoundedBorder.h"
#import "DialViewController.h"
#import "CallLogViewController.h"
@interface TelephoneViewController ()

@property (weak, nonatomic) IBOutlet UIView *telView;

@end

@implementation TelephoneViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.telView setRoundedWithBorder];
    
    
}
- (IBAction)dialAction:(id)sender {
    
    DialViewController *dialVC = [[DialViewController alloc] init];
    [self.navigationController pushViewController:dialVC animated:YES];
}
- (IBAction)mailListAction:(id)sender {
}
- (IBAction)callLogAction:(id)sender {
    CallLogViewController *callLogVC = [[CallLogViewController alloc] init];
    [self.navigationController pushViewController:callLogVC animated:YES];
}

-(void)dealloc{
    NSLog(@"%@已释放!",[self class]);
}
@end
