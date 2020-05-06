//
//  WorkViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "WorkViewController.h"
#import "ScheduleViewController.h"
#import "VideoMeetingViewController.h"
#import "WorkMoreViewController.h"
#import "UIView+RoundedBorder.h"
@interface WorkViewController ()

@property (weak, nonatomic) IBOutlet UIView *workView;

@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.workView setRoundedWithBorder];
    
    [[YMRequest sharedManager] postRequest:kGetUserInfo params:@{} success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {

        NSLog(@"个人信息：%@",data);
    } failure:^(NSError * _Nullable error) {

    }];
}
- (IBAction)scheduleAction:(id)sender {
    ScheduleViewController *vc = [[ScheduleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)meetingAction:(id)sender {
    VideoMeetingViewController *vc = [[VideoMeetingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)moreAction:(id)sender {
    WorkMoreViewController *vc = [[WorkMoreViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
