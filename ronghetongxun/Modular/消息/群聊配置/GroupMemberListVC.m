//
//  GroupMemberListVC.m
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "GroupMemberListVC.h"
#import "GroupMembersCell.h"

#import "FriendModel.h"
#import "ContactDataHelper.h"
#import "NSString+Utils.h"

@interface GroupMemberListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *groupOwnerLab;
@property (weak, nonatomic) IBOutlet UIImageView *groupOwnerHeadImgView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic,strong) NSMutableArray *sectionTitles;
@property (nonatomic,strong) NSMutableArray *contactsSource;
@property (nonatomic,strong) NSMutableArray * foldArray;
@end

@implementation GroupMemberListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群成员";
        
    _sectionTitles = [[NSMutableArray alloc] init];
    _contactsSource = [[NSMutableArray alloc] init];
    _foldArray = [[NSMutableArray alloc] init];
    
    [self setNavigationItem:@"添加" imageName:@"" position:itemRight addTarget:self action:@selector(addGroupMember)];
    
    //从plist文件里获取假数据
    [self getDataSource];
    
    [self sortDataArrayWithContactDataHelper];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GroupMembersCell class]) bundle:nil] forCellReuseIdentifier:@"GroupMembersCell_id"];
}

- (void)addGroupMember{
    NSLog(@"添加！");
}


#pragma mark -- Help Methods
- (void)sortDataArrayWithContactDataHelper{
    
    NSMutableArray *contactsSource = [NSMutableArray arrayWithArray:self.contactsSource];
    [self.contactsSource removeAllObjects];
    [self.sectionTitles removeAllObjects];
    
    self.contactsSource = [ContactDataHelper getFriendListDataBy:contactsSource];
    
    self.sectionTitles = [ContactDataHelper getFriendListSectionBy:[self.contactsSource mutableCopy]];
}
- (void)getDataSource{
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"friendInfo" ofType:@"plist"];
    NSDictionary * friendDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    for (NSString * ID in friendDict) {
        
        NSDictionary * dict = friendDict[ID];
        FriendModel * model = [[FriendModel alloc] init];
        model.nameStr = dict[@"nameStr"];
        model.imageName = dict[@"imageName"];
        [self.contactsSource addObject:model];
        //NSLog(@"%@\n",model.pinyin);
    }
}

- (void)getFoldStateArray{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"fold"] == nil) {
        for (int i = 0; i < self.sectionTitles.count - 1; i++) {
            NSNumber * isHidden = @0;
            [self.foldArray addObject:isHidden];
        }
        NSArray * foldArr = [NSArray arrayWithArray:self.foldArray];
        [[NSUserDefaults standardUserDefaults] setObject:foldArr forKey:@"fold"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        NSArray * foldArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"fold"];
        self.foldArray = [NSMutableArray arrayWithArray:foldArr];
    }
}

- (IBAction)pushOrganizationAction:(id)sender {
    
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GroupMembersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupMembersCell_id" forIndexPath:indexPath];
    
    FriendModel * model = self.contactsSource[indexPath.section][indexPath.row];
    cell.memberNameLab.text = model.nameStr;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.contactsSource[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionTitles.count-1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, view.frame.size.width, 44)];
    lab.text = self.sectionTitles[section +1];
    [view addSubview:lab];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
@end
