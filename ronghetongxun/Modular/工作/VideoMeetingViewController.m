//
//  VideoMeetingViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/28.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "VideoMeetingViewController.h"
#import "LaunchMeetingViewController.h"
#import "VideoMeetingCell.h"
#import "JoinMeetingPopupView.h"
@interface VideoMeetingViewController ()<UITableViewDelegate,UITableViewDataSource,JoinMeetingPopupViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) JoinMeetingPopupView *passwordPopupView;

@end

@implementation VideoMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频会议";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VideoMeetingCell class]) bundle:nil] forCellReuseIdentifier:@"VideoMeetingCell_id"];
}

- (IBAction)launchMeetingAction:(id)sender {
    LaunchMeetingViewController *launchMeetingVc = [[LaunchMeetingViewController alloc] init];
    [self.navigationController pushViewController:launchMeetingVc animated:YES];
}
- (IBAction)joinMeetingAction:(id)sender {
    
    [self.passwordPopupView show:self.view];
}

- (void)joinMeetingPopupViewWithConfirmAction:(NSString *)password{
    
    NSLog(@"输入的密码为：%@",password);
    ///调用接口 发送加入会议请求
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    VideoMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoMeetingCell_id" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (JoinMeetingPopupView *)passwordPopupView{
    if (!_passwordPopupView) {
        _passwordPopupView = [[JoinMeetingPopupView alloc] initWithFrame:self.view.bounds];
        _passwordPopupView.delegate = self;
    }
    return _passwordPopupView;
}
@end
