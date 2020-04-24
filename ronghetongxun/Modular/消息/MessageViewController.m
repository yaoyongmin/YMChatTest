//
//  MessageViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MessageViewController.h"
#import "AddContactPersonViewController.h"
#import "SelectPersonViewController.h"
#import "ChatViewController.h"
#import "MessageSearchVC.h"
#import "QRCodeViewController.h"
#import "JJDecoderViewController.h"
#import "ChatViewController.h"
#import "GroupDataViewController.h"

#import "SocketModel.h"
#import "DBRecorder.h"

#import "MessageViewCell.h"
#import "MessageMoreView.h"
#import "Define.h"

#import "YMGroup.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,MessageMoreViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *tipsView;

@property (strong, nonatomic) MessageMoreView *moreView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem:@"more"
                  imageName:@""
                   position:itemRight
                  addTarget:self
                     action:@selector(moreAction)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageViewCell class]) bundle:nil] forCellReuseIdentifier:@"messageViewCell_id"];
    
    [self loadDataSource];
}

- (void)loadDataSource
{
    YMGroup *group      = [[YMGroup alloc] init];
    group.unReadCount   = 99;
    group.gName         = @"iOS交流群";
    group.gType         = ICGroup_MULTI;
    group.lastMsgString = @"这个bug改不了！！!";
    
    YMGroup *group1         = [[YMGroup alloc] init];
    group1.unReadCount      = 1;
    group1.gName            = @"马云";
    group1.lastMsgString    = @"支付宝到账一个小目标！";
    group1.gType             = ICGroup_DOUBLE;
    [self.dataArray addObject:group];
    [self.dataArray addObject:group1];
}

///点击右上角更多
- (void)moreAction{
    if ([self.moreView isShowState]) {
        [self.moreView dismiss];
    }else{
        [self.moreView show:self.view];
    }
}

- (IBAction)pushMsgSearchAction:(id)sender {
    MessageSearchVC *msgVC = [[MessageSearchVC alloc] init];
    [self.navigationController pushViewController:msgVC animated:NO];
}

#pragma make messageMoreViewDelegate
- (void)messageMoreView:(MessageMoreView *)moreView didSelectRowAtIndex:(NSInteger)index{
    WeakSelf;
    switch (index) {
        case 0:{
            [self.moreView dismiss];
            
            SelectPersonViewController *selectPersonVC = [[SelectPersonViewController alloc]init];
            selectPersonVC.foundBlock = ^(id  _Nonnull data) {
                ///新建群聊
                YMGroup *group      = [YMGroup new];
                group.gId           = @"999";
                group.gName         = @"新建群聊";
                group.gType         = ICGroup_MULTI;
                group.lastMsgString = @"新建群聊成功！";
//                group.userList      = @[];
                [self.dataArray addObject:group];
                [self.tableView reloadData];
                
                ChatViewController *groupCharVc = [[ChatViewController alloc] init];
                groupCharVc.group = group;
                [weakSelf.navigationController pushViewController:groupCharVc animated:NO];
            };
            [self.navigationController pushViewController:selectPersonVC animated:YES];
        }
            break;
        case 1:{
            [self.moreView dismiss];
            AddContactPersonViewController *vc = [[AddContactPersonViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            [self.moreView dismiss];
            WeakSelf
            JJDecoderViewController *qrCodeVC = [[JJDecoderViewController alloc] initWithBlock:^(NSString *content, BOOL isScceed) {
                if (isScceed) {
                    GroupDataViewController *groupDataVC = [[GroupDataViewController alloc] init];
                    [weakSelf.navigationController pushViewController:groupDataVC animated:YES];
                }else{
                }
            }];
            qrCodeVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:qrCodeVC animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}

#pragma make tableViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageViewCell_id" forIndexPath:indexPath];
    cell.group = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YMGroup *group               = self.dataArray[indexPath.row];
    ChatViewController *chatVc   = [[ChatViewController alloc] init];
    chatVc.group                 = group;
    [self.navigationController pushViewController:chatVc animated:YES];
    
    [tableView reloadData];
}

//从iOS11开始该方法被废弃 <=ios11
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了置顶 iOS11以下");
    }];
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除 iOS11以下");
    }];
    return @[deleteRowAction,topRowAction];
}

// Swipe actions  >=ios11
// These methods supersede -editActionsForRowAtIndexPath: if implemented
// return nil to get the default swipe actions
- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    
    UIContextualAction *topRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"置顶" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"点击了置顶");
    }];
    
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"点击了删除");
        
        [tableView reloadData];
    }];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,topRowAction]];
    return config;
}

#pragma makr lazy
- (MessageMoreView *)moreView{
    if (!_moreView) {
        _moreView = [[MessageMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), self.view.frame.size.height)];
        _moreView.delegate = self;
    }
    return _moreView;
}

- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}
@end
