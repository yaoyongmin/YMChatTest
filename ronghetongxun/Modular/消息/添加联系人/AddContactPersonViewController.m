//
//  AddContactPersonViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "AddContactPersonViewController.h"
#import "UserInfoViewController.h"
#import "UIColor+YM.h"
@interface AddContactPersonViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddContactPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor ym_colorFromHexString:@"#F7F8F9"];
    
    [self setSubviewsAttribute];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark --- 搜索框开始编辑 ---
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    
    UIButton*cancelBtn = [searchBar valueForKey:@"cancelButton"];
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor ym_colorFromHexString:@"#3D8BEC"] forState:UIControlStateNormal];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
}
- (void)keyboardWillHide:(NSNotification *)notification{
    self.searchBar.showsCancelButton = NO;
}

#pragma makr textField监听输入
- (BOOL)textFieldEditChanged:(UITextField *)textField{
    NSLog(@"开始搜索：%@",textField.text);
    [self.tableView reloadData];
    return YES;
}

#pragma mark tableviewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell_id" forIndexPath:indexPath];
    cell.textLabel.text = @"12313";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoViewController *userInfoVc = [[UserInfoViewController alloc] init];
    
    [self.navigationController pushViewController:userInfoVc animated:YES];
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setSubviewsAttribute{
    
     self.searchBar.backgroundImage = [[UIImage alloc] init];
     self.searchBar.barTintColor = [UIColor whiteColor];
     
     UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
     if (searchField) {
         [searchField setBackgroundColor:[UIColor whiteColor]];
         searchField.layer.cornerRadius = 2.0f;
         searchField.layer.masksToBounds = YES;
         searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
         [searchField addTarget:self
                   action:@selector(textFieldEditChanged:)
         forControlEvents:UIControlEventEditingChanged];
     }
    
     self.tableView.tableFooterView = [UIView new];
     [self.tableView registerClass:[UITableViewCell class]
            forCellReuseIdentifier:@"UITableViewCell_id"];
}

@end
