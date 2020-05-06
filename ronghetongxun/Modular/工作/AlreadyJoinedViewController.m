//
//  AlreadyJoinedViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/5/6.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "AlreadyJoinedViewController.h"
#import "AlreadyJoinMeetingCell.h"
@interface AlreadyJoinedViewController ()<UITableViewDelegate,UITableViewDataSource>;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AlreadyJoinedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AlreadyJoinMeetingCell class]) bundle:nil] forCellReuseIdentifier:@"AlreadyJoinMeetingCell_id"];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AlreadyJoinMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlreadyJoinMeetingCell_id" forIndexPath:indexPath];
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
