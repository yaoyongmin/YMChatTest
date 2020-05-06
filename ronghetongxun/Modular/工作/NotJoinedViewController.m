//
//  NotJoinedViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/5/6.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "NotJoinedViewController.h"
#import "NotJoinMeetingCell.h"
@interface NotJoinedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NotJoinedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NotJoinMeetingCell class]) bundle:nil] forCellReuseIdentifier:@"NotJoinMeetingCell_id"];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NotJoinMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotJoinMeetingCell_id" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 88;
}
@end
