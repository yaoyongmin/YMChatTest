//
//  AllCallViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/30.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "AllCallViewController.h"
#import "CallLogCell.h"
#import "UIColor+YM.h"
@interface AllCallViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AllCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CallLogCell class]) bundle:nil] forCellReuseIdentifier:@"CallLogCell_id"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    CallLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallLogCell_id" forIndexPath:indexPath];
    
    
    cell.phoneImgView.hidden = !self.isAll;
    
    cell.phoneLab.textColor = self.isAll ? [UIColor ym_colorFromHexString:@"666666"] : [UIColor ym_colorFromHexString:@"#E34141"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.isAll ? 10 : 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}
@end
