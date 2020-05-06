//
//  MyViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MyViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"
#import "MyTableViewCell.h"
#import "YMAlertView.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[
        @{@"title":@"我的名片",
          @"image":@"icon_my_1",
        },
        @{@"title":@"清理聊天记录",
          @"image":@"icon_my_2",
        },
        @{@"title":@"关于融合通信",
          @"image":@"icon_my_3",
        },
        @{@"title":@"退出登录",
          @"image":@"icon_my_4",
        },
    ];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MyTableViewCell_id"];
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MyTableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell_id" forIndexPath:indexPath];
    cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    cell.imgView.image      = [UIImage imageNamed:_dataArray[indexPath.row][@"image"]];
    cell.titleLab.text      = _dataArray[indexPath.row][@"title"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:{
            AboutViewController *aboutVC = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

#pragma mark 退出登录action
- (void)signOutAction{

    ///退出登录清除数据等事件 调用退出登录接口
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [[LoginViewController alloc]init]];
}
@end
