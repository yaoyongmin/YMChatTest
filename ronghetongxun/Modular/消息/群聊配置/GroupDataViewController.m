//
//  GroupDataViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/23.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "GroupDataViewController.h"
#import "ApplyJoinViewController.h"
#import <Masonry.h>
@interface GroupDataViewController ()
@property (weak, nonatomic) IBOutlet UILabel *groupNameLab;
@property (weak, nonatomic) IBOutlet UILabel *groupNumberLab;
@property (weak, nonatomic) IBOutlet UIImageView *groupAvatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *foundDateLab;
@property (weak, nonatomic) IBOutlet UIView *membersView;

@end

@implementation GroupDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群聊资料";
    
    [self getGroupInfo];
}

- (void)getGroupInfo{
    
    ///网络请求
    [self setMembersInfo:@[@"",@"",@""]];
}

- (void)setMembersInfo:(NSArray *)members{
    for (int i = 0; i < members.count; i++) {
        CGFloat h = (kScreenWidth()-100) / 9;
        NSInteger count = members.count > 9 ? 9: members.count;
        for (int i =0; i<count; i++) {
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.backgroundColor = [UIColor yellowColor];
            imgView.layer.masksToBounds = YES;
            imgView.layer.cornerRadius = h/2;
            [self.membersView addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.membersView.mas_leading).inset(i*10 + i*h);
                make.width.height.mas_equalTo(h);
                make.centerY.mas_equalTo(self.membersView.mas_centerY);
            }];
        }
    }
}
- (IBAction)JoinGroupChatAction:(id)sender {
    
    ApplyJoinViewController *join = [[ApplyJoinViewController alloc] init];
    
    [self.navigationController pushViewController:join animated:YES];
}

@end
