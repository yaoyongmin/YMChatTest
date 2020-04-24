//
//  UserInfoViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ChatViewController.h"
#import "UserInfoCell.h"
#import "UIColor+YM.h"
#import "YMAlertView.h"
@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_infoDataArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *userSexImgView;
@property (weak, nonatomic) IBOutlet UILabel *userCompanyLab;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ym_colorFromHexString:@"F7F8F9"];
    _infoDataArray = @[@{@"title":@"公司",@"content":@"青岛融合通信有限公司"},
                       @{@"title":@"手机",@"content":@"18353675618"},
                       @{@"title":@"分机号",@"content":@"18353675618"},
                       @{@"title":@"部门",@"content":@"开发部"},
    ];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserInfoCell class]) bundle:nil] forCellReuseIdentifier:@"UserInfoCell_id"];
}
- (IBAction)popViewControllerAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sendMessageAction:(id)sender {
    
    ChatViewController *vc = [[ChatViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)phoneAction:(id)sender {
    
    YMAlertView *alertView = [YMAlertView alertControllerWithTitle:@"请选择拨打方式" dataList:[self getPhoneAlertData]];
    
    [alertView show];
}
- (IBAction)sendMailAction:(id)sender {
    
}
- (IBAction)addMailListAction:(id)sender {
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell_id" forIndexPath:indexPath];
    
    cell.titleLab.text = _infoDataArray[indexPath.row][@"title"];
    [cell.contentBtn setTitle:_infoDataArray[indexPath.row][@"content"] forState:UIControlStateNormal];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infoDataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

- (NSArray <YMAlertModel *>*)getPhoneAlertData{
    
    NSMutableArray <YMAlertModel *> *listArray = [NSMutableArray array];
    YMAlertModel *model = [YMAlertModel new];
    model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [model setValuesForKeysWithDictionary:@{@"content":@"视频通话",@"imageName":@"icon_userinfo_video"}];
    [listArray addObject:model];
    YMAlertModel *model1 = [YMAlertModel new];
    model1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [model1 setValuesForKeysWithDictionary:@{@"content":@" 语音通话",@"imageName":@"icon_userinfo_voice"}];
    [listArray addObject:model1];
    YMAlertModel *model2 = [YMAlertModel new];
    model2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [model2 setValuesForKeysWithDictionary:@{@"content":@"普通电话",@"imageName":@"icon_userinfo_dial"}];
    [listArray addObject:model2];
    return listArray;
}
@end
