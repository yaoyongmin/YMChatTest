//
//  LaunchMeetingViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/29.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "LaunchMeetingViewController.h"
#import "MeetingController.h"
#import "NSDate+Extend.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "CXDatePickerView.h"
#import "MeetingThemeView.h"
@interface LaunchMeetingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIButton *tableviewFooterView;

@property (weak, nonatomic) IBOutlet MeetingThemeView *themeView;
@property (strong, nonatomic) NSMutableArray <LaunchMeetingModel *>*dataArray;

///记录上一次选择的时间，后选择的时间不得超过上次选择的时间
//@property (assign, nonatomic) NSInteger lastTime;

@end

@implementation LaunchMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起会议";
    self.tableView.tableFooterView = self.tableviewFooterView;
    [self.tableView registerClass:[LaunchMeetingCell class] forCellReuseIdentifier:@"LaunchMeetingCell_id"];
}

- (void)addMeetingTheme{
    LaunchMeetingModel *model   = [[LaunchMeetingModel alloc] init];
    model.startTime             = [NSDate currentTimeString];
    model.endTime               = [NSDate currentTimeString];
    model.themeText             = @"";
    [self.dataArray addObject:model];
    [self.tableView reloadData];
}
- (IBAction)startMeetingAction:(id)sender {
    ///取消输入框第一响应者  触发输入结束代理方法 重置对应的model数据
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    for (LaunchMeetingModel *model in self.dataArray) {
        
        NSLog(@"输入的内容：%@",model.themeText);
    }
    
    MeetingController *mc = [[MeetingController alloc] init];
    
    [self.navigationController pushViewController:mc animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LaunchMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LaunchMeetingCell_id" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.section];
    
    cell.meetingThemeView.endTimeBlock = ^(NSString * _Nonnull dateString){
        LaunchMeetingModel *model = self.dataArray[indexPath.section];
        [model setEndTime:dateString];
        [tableView reloadData];
    };
    cell.meetingThemeView.startTimeBlock = ^(NSString * _Nonnull dateString){
        LaunchMeetingModel *model = self.dataArray[indexPath.section];
        [model setStartTime:dateString];
        [tableView reloadData];
    };
    cell.meetingThemeView.startInputBlock = ^(NSString * _Nonnull text) {
        LaunchMeetingModel *model = self.dataArray[indexPath.section];
        [model setThemeText:text];
    };
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ///单条高度45 * 3
    return 135;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HeaderInSectionView *headerView = [[HeaderInSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), 40)];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIButton *)tableviewFooterView{
    if (!_tableviewFooterView) {
        _tableviewFooterView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tableviewFooterView setFrame:CGRectMake(0, 0, kScreenWidth(), 40)];
        [_tableviewFooterView setTitle:@"添加会议议题" forState:UIControlStateNormal];
        [_tableviewFooterView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_tableviewFooterView setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _tableviewFooterView.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [_tableviewFooterView addTarget:self action:@selector(addMeetingTheme) forControlEvents:UIControlEventTouchUpInside];
        [_tableviewFooterView.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    }
    return _tableviewFooterView;
}

- (NSMutableArray <LaunchMeetingModel *>*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

@implementation HeaderInSectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLab];
        [self addSubview:self.deleteBtn];
    }
    return self;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab           = [[UILabel alloc] init];
        _titleLab.frame     = CGRectMake(16, 0, 80, 40);
        _titleLab.text      = @"议题";
        _titleLab.font      = [UIFont systemFontOfSize:14.f];
        _titleLab.textColor = [UIColor lightGrayColor];
    }
    return _titleLab;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setFrame:CGRectMake(kScreenWidth()- 16 - 80, 0, 80, 40)];
        [_deleteBtn setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    }
    return _deleteBtn;
}
@end

@implementation LaunchMeetingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.meetingThemeView];
    }
    return self;
}

- (void)layoutSubviews{
    self.meetingThemeView.frame = CGRectMake(16, 0, self.frame.size.width-32, self.frame.size.height);
}

- (void)setModel:(LaunchMeetingModel *)model{
    _model = model;
    
    self.meetingThemeView.themeTextField.text = model.themeText;
    [self.meetingThemeView.startTimeBtn setTitle:model.startTime forState:UIControlStateNormal];
    [self.meetingThemeView.endTimeBtn setTitle:model.endTime forState:UIControlStateNormal];
}
- (MeetingThemeView *)meetingThemeView{
    if (!_meetingThemeView) {
        _meetingThemeView = [[MeetingThemeView alloc] init];
    }
    return _meetingThemeView;
}

@end
