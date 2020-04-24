//
//  GroupNoticeViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "GroupNoticeViewController.h"
#import "GroupNoticeCell.h"
@interface GroupNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GroupNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群公告";
    
    [self.view addSubview:self.tableView];

}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GroupNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupNoticeCell_id" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GroupNoticeCell class]) bundle:nil] forCellReuseIdentifier:@"GroupNoticeCell_id"];
    }
    return _tableView;
}
@end
