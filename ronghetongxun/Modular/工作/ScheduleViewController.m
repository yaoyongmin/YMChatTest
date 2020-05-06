//
//  ScheduleViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/28.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ScheduleViewController.h"
#import "CreateTripViewController.h"
#import <FSCalendar.h>
#import "ScheduleCell.h"
#import "UIColor+YM.h"
@interface ScheduleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) FSCalendar *calendar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *addBtn;

@end

static const CGFloat calendarHeight = 260;

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日程";
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    [self addCalendarView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addBtn];
}

- (void)addScheduleAction{
    [self.navigationController pushViewController:[[CreateTripViewController alloc]init] animated:YES];
}
- (void)addCalendarView{
    FSCalendar *calendar                    = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), calendarHeight)];
    calendar.allowsSelection                = NO;
    calendar.backgroundColor                = [UIColor ym_colorFromHexString:@"#3D8BEC"];
    calendar.appearance.headerTitleColor    = [UIColor whiteColor];
    calendar.appearance.weekdayTextColor    = [UIColor whiteColor];
    calendar.appearance.titleDefaultColor   = [UIColor whiteColor];
    calendar.appearance.titleSelectionColor = [UIColor ym_colorFromHexString:@"#3D8BEC"];
    calendar.appearance.selectionColor      = [UIColor whiteColor];
    calendar.appearance.titleTodayColor     = [UIColor ym_colorFromHexString:@"#3D8BEC"];
    calendar.appearance.todayColor          = [UIColor whiteColor];
    [self.view addSubview:calendar];
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"icon_richeng_add"] forState:UIControlStateNormal];
        [_addBtn setFrame:CGRectMake(kScreenWidth()-40-10, kScreenHeight()-kHomeIndicatorHeight()- kNavigationStatusHeight()-80, 40, 40)];
        [_addBtn addTarget:self action:@selector(addScheduleAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view bringSubviewToFront:_addBtn];
    }
    return _addBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectMake(0, calendarHeight, kScreenWidth(), kScreenHeight()-calendarHeight-kNavigationStatusHeight()) style:UITableViewStyleGrouped];
        _tableView.backgroundColor                = [UIColor ym_colorFromHexString:@"F7F8F9"];
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ScheduleCell class]) bundle:nil] forCellReuseIdentifier:@"ScheduleCell_id"];
    }
    return _tableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ScheduleCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"ScheduleCell_id" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
@end
