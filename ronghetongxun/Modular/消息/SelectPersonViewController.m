//
//  SelectPersonViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/13.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "SelectPersonViewController.h"
#import "SelectPersonViewCell.h"
#import "SelectContactsHeaderView.h"

#import <UIView+MJExtension.h>
#import "UIColor+YM.h"
@interface SelectPersonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet SelectContactsHeaderView *headerView;

@property (strong, nonatomic) NSMutableArray *selectArray;


@end

@implementation SelectPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择联系人";
    
    [self setNavigationItem:@"取消"
                  imageName:@""
                   position:itemLeft
                  addTarget:self
                     action:@selector(popSelfViewControllerAction)];
    
    [self setNavigationItemWithView:self.rightBtn
                             position:itemRight];
    
    self.tableView.editing = YES;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectPersonViewCell class]) bundle:nil] forCellReuseIdentifier:@"SelectPersonViewCell_id"];
}
///leftAction
- (void)popSelfViewControllerAction{
    [self.navigationController popViewControllerAnimated:YES];
}
///rightAction
- (void)conpleteSelectAction{
    
    [self.navigationController popViewControllerAnimated:NO];

    self.foundBlock(@{});
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SelectPersonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPersonViewCell_id" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.selectArray addObject:indexPath];
    
    [self.headerView setData:self.selectArray];
    
    if (self.selectArray.count > 0) {
        [self.rightBtn setUserInteractionEnabled:YES];
        [self.rightBtn setTitle:[NSString stringWithFormat:@"完成%ld",self.selectArray.count] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor ym_colorFromHexString:@"3D8BEC"] forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor whiteColor]];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.selectArray containsObject: indexPath]) {
        [self.selectArray removeObject:indexPath];
        [self.headerView setData:self.selectArray];
    }
    
    if (self.selectArray.count <= 0) {
        [self.rightBtn setUserInteractionEnabled:NO];
        [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor ym_colorFromHexString:@"#DDDDDD"]];
        [self.rightBtn setTitleColor:[UIColor ym_colorFromHexString:@"#B1AEAE"] forState:UIControlStateNormal];
    }else{
        
        [self.rightBtn setTitle:[NSString stringWithFormat:@"完成%ld",self.selectArray.count] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor ym_colorFromHexString:@"3D8BEC"] forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor whiteColor]];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), 50)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 30, 30)];
    imgView.backgroundColor = [UIColor redColor];
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 15.f;
    [view addSubview:imgView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(56, 10, kScreenWidth()-56-16, 30)];
    titleLab.text = @"测试";
    [view addSubview:titleLab];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), 10)];
        view.backgroundColor = [UIColor ym_colorFromHexString:@"#EDEDED"];
        return view;
    }else{
        return [UIView new];
    }
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_rightBtn setBackgroundColor:[UIColor ym_colorFromHexString:@"#DDDDDD"]];
        [_rightBtn setTitleColor:[UIColor ym_colorFromHexString:@"#B1AEAE"] forState:UIControlStateNormal];
        [_rightBtn setUserInteractionEnabled:NO];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        [_rightBtn setMj_size:CGSizeMake(55, 25)];
        [_rightBtn addTarget:self action:@selector(conpleteSelectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
@end
